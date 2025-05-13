import prisma from "../config/prisma.js";

export const getInstalledObjectService = async (
  filterByExpireDate = false,
  currentYear,
  currentMonth,
  id,
  currentPage,
  perPage,
  search,
  filter_by,
  fromDate,
  toDate
) => {
  const whereCondition = {};
  let includeData = {
    client: { include: { contact_person: true } },
    device: {
      include: {
        server: { include: { domain: true } },
      },
    },
  };

  if (filterByExpireDate) {
    whereCondition.device = {
      some: {
        server: {
          some: {
            expire_date: {
              gte: new Date(currentYear, 0, 1),
              lt: new Date(currentYear, currentMonth + 1, 1),
            },
          },
        },
      },
    };
  }

  // Apply date range filter based on filter_by
  if (filter_by && fromDate) {
    const dateFilter = {
      gte: new Date(fromDate),
      ...(toDate && { lte: new Date(toDate) }),
    };

    if (!whereCondition.device) whereCondition.device = { some: {} };
    if (!whereCondition.device.some.server)
      whereCondition.device.some.server = { some: {} };

    if (filter_by === "installed_date") {
      whereCondition.device.some.server.some.installed_date = dateFilter;
    } else if (filter_by === "expire_date") {
      whereCondition.device.some.server.some.expire_date = dateFilter;
    }
  }

  if (id) {
    whereCondition.id = Number(id);
    includeData = {
      type: true,
      brand: { include: { model: true } },
      client: { include: { contact_person: { include: { role: true } } } },
      device: {
        include: {
          brand: { include: { model: true } },
          warranty_plan: true,
          simcard: true,
          peripheral: {
            include: {
              type: true,
              peripheralDetail: {
                include: { brand: true, model: true, warranty_plan: true },
              },
            },
          },
          accessory: { include: { type: true } },
          server: {
            include: {
              type: true,
              domain: true,
              warranty_plan: true,
              installation_engineer: true,
            },
          },
        },
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
        device: {
          some: {
            imei: {
              contains: search,
              mode: "insensitive",
            },
          },
        },
      },
    ];
  }

  const queryOptions = {
    where: whereCondition,
    include: includeData,
  };

  const isParams = id || search;
  if (!isParams) {
    queryOptions.skip = (currentPage - 1) * perPage;
    queryOptions.take = perPage;
  }

  const data = await prisma.vehicle.findMany(queryOptions);

  const totalCount = isParams
    ? data.length // only 1 or 0 result
    : await prisma.vehicle.count();

  const totalPages = isParams ? 1 : Math.ceil(totalCount / perPage);

  await updateInstallObjectStatusService(currentYear, currentMonth);

  return { data, totalCount, totalPages };
};

// export const updateInstallObjectStatusService = async (
//   currentYear,
//   currentMonth
// ) => {
//   const data = await prisma.server.findMany({
//     where: {
//       expire_date: {
//         gte: new Date(currentYear, 0, 1), // Jan 1st of current year
//         lt: new Date(currentYear, currentMonth + 1, 1), // Before next month
//       },
//     },
//   });

//   if (data.length === 0) return;

//   const ids = data.map((item) => item.id);

//   // Bulk update status to "Expired"
//   await prisma.server.updateMany({
//     where: {
//       id: { in: ids },
//     },
//     data: {
//       status: "ExpireSoon",
//     },
//   });

//   return data;
// };

export const updateInstallObjectStatusService = async (
  currentYear,
  currentMonth
) => {
  const today = new Date();
  const startOfYear = new Date(currentYear, 0, 1);
  const startOfNextMonth = new Date(currentYear, currentMonth + 1, 1);
  const todayStart = new Date(today.setHours(0, 0, 0, 0));
  const todayEnd = new Date(today.setHours(23, 59, 59, 999));

  // Find servers that expire this year and before next month (ExpireSoon)
  const expireSoonData = await prisma.server.findMany({
    where: {
      expire_date: {
        gte: startOfYear,
        lt: startOfNextMonth,
      },
    },
  });

  // console.log("expireSoonData", expireSoonData);

  // Find servers that expire today (Expired)
  const expiredTodayData = await prisma.server.findMany({
    where: {
      expire_date: {
        gte: todayStart,
        lte: todayEnd,
      },
    },
  });

  // Bulk update ExpireSoon
  if (expireSoonData.length > 0) {
    const expireSoonIds = expireSoonData.map((item) => item.id);
    await prisma.server.updateMany({
      where: { id: { in: expireSoonIds } },
      data: { status: "ExpireSoon" },
    });
  }

  // Bulk update Expired
  if (expiredTodayData.length > 0) {
    const expiredTodayIds = expiredTodayData.map((item) => item.id);
    await prisma.server.updateMany({
      where: { id: { in: expiredTodayIds } },
      data: { status: "Expired" },
    });
  }

  return {
    expireSoon: expireSoonData,
    expiredToday: expiredTodayData,
  };
};
