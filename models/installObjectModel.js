import prisma from "../config/prisma.js";

export const getInstalledObjectService = async (
  filterByExpireDate = false,
  currentYear,
  currentMonth,
  id,
  currentPage,
  perPage,
  search
) => {
  const whereCondition = filterByExpireDate
    ? {
        device: {
          some: {
            server: {
              some: {
                expire_date: {
                  gte: new Date(currentYear, 0, 1), // From Jan 1st of the current year
                  lt: new Date(currentYear, currentMonth + 1, 1), // Before the current month
                },
              },
            },
          },
        },
      }
    : {};

  if (id) {
    whereCondition.id = Number(id);
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
    include: {
      client: { include: { contact_person: true } },
      device: {
        include: {
          server: { include: { domain: true } },
        },
      },
    },
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

  return { data, totalCount, totalPages };
};
