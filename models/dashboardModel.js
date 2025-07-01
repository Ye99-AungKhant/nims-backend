import dayjs from "dayjs";
import prisma from "./../config/prisma.js";
import { log } from "console";

const now = new Date();
const currentYear = now.getFullYear();

export const getDashboardDataService = async (filterYear) => {
  const totalObjects = await prisma.vehicle.count();
  const totalActiveObjects = await prisma.server.count({
    where: { status: "Active" },
  });
  const totalExpireSoonObjects = await prisma.server.count({
    where: { status: "ExpireSoon" },
  });
  const totalExpiredObjects = await prisma.server.count({
    where: { status: "Expired" },
  });
  const totalClients = await prisma.client.count();

  const year = parseInt(filterYear) || dayjs().year();

  const startDate = dayjs(`${year}-01-01`).startOf("year").toDate();
  const endDate = dayjs(`${year}-12-31`).endOf("year").toDate();

  const servers = await prisma.server.findMany({
    where: {
      OR: [
        {
          installed_date: {
            gte: startDate,
            lte: endDate,
          },
        },
        {
          expire_date: {
            gte: startDate,
            lte: endDate,
          },
        },
      ],
    },
    select: {
      installed_date: true,
      expire_date: true,
      server_activity: {
        where: { renewal_date: { not: null } },
        select: { renewal_date: true },
      },
    },
  });

  // Fetch repair and replacement data
  const deviceRepairs = await prisma.deviceRepairReplacement.findMany({
    where: {
      repair_replacement_date: {
        gte: startDate,
        lte: endDate,
      },
      type: { in: ["Repair", "Replacement"] },
    },
    select: {
      repair_replacement_date: true,
      type: true,
    },
  });

  const monthlyStats = {};
  //   console.log(servers);

  for (const server of servers) {
    const installMonth = dayjs(server.installed_date).format("MMM YYYY");
    const expireMonth = dayjs(server.expire_date).format("MMM YYYY");

    // Count installed
    if (dayjs(server.installed_date).year() === year) {
      monthlyStats[installMonth] ??= {
        Installed: 0,
        Expired: 0,
        Renewal: 0,
        Repair: 0,
        Replacement: 0,
      };
      monthlyStats[installMonth].Installed++;
    }

    // Count expired
    if (dayjs(server.expire_date).year() === year) {
      monthlyStats[expireMonth] ??= {
        Installed: 0,
        Expired: 0,
        Renewal: 0,
        Repair: 0,
        Replacement: 0,
      };
      monthlyStats[expireMonth].Expired++;
    }

    // Count renewals
    for (const activity of server.server_activity) {
      if (
        activity.renewal_date &&
        dayjs(activity.renewal_date).year() === year
      ) {
        const renewalMonth = dayjs(activity.renewal_date).format("MMM YYYY");
        monthlyStats[renewalMonth] ??= {
          Installed: 0,
          Expired: 0,
          Renewal: 0,
          Repair: 0,
          Replacement: 0,
        };
        monthlyStats[renewalMonth].Renewal++;
      }
    }
  }

  // Add repair and replacement stats
  for (const record of deviceRepairs) {
    const month = dayjs(record.repair_replacement_date).format("MMM YYYY");
    monthlyStats[month] ??= {
      Installed: 0,
      Expired: 0,
      Renewal: 0,
      Repair: 0,
      Replacement: 0,
    };
    if (record.type === "Repair") {
      monthlyStats[month].Repair++;
    } else if (record.type === "Replacement") {
      monthlyStats[month].Replacement++;
    }
  }

  const monthlyData = Object.entries(monthlyStats)
    .sort(
      ([a], [b]) => new Date(`1 ${a}`).getTime() - new Date(`1 ${b}`).getTime()
    )
    .map(([month, values]) => ({ month, ...values }));

  const uniqueBrands = await prisma.gPSDevice.findMany({
    distinct: ["brand_id"],
    select: { brand: true },
  });
  console.log("Unique Brands:", uniqueBrands);

  const brandCount = uniqueBrands.length;

  // Count unique models
  const uniqueModels = await prisma.gPSDevice.findMany({
    distinct: ["model_id"],
    select: { model: true },
  });
  const modelCount = uniqueModels.length;

  const domainIdCounts = await prisma.server.groupBy({
    by: ["domain_id"],
    _count: { domain_id: true },
  });
  log("Domain ID Counts:", domainIdCounts);

  const domainIds = domainIdCounts.map((item) => item.domain_id);

  const domainBrands = await prisma.brand.findMany({
    where: { id: { in: domainIds } },
    select: {
      id: true,
      name: true,
    },
  });

  const domainMap = new Map();

  domainIdCounts.forEach((countItem) => {
    const domain = domainBrands.find((d) => d.id === countItem.domain_id);
    const domainName = domain?.name;

    if (!domainName) return;

    if (domainMap.has(domainName)) {
      domainMap.get(domainName).count += countItem._count.domain_id;
    } else {
      domainMap.set(domainName, {
        domain_id: countItem.domain_id,
        domain_name: domainName,
        count: countItem._count.domain_id,
      });
    }
  });

  const usedServer = Array.from(domainMap.values());

  const peripheralType = await prisma.type.count({
    where: { type_group: "Sensor" },
  });

  const peripheralBrand = await prisma.brand.count({
    where: { type_group: "Sensor" },
  });

  const peripheralModel = await prisma.model.count({
    where: { type_group: "Sensor" },
  });

  const accessoryCount = await prisma.type.count({
    where: { type_group: "Accessory" },
  });

  const simCardCount = await prisma.brand.count({
    where: { type_group: "Operator" },
  });

  const totalObjectBaseFees = await prisma.server.aggregate({
    where: { status: "Active" },
    _sum: { object_base_fee: true },
  });

  return {
    totalObjects,
    totalActiveObjects,
    totalExpireSoonObjects,
    totalExpiredObjects,
    totalClients,
    monthlyData,
    brandCount,
    modelCount,
    usedServer,
    accessoryCount,
    simCardCount,
    peripheralCount: {
      type: peripheralType,
      brand: peripheralBrand,
      model: peripheralModel,
    },
    totalObjectBaseFees: totalObjectBaseFees._sum.object_base_fee || 0,
  };
};

