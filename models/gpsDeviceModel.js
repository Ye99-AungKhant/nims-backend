// import prisma from "../config/prisma.js";

export const createGpsDeviceService = async (
  prisma,
  { vehicle_id, brand_id, model_id, imei, serial_no, warranty_plan_id }
) => {
  const gpsDevice = await prisma.gPSDevice.create({
    data: {
      vehicle_id,
      brand_id,
      model_id,
      imei,
      serial_no,
      warranty_plan_id,
    },
  });
  return gpsDevice;
};

export const updateGPSDeviceService = async (
  prisma,
  { id, brand_id, model_id, imei, serial_no, warranty_plan_id }
) => {
  const gpsDevice = await prisma.gPSDevice.update({
    where: { id },
    data: {
      brand_id,
      model_id,
      imei,
      serial_no,
      warranty_plan_id,
    },
  });
  return gpsDevice;
};

export const createExtraGPSDeviceService = async (
  prisma,
  { device_id, brand_id, model_id, imei, serial_no, warranty_plan_id }
) => {
  const gpsDevice = await prisma.extraGPSDevice.create({
    data: {
      device_id,
      brand_id,
      model_id,
      imei,
      serial_no,
      warranty_plan_id,
    },
  });
  return gpsDevice;
};

export const gpsDeviceReportService = async (
  prisma,
  { filterType, filterId, client_id, search = "", currentPage, perPage }
) => {
  // Build where clause for filtering
  let where = {};
  if (filterType === "brand" && filterId) {
    where.brand_id = Number(filterId);
  } else if (filterType === "model" && filterId) {
    where.model_id = Number(filterId);
  }
  // Add filter by client_id if provided
  if (client_id) {
    where = {
      ...where,
      vehicle: {
        ...(where.vehicle || {}),
        client_id: Number(client_id),
      },
    };
  }
  if (search) {
    // If client_id is also present, merge vehicle filter
    where = {
      ...where,
      OR: [
        { imei: { contains: search, mode: "insensitive" } },
        { serial_no: { contains: search, mode: "insensitive" } },
        {
          vehicle: {
            plate_number: { contains: search, mode: "insensitive" },
          },
        },
      ],
    };
  }

  // Count total matching records (for pagination)
  const totalCount = await prisma.gPSDevice.count({ where });
  const totalPages = Math.ceil(totalCount / perPage);

  // Query paginated data with relations
  const gpsDevices = await prisma.gPSDevice.findMany({
    where,
    include: {
      brand: true,
      model: true,
      vehicle: {
        include: {
          client: true,
        },
      },
    },
    orderBy: { id: "desc" },
    skip: (currentPage - 1) * perPage,
    take: perPage,
  });

  // Map the result to show GPS device, brand/model, and vehicle info
  const data = gpsDevices.map((dev) => ({
    gps_device_id: dev.id,
    imei: dev.imei,
    serial_no: dev.serial_no,
    brand: dev.brand ? { id: dev.brand.id, name: dev.brand.name } : null,
    model: dev.model ? { id: dev.model.id, name: dev.model.name } : null,
    vehicle_id: dev.vehicle?.id,
    vehicle_plate_number: dev.vehicle?.plate_number,
    client: {
      id: dev.vehicle?.client?.id,
      name: dev.vehicle?.client?.name,
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
