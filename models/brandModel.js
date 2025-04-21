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

export const getBrandService = async ({ type_id, type_group }) => {
  let typeId;
  if (!type_id && type_group == "Vehicle") {
    typeId = 0;
  } else {
    typeId = type_id;
  }

  const where = {
    type_group,
    type_id: typeId,
  };

  const brands = await prisma.brand.findMany({
    where: where,
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

export const deleteBrandService = async ({ id }) => {
  await prisma.brand.delete({
    where: { id },
  });
  return;
};
