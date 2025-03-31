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
