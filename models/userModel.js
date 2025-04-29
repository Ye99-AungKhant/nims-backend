import prisma from "../config/prisma.js";

export const userCreateService = async ({
  name,
  role_id,
  phone = null,
  email = null,
}) => {
  const user = await prisma.user.create({
    data: {
      name,
      role_id,
      phone,
      email,
    },
  });
  return user;
};

export const getUsersService = async ({ role_id = null }) => {
  const whereCondition = {};
  if (role_id) {
    whereCondition.role_id = role_id;
  }

  const users = await prisma.user.findMany({
    where: whereCondition,
  });

  return users;
};

export const updateUserService = async (id, name) => {
  const user = await prisma.user.update({
    where: { id },
    data: { name },
  });

  return user;
};

export const deleteUserService = async ({ id }) => {
  const user = await prisma.user.delete({
    where: { id },
  });
  return user;
};