export const getGPSUsageService = async () => {
  const gpsBrandUsage = await prisma.brand.findMany({
    where: {
      type_group: "GPS",
    },
    select: {
      id: true,
      name: true,
      gps_device: {
        select: {
          id: true,
        },
      },
      model: {
        select: {
          id: true,
          name: true,
          gps_device: {
            select: {
              id: true,
            },
          },
        },
      },
    },
  });

  const gpsUsageResult = gpsBrandUsage.map((brand) => ({
    brandId: brand.id,
    brandName: brand.name,
    brandUsedCount: brand.gps_device.length,
    models: brand.model.map((model) => ({
      modelId: model.id,
      modelName: model.name,
      modelUsedCount: model.gps_device.length,
    })),
  }));

  // const gpsModelUsage = await prisma.model.findMany({
  //   where: {
  //     type_group: "GPS",
  //   },
  //   select: {
  //     id: true,
  //     name: true,
  //     gPSDevice: {
  //       select: {
  //         id: true,
  //       },
  //     },
  //   },
  // });
  // const gpsModelUsageResult = gpsModelUsage.map((model) => ({
  //   modelId: model.id,
  //   modelName: model.name,
  //   usedCount: model.gPSDevice.length,
  // }));

  return {
    gpsUsage: gpsUsageResult,
  };
};

export const getPeripheralUsageService = async () => {
  const peripheralTypeUsage = await prisma.type.findMany({
    where: {
      type_group: "Sensor",
    },
    select: {
      id: true,
      name: true,
      peripheral: {
        where: { status: "Active" },
        select: {
          id: true,
        },
      },
      brand: {
        select: {
          id: true,
          name: true,
          peripheralDetail: {
            select: {
              id: true,
            },
          },
          model: {
            select: {
              id: true,
              name: true,
              peripheralDetail: {
                select: {
                  id: true,
                },
              },
            },
          },
        },
      },
    },
  });

  const peripheralTypeUsageResult = peripheralTypeUsage.map((type) => ({
    typeId: type.id,
    typeName: type.name,
    typeUsedCount: type.peripheral.length,
    brands: type.brand.map((brand) => ({
      brandId: brand.id,
      brandName: brand.name,
      brandUsedCount: brand.peripheralDetail.length,
      models: brand.model.map((model) => ({
        modelId: model.id,
        modelName: model.name,
        modelUsedCount: model.peripheralDetail.length,
      })),
    })),
  }));

  return {
    peripheralUsage: peripheralTypeUsageResult,
  };
};

export const getAccessoryUsageService = async () => {
  const accessoryTypeUsage = await prisma.type.findMany({
    where: {
      type_group: "Accessory",
    },
    select: {
      id: true,
      name: true,
      accessory: {
        select: {
          id: true,
        },
      },
    },
  });

  const accessoryTypeUsageResult = accessoryTypeUsage.map((type) => ({
    typeId: type.id,
    typeName: type.name,
    usedCount: type.accessory.length,
  }));

  return {
    accessoryTypeUsage: accessoryTypeUsageResult,
  };
};

export const getSimCardUsageService = async () => {
  const simCardBrand = await prisma.brand.findMany({
    where: {
      type_group: "Operator",
    },
    select: {
      id: true,
      name: true,
    },
  });

  const simCards = await prisma.simCard.findMany({
    select: {
      id: true,
      operator: true,
    },
  });

  const simCardBrandUsageResult = simCardBrand.map((brand) => {
    const usedCount = simCards.filter(
      (sim) => sim.operator === brand.name
    ).length;
    return {
      brandId: brand.id,
      brandName: brand.name,
      usedCount,
    };
  });

  return {
    simCardBrandUsage: simCardBrandUsageResult,
  };
};

export const getObjectFeeService = async () => {
  // Get all clients with their vehicles, each vehicle's GPSDevice, and each GPSDevice's server
  const clients = await prisma.client.findMany({
    select: {
      id: true,
      name: true,
      vehicle: {
        select: {
          id: true,
          plate_number: true,
          device: {
            select: {
              id: true,
              server: {
                where: { status: "Active" },
                select: {
                  object_base_fee: true,
                },
              },
            },
          },
        },
      },
    },
  });

  const result = clients.map((client) => {
    let total_object_base_fee = 0;
    const objects = [];
    for (const vehicle of client.vehicle) {
      // Sum all object_base_fee for all servers of all GPS devices for this vehicle
      let vehicleFee = 0;
      for (const gps of vehicle.device) {
        for (const server of gps.server) {
          if (typeof server.object_base_fee === "number") {
            vehicleFee += server.object_base_fee;
          }
        }
      }
      total_object_base_fee += vehicleFee;
      objects.push({
        vehicle_plate_no: vehicle.plate_number,
        object_base_fee: vehicleFee,
      });
    }
    return {
      client_id: client.id,
      client_name: client.name,
      total_object_base_fee,
      objects,
    };
  });

  return result;
};
