import prisma from "../config/prisma.js";

export const loginService = async (username, password) => {
  const user = await prisma.user.findFirst({
    where: { username },
    include: { role: { include: { permissions: true } } },
  });

  //   const passwordMatch = await bcrypt.compare(password, user.password);
  if (user.password !== password) return null;

  return user;
};
