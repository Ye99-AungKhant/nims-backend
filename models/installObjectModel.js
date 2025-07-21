import prisma from "../config/prisma.js";

export const getInstalledObjectService = async (
  id,
  currentPage,
  perPage,
  search,
  filter_by_date,
  filter_by,
  fromDate,
  toDate,
  client_id
) => {
  let whereCondition = {};
  let includeData = {
    client: { include: { contact_person: true } },
    device: {
      include: {
        server: { include: { domain: true, extra_server: true } },
        replacements: true,
        simcard: true,
      },
      orderBy: { createdAt: "asc" },
    },
  };

  if (filter_by || (filter_by_date && fromDate)) {
    if (!whereCondition.device) {
      whereCondition.device = { some: {} };
    }

    if (!whereCondition.device.some.server) {
      whereCondition.device.some.server = { some: {} };
    }

    // Apply status filter
    if (filter_by) {
      whereCondition.device.some.server.some.status = filter_by;
    }

    // Apply date range filter
    if (filter_by_date && fromDate) {
      const dateFilter = {
        gte: new Date(fromDate),
        ...(toDate && {
          lte: new Date(new Date(toDate).setHours(23, 59, 59, 999)),
        }),
      };

      if (filter_by_date === "installed_date") {
        whereCondition.device.some.server.some.installed_date = dateFilter;
      } else if (filter_by_date === "expire_date") {
        whereCondition.device.some.server.some.expire_date = dateFilter;
      } else if (filter_by_date === "renewal_date") {
        // Combine both conditions in a single .some with AND array
        const year = new Date(fromDate).getFullYear();
        whereCondition.device.some.server.some = {
          renewal_date: dateFilter,
        };
      } else if (filter_by_date === "repair_date") {
        // Filter by repair date in DeviceRepairReplacement
        if (!whereCondition.device.some.replacements) {
          whereCondition.device.some.replacements = { some: {} };
        }
        whereCondition.device.some.replacements.some.type = "Repair";
        whereCondition.device.some.replacements.some.repair_replacement_date =
          dateFilter;
      } else if (filter_by_date === "replacement_date") {
        // Filter by replacement date in DeviceRepairReplacement
        if (!whereCondition.device.some.replacements) {
          whereCondition.device.some.replacements = { some: {} };
        }
        whereCondition.device.some.replacements.some.type = "Replacement";
        whereCondition.device.some.replacements.some.repair_replacement_date =
          dateFilter;
      }
    }
  }

  if (id) {
    whereCondition.id = Number(id);

    includeData = {
      type: true,
      brand: true,
      model: true,
      client: { include: { contact_person: { include: { role: true } } } },
      device: {
        include: {
          brand: true,
          model: true,
          warranty_plan: true,
          simcard: { where: { status: "Active" } },
          peripheral: {
            where: { status: "Active" },
            include: {
              type: true,
              peripheralDetail: {
                include: { brand: true, model: true, warranty_plan: true },
              },
            },
          },
          accessory: { where: { status: "Active" }, include: { type: true } },
          server: {
            include: {
              type: true,
              domain: true,
              warranty_plan: true,
              installation_engineer: true,
              extra_server: {
                include: {
                  type: true,
                  domain: true,
                },
              },
              server_activity: {
                include: {
                  type: true,
                  domain: true,
                  warranty_plan: true,
                },
              },
              install_image: true,
            },
          },
        },
        orderBy: { createdAt: "asc" },
      },
    };
  }

  if (search) {
    whereCondition.OR = [
      {
        plate_number: {
          contains: search,
          mode: "insensitive",
        },
      },
      {
        client: {
          contact_person: {
            some: {
              name: {
                contains: search,
                mode: "insensitive",
              },
            },
          },
        },
      },
      {
        client: {
          contact_person: {
            some: {
              phone: {
                contains: search,
                mode: "insensitive",
              },
            },
          },
        },
      },
      {
        device: {
          some: {
            imei: {
              contains: search,
              mode: "insensitive",
            },
          },
        },
      },
      {
        client: {
          name: {
            contains: search,
            mode: "insensitive",
          },
        },
      },
      {
        device: {
          some: {
            simcard: {
              some: {
                phone_no: {
                  contains: search,
                  mode: "insensitive",
                },
              },
            },
          },
        },
      },
    ];
  }

  if (client_id) {
    const totalVehicles = await prisma.vehicle.findMany({
      where: { client_id: Number(client_id) },
      select: {
        id: true,
        device: {
          select: {
            id: true,
          },
        },
      },
    });
    const totalVehiclesData = totalVehicles
      .map((vehicle) => vehicle.device.map((gpsdevice) => gpsdevice.id))
      .flatMap((device) => device);

    whereCondition.device = {
      some: {
        server: {
          some: {
            status: filter_by,
            gps_device_id: {
              in: totalVehiclesData,
            },
          },
        },
      },
    };
  }

  const queryOptions = {
    where: whereCondition,
    include: includeData,
    orderBy: {
      id: "desc", // or 'asc'
    },
  };

  const isParams = id;
  if (!isParams) {
    queryOptions.skip = (currentPage - 1) * perPage;
    queryOptions.take = perPage;
  }

  let data = await prisma.vehicle.findMany(queryOptions);

  const totalCount = isParams
    ? data.length // only 1 or 0 result
    : await prisma.vehicle.count({ where: whereCondition });

  const totalPages = isParams ? 1 : Math.ceil(totalCount / perPage);

  if (id) {
    const photos = data[0].device.flatMap(
      (gpsDevice) => gpsDevice.server?.[0]?.install_image ?? []
    );

    const grouped = photos.reduce(
      (acc, photo) => {
        const type = photo.type?.toLowerCase();

        if (type === "installed") {
          acc.installed.push(photo);
        } else if (type === "replacement") {
          acc.replacement.push(photo);
        } else if (type === "repair") {
          acc.repair.push(photo);
        } else if (type === "vehiclechange") {
          acc.vehicleChange.push(photo);
        }
        return acc;
      },
      { repair: [], replacement: [], installed: [], vehicleChange: [] } // default group structure
    );

    data[0].install_image = grouped;
  }

  if (!id) {
    const transformedData = data.map((item) => {
      let deviceImei = null;

      for (const device of item.device) {
        if (device.status === "Active") {
          deviceImei = device.imei;
          break;
        }
      }

      return {
        ...item,
        device_imei: deviceImei,
      };
    });

    data = transformedData;
  }

  await updateInstallObjectStatusService();
  // console.log(data);

  return { data, totalCount, totalPages };
};

