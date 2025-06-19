// import prisma from "../config/prisma.js";

export const createPeripheralService = async (
  prisma,
  { device_id, sensor_type_id, qty, detail }
) => {
  const peripheral = await prisma.peripheral.create({
    data: {
      device_id,
      sensor_type_id,
      qty,
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
  { id, sensor_type_id, qty, detail }
) => {
  await prisma.peripheral.update({
    where: { id },
    data: {
      sensor_type_id,
      qty,
    },
  });

  if (detail && detail.length > 0) {
    detail.forEach(async (item) => {
      await prisma.peripheralDetail.update({
        where: { id: item.id },
        data: {
          brand_id: Number(item.brand_id),
          model_id: Number(item.model_id),
          serial_no: item.serial_no,
          warranty_plan_id: Number(item.warranty_plan_id),
        },
      });
    });
  }

  return;
};
