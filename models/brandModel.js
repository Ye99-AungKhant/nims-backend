import prisma from "../config/prisma.js";

export const createBrandService = async (name, type_group) => {
  const brand = await prisma.brand.create({
    data: {
      name,
      type_group,
    },
  });
  return brand;
};

export const getBrandService = async (type_group) => {
  const brands = await prisma.brand.findMany({
    where: { type_group },
  });

  return brands;
};
