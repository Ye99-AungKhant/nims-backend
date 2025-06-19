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

export const updateAccessoryService = async (prisma, { id, type_id, qty }) => {
  const accessory = await prisma.accessory.update({
    where: { id },
    data: {
      type_id: Number(type_id),
      qty: Number(qty),
    },
  });
  return accessory;
};
