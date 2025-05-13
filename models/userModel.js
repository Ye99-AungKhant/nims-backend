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

export const getInstallEngService = async ({ role_id = null }) => {
  const whereCondition = {};
  if (role_id) {
    whereCondition.role_id = role_id;
  }

  const users = await prisma.user.findMany({
    where: whereCondition,
  });

  return users;
};

export const getUsersService = async (currentPage, perPage, search) => {
  const whereCondition = {
    role: {
      canLogin: true,
    },
  };
  if (search) {
    whereCondition.name = {
      contains: search,
      mode: "insensitive", // case-insensitive search
    };
  }

  const queryOptions = {
    where: whereCondition,
    include: { role: true },
  };

  if (!search) {
    queryOptions.skip = (currentPage - 1) * perPage;
    queryOptions.take = perPage;
  }

  const users = await prisma.user.findMany(queryOptions);

  const totalCount = users.length;

  const totalPages = search ? 1 : Math.ceil(totalCount / perPage);

  return { users, totalCount, totalPages };
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

export const userCreateBySuperAdminService = async ({
  name,
  role,
  email,
  phone,
  password,
  username,
}) => {
  const user = await prisma.user.create({
    data: {
      name,
      role_id: role,
      email,
      phone,
      password,
      username,
      canLogin: true,
    },
  });

  return user;
};

export const userUpdateBySuperAdminService = async ({
  id,
  name,
  role,
  email,
  phone,
  password,
  username,
  allow_login,
}) => {
  const user = await prisma.user.update({
    where: { id },
    data: {
      name,
      role_id: role,
      email,
      phone,
      password,
      username,
      canLogin: allow_login,
    },
  });

  return user;
};
