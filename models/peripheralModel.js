// import prisma from "../config/prisma.js";

export const createPeripheralService = async (
  prisma,
  {
    device_id,
    sensor_type_id,
    brand_id,
    model_id,
    serial_no,
    qty,
    warranty_plan_id,
    warranty_expiry_date,
  }
) => {
  const peripheral = await prisma.peripheral.create({
    data: {
      device_id,
      sensor_type_id,
      brand_id,
      model_id,
      serial_no,
      qty,
      warranty_plan_id,
      warranty_expiry_date: new Date(warranty_expiry_date),
    },
  });
  return peripheral;
};
