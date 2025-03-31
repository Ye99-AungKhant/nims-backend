// import prisma from "../config/prisma.js";

export const createAccessoryService = async (
  prisma,
  { device_id, type_id, qty }
) => {
  const accessory = await prisma.accessory.create({
    data: {
      device_id,
      type_id,
      qty,
    },
  });
  return accessory;
};
