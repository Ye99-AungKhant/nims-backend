import prisma from "../config/prisma.js";

export const getPermissionService = async () => {
  const permissions = await prisma.permission.findMany();
  return permissions;
};
