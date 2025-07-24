// import prisma from "../config/prisma.js";

export const createPeripheralService = async (
  prisma,
  { device_id, sensor_type_id, qty, detail, installed_date }
) => {
  const peripheral = await prisma.peripheral.create({
    data: {
      device_id,
      sensor_type_id,
      qty,
      installed_date: installed_date ? new Date(installed_date) : null, // Handle optional installed_date
      peripheralDetail: {
        create: detail.map((item) => ({
          brand_id: Number(item.brand_id),
          model_id: Number(item.model_id),
          serial_no: item.serial_no,
          warranty_plan_id: Number(item.warranty_plan_id),
        })),
      },
    },
  });
  return peripheral;
};

export const updatePeripheralService = async (
  prisma,
  { id, sensor_type_id, qty, detail, installed_date }
) => {
  await prisma.peripheral.update({
    where: { id },
    data: {
      sensor_type_id,
      qty,
      installed_date: installed_date ? new Date(installed_date) : null, // Handle optional installed_date
    },
  });

  if (detail && detail.length > 0) {
    detail.forEach(async (item) => {
      if (item.id) {
        await prisma.peripheralDetail.update({
          where: { id: item.id },
          data: {
            brand_id: Number(item.brand_id),
            model_id: Number(item.model_id),
            serial_no: item.serial_no,
            warranty_plan_id: Number(item.warranty_plan_id),
          },
        });
      } else {
        await prisma.peripheralDetail.create({
          data: {
            peripheral_id: id,
            brand_id: Number(item.brand_id),
            model_id: Number(item.model_id),
            serial_no: item.serial_no,
            warranty_plan_id: Number(item.warranty_plan_id),
          },
        });
      }
    });
  }

  return;
};

export const peripheralReportService = async (
  prisma,
  { filterType, filterId, search = "", client_id, currentPage, perPage }
) => {
  let where = {};
  let include = {
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
    peripheralDetail: {
      include: {
        brand: true,
        model: true,
        warranty_plan: true,
      },
    },
  };

  if (filterType === "type" && filterId) {
    where.sensor_type_id = Number(filterId);
  }

  // For brand/model, filter through PeripheralDetail
  if ((filterType === "brand" || filterType === "model") && filterId) {
    where.peripheralDetail = {
      some: {
        ...(filterType === "brand" ? { brand_id: Number(filterId) } : {}),
        ...(filterType === "model" ? { model_id: Number(filterId) } : {}),
      },
    };
  }

  if (client_id) {
    where = {
      ...where,
      device: {
        vehicle: {
          ...(where.vehicle || {}),
          client_id: Number(client_id),
        },
      },
    };
  }

  if (search) {
    where = {
      ...where,
      OR: [
        { device: { imei: { contains: search, mode: "insensitive" } } },
        { device: { serial_no: { contains: search, mode: "insensitive" } } },
        {
          device: {
            vehicle: {
              plate_number: { contains: search, mode: "insensitive" },
            },
          },
        },
      ],
    };
  }

  // Count total matching records (for pagination)
  const totalCount = await prisma.peripheral.count({ where });
  const totalPages = Math.ceil(totalCount / perPage);

  // Query paginated data with relations
  const peripherals = await prisma.peripheral.findMany({
    where,
    include,
    orderBy: { id: "desc" },
    skip: (currentPage - 1) * perPage,
    take: perPage,
  });

  // Map the result to show peripheral, type/brand/model, and device/vehicle info
  const data = peripherals.map((per) => ({
    peripheral_id: per.id,
    type: per.type ? { id: per.type.id, name: per.type.name } : null,
    qty: per.qty,
    installed_date: per.installed_date,
    device_id: per.device?.id,
    device_imei: per.device?.imei,
    device_serial_no: per.device?.serial_no,
    vehicle_id: per.device?.vehicle?.id,
    vehicle_plate_number: per.device?.vehicle?.plate_number,
    client: {
      id: per.device?.vehicle?.client?.id,
      name: per.device?.vehicle?.client?.name,
    },
    peripheralDetails: per.peripheralDetail.map((detail) => ({
      id: detail.id,
      brand: detail.brand,
      model: detail.model,
      serial_no: detail.serial_no,
      warranty_plan: detail.warranty_plan,
    })),
  }));

  return {
    data,
    totalCount,
    totalPages,
    currentPage,
    perPage,
  };
};
