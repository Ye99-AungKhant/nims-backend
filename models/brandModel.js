import prisma from "../config/prisma.js";

export const createBrandService = async (name, type_id, type_group) => {
  const brand = await prisma.brand.create({
    data: {
      name,
      type_id,
      type_group,
    },
  });
  return brand;
};

export const getBrandService = async ({ type_id = 0, type_group }) => {
  const brands = await prisma.brand.findMany({
    where: { type_id, type_group },
    include: { type: true },
  });

  return brands;
};

export const updateBrandService = async ({ id, type_id, name }) => {
  const brand = await prisma.brand.update({
    where: { id },
    data: { type_id, name },
  });
  return brand;
};

export const deleteTypeService = async ({ id }) => {
  await prisma.brand.delete({
    where: { id },
  });
  return;
};
