import prisma from "../config/prisma.js";

export const createModelService = async (name, type_group, brand_id) => {
  const model = await prisma.model.create({
    data: {
      brand_id,
      name,
      type_group,
    },
  });
  return model;
};

export const getModelService = async (type_group, brand_id) => {
  const whereCondition = { type_group };
  if (brand_id) {
    whereCondition.brand_id = Number(brand_id);
  }
  const models = await prisma.model.findMany({
    where: whereCondition,
    include: { brand: true },
  });
  return models;
};

export const getAllModelService = async (type_group) => {
  return await prisma.model.findMany({
    where: { type_group },
  });
};

export const updateModelService = async ({ id, brand_id, name }) => {
  const model = await prisma.model.update({
    where: { id },
    data: { brand_id, name },
  });
  return model;
};

export const deleteModelService = async ({ id }) => {
  await prisma.model.delete({
    where: { id },
  });
  return;
};
