import prisma from "../config/prisma.js";
import bcrypt from "bcrypt";

export const loginService = async (username, password) => {
  const user = await prisma.user.findFirst({
    where: { username },
    include: { role: { include: { permissions: true } } },
  });

  if (!user) return null;

  const passwordMatch = await bcrypt.compare(password, user.password);
  if (!passwordMatch) return null;

  return user;
};
