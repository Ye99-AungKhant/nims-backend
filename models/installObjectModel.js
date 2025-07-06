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
        server: { include: { domain: true, extra_server:true } },
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
        ...(toDate && { lte: new Date(toDate) }),
      };

      if (filter_by_date === "installed_date") {
        whereCondition.device.some.server.some.installed_date = dateFilter;
      } else if (filter_by_date === "expire_date") {
        whereCondition.device.some.server.some.expire_date = dateFilter;
      } else if (filter_by_date === "renewal_date") {
        whereCondition.device.some.server.some.renewal_date = dateFilter;
      } else if (filter_by_date === "repair_replacement_date") {
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
              extra_server:{
                include:{
                  type: true,
                  domain: true,
                }
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

  // if (filter_by) {
  //   whereCondition.device = {
  //     some: {
  //       server: {
  //         some: {
  //           status: filter_by,
  //         },
  //       },
  //     },
  //   };
  // }

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