export const updateInstallObjectStatusService = async () => {
  const today = new Date();
  const todayEnd = new Date(today.setHours(23, 59, 59, 999));

  const expireSoonEnd = new Date(today);
  expireSoonEnd.setMonth(expireSoonEnd.getMonth() + 1); // 1 month ahead from today

  // Find Expired: expire_date before today
  const expiredData = await prisma.server.findMany({
    where: {
      expire_date: {
        lte: todayEnd,
      },
    },
  });

  // Find Expire Soon: between today and one month from today
  const expireSoonData = await prisma.server.findMany({
    where: {
      expire_date: {
        gt: today,
        lt: expireSoonEnd,
      },
    },
  });

  const activeData = await prisma.server.findMany({
    where: {
      expire_date: {
        gte: expireSoonEnd,
      },
    },
  });

  // Update Expired
  if (expiredData.length > 0) {
    const expiredIds = expiredData.map((item) => item.id);
    await prisma.server.updateMany({
      where: { id: { in: expiredIds } },
      data: { status: "Expired" },
    });
  }

  // Update Expire Soon
  if (expireSoonData.length > 0) {
    const expireSoonIds = expireSoonData.map((item) => item.id);
    await prisma.server.updateMany({
      where: { id: { in: expireSoonIds } },
      data: { status: "ExpireSoon" },
    });
  }

  if (activeData.length > 0) {
    const activeIds = activeData.map((item) => item.id);
    await prisma.server.updateMany({
      where: { id: { in: activeIds } },
      data: { status: "Active" },
    });
  }

  return {
    expiredData,
    expireSoon: expireSoonData,
  };
};

