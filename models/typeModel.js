import prisma from "../config/prisma.js";

export const createTypeService = async (name, type_group) => {
  const type = await prisma.type.create({
    data: {
      name,
      type_group,
    },
  });

  return type;
};

export const getTypeService = async (type_group) => {
  const types = await prisma.type.findMany({
    where: { type_group },
  });

  return types;
};

export const updateTypeService = async (id, name) => {
  const type = await prisma.type.update({
    where: { id },
    data: { name },
  });
  return type;
};

export const deleteTypeService = async ({ id }) => {
  await prisma.type.delete({
    where: { id },
  });
  return;
};
