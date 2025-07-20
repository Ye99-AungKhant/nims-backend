// import prisma from "../config/prisma.js";

export const createSimCardService = async (
  prisma,
  { device_id, phone_no, operator }
) => {
  const simCard = await prisma.simCard.create({
    data: {
      device_id,
      phone_no,
      operator,
    },
  });
  return simCard;
};

export const updateSimCardService = async (
  prisma,
  { id, phone_no, operator }
) => {
  const simCard = await prisma.simCard.update({
    where: { id },
    data: {
      phone_no,
      operator,
    },
  });
  return simCard;
};

export const simcardReportService = async (
  prisma,
  { operator, search = "", currentPage, perPage }
) => {
  // Build where clause for filtering
  const where = {
    AND: [
      operator ? { operator } : {},
      search
        ? {
            OR: [
              { phone_no: { contains: search, mode: "insensitive" } },
              { device: { imei: { contains: search, mode: "insensitive" } } },
              {
                device: {
                  vehicle: {
                    plate_number: { contains: search, mode: "insensitive" },
                  },
                },
              },
              {
                device: {
                  vehicle: {
                    client: { name: { contains: search, mode: "insensitive" } },
                  },
                },
              },
            ],
          }
        : {},
    ],
  };

  // Count total matching records (for pagination)
  const totalCount = await prisma.simCard.count({ where });
  const totalPages = Math.ceil(totalCount / perPage);

  // Query paginated data with relations
  const simCards = await prisma.simCard.findMany({
    where,
    include: {
      device: {
        include: {
          vehicle: {
            include: {
              client: true,
            },
          },
        },
      },
    },
    orderBy: { id: "desc" },
    skip: (currentPage - 1) * perPage,
    take: perPage,
  });

  // Map the result to show operator, simcard phone_no, GPSDevice info, and Vehicle info
  const data = simCards.map((sim) => ({
    simcard_id: sim.id,
    phone_no: sim.phone_no,
    operator: sim.operator,
    gps_device_id: sim.device?.id,
    gps_device_imei: sim.device?.imei,
    vehicle_id: sim.device?.vehicle?.id,
    vehicle_plate_number: sim.device?.vehicle?.plate_number,
    client: {
      id: sim.device?.vehicle?.client?.id,
      name: sim.device?.vehicle?.client?.name,
    },
  }));

  return {
    data,
    totalCount,
    totalPages,
    currentPage,
    perPage,
  };
};
