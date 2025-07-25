// import prisma from "../config/prisma.js";

export const createAccessoryService = async (
  prisma,
  { device_id, type_id, qty, installed_date }
) => {
  const accessory = await prisma.accessory.create({
    data: {
      device_id,
      type_id,
      qty,
      installed_date: installed_date ? new Date(installed_date) : null, // Handle optional installed_date
    },
  });
  return accessory;
};

export const updateAccessoryService = async (
  prisma,
  { id, type_id, qty, installed_date }
) => {
  const accessory = await prisma.accessory.update({
    where: { id },
    data: {
      type_id: Number(type_id),
      qty: Number(qty),
      installed_date: installed_date ? new Date(installed_date) : null, // Handle optional installed_date
    },
  });
  return accessory;
};

export const accessoryReportService = async (
  prisma,
  { type_id, search = "", currentPage, perPage, client_id }
) => {
  // Build where clause for filtering
  const where = {
    AND: [
      type_id ? { type_id: type_id } : {},
      client_id
        ? {
            device: {
              vehicle: {
                client_id: Number(client_id),
              },
            },
          }
        : {},
      search
        ? {
            OR: [
              { device: { imei: { contains: search, mode: "insensitive" } } },
              {
                device: {
                  vehicle: {
                    plate_number: { contains: search, mode: "insensitive" },
                  },
                },
              },
            ],
          }
        : {},
    ],
  };

  // Count total matching records (for pagination)
  const totalCount = await prisma.accessory.count({ where });
  const totalPages = Math.ceil(totalCount / perPage);

  // Query paginated data with relations
  const accessories = await prisma.accessory.findMany({
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
      type: true,
    },
    orderBy: { id: "desc" },
    skip: (currentPage - 1) * perPage,
    take: perPage,
  });

  // Map the result to show accessory, device, and vehicle info
  const data = accessories.map((acc) => ({
    accessory_id: acc.id,
    type: acc.type?.name,
    qty: acc.qty,
    installed_date: acc.installed_date,
    device_id: acc.device?.id,
    device_imei: acc.device?.imei,
    vehicle_id: acc.device?.vehicle?.id,
    vehicle_plate_number: acc.device?.vehicle?.plate_number,
    client: {
      id: acc.device?.vehicle?.client?.id,
      name: acc.device?.vehicle?.client?.name,
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
