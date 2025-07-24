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
  let type;
  if (!type_id && type_group == "Vehicle") {
    typeId = 0;
  } else {
    typeId = type_id;
  }

  const where = {
    type_group,
    type_id: typeId,
  };

  if (type_id) {
    type = await prisma.type.findFirst({
      where: { id: type_id },
    });
  }

  if (type_group == "Server" && type?.name == "Dual") {
    const brands = await prisma.brand.findMany({
      where: { type_group },
      include: { type: true },
    });

    return brands;
  }

  const brands = await prisma.brand.findMany({
    where: where,
    include: { type: true },
  });

  return brands;
};

export const getAllBrandService = async ({ type_group }) => {
  return await prisma.brand.findMany({
    where: { type_group },
  });
};

export const updateBrandService = async ({ id, type_id, name }) => {
  const data = {};
  if (type_id) data.type_id = type_id;
  if (name) data.name = name;
  const brand = await prisma.brand.update({
    where: { id },
    data,
  });
  return brand;
};

export const deleteBrandService = async ({ id }) => {
  await prisma.brand.delete({
    where: { id },
  });
  return;
};