export const deleteInstallObjectService = async ({ vehicleId }) => {
  return await prisma.$transaction(async (tx) => {
    // 1. Find all GPSDevice(s) for the vehicle
    const gpsDevices = await tx.gPSDevice.findMany({
      where: { vehicle_id: vehicleId },
      select: { id: true },
    });
    const gpsDeviceIds = gpsDevices.map((d) => d.id);

    // 2. Find all DeviceRepairReplacement(s) for these GPSDevice(s)
    const deviceRepairs = await tx.deviceRepairReplacement.findMany({
      where: { original_gps_id: { in: gpsDeviceIds } },
      select: { id: true },
    });
    const deviceRepairIds = deviceRepairs.map((d) => d.id);

    // 3. Delete related InstallImage, InstallationEngineer, ComponentReplacement for DeviceRepairReplacement
    await tx.installImage.deleteMany({
      where: { device_repair_replacement_id: { in: deviceRepairIds } },
    });
    await tx.installationEngineer.deleteMany({
      where: { device_repair_replacement_id: { in: deviceRepairIds } },
    });
    await tx.componentReplacement.deleteMany({
      where: { device_replacement_id: { in: deviceRepairIds } },
    });

    // 4. Delete DeviceRepairReplacement
    await tx.deviceRepairReplacement.deleteMany({
      where: { id: { in: deviceRepairIds } },
    });

    // 5. For each GPSDevice, delete related models
    // SimCard (and related ComponentReplacement)
    const simCards = await tx.simCard.findMany({
      where: { device_id: { in: gpsDeviceIds } },
      select: { id: true },
    });
    const simCardIds = simCards.map((s) => s.id);
    await tx.componentReplacement.deleteMany({
      where: {
        OR: [
          { original_simcard_id: { in: simCardIds } },
          { replacement_simcard_id: { in: simCardIds } },
        ],
      },
    });
    await tx.simCard.deleteMany({ where: { id: { in: simCardIds } } });

    // Peripheral (and PeripheralDetail, ComponentReplacement)
    const peripherals = await tx.peripheral.findMany({
      where: { device_id: { in: gpsDeviceIds } },
      select: { id: true },
    });
    const peripheralIds = peripherals.map((p) => p.id);
    await tx.peripheralDetail.deleteMany({
      where: { peripheral_id: { in: peripheralIds } },
    });
    await tx.componentReplacement.deleteMany({
      where: {
        OR: [
          { original_peripheral_id: { in: peripheralIds } },
          { replacement_peripheral_id: { in: peripheralIds } },
        ],
      },
    });
    await tx.peripheral.deleteMany({ where: { id: { in: peripheralIds } } });

    // Accessory (and ComponentReplacement)
    const accessories = await tx.accessory.findMany({
      where: { device_id: { in: gpsDeviceIds } },
      select: { id: true },
    });
    const accessoryIds = accessories.map((a) => a.id);
    await tx.componentReplacement.deleteMany({
      where: {
        OR: [
          { original_accessory_id: { in: accessoryIds } },
          { replacement_accessory_id: { in: accessoryIds } },
        ],
      },
    });
    await tx.accessory.deleteMany({ where: { id: { in: accessoryIds } } });

    // Server (and ServerActivity, InstallImage, InstallationEngineer, ExtraServer)
    const servers = await tx.server.findMany({
      where: { gps_device_id: { in: gpsDeviceIds } },
      select: { id: true },
    });
    const serverIds = servers.map((s) => s.id);
    await tx.serverActivity.deleteMany({
      where: { server_id: { in: serverIds } },
    });
    await tx.installImage.deleteMany({
      where: { server_id: { in: serverIds } },
    });
    await tx.installationEngineer.deleteMany({
      where: { server_id: { in: serverIds } },
    });
    await tx.extraServer.deleteMany({
      where: { server_id: { in: serverIds } },
    });
    await tx.server.deleteMany({ where: { id: { in: serverIds } } });

    // ExtraGPSDevice
    await tx.extraGPSDevice.deleteMany({
      where: { device_id: { in: gpsDeviceIds } },
    });

    // 6. Delete GPSDevice(s)
    await tx.gPSDevice.deleteMany({ where: { id: { in: gpsDeviceIds } } });

    // 7. Delete Vehicle
    await tx.vehicle.delete({ where: { id: vehicleId } });

    return { success: true };
  });
};
