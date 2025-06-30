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
