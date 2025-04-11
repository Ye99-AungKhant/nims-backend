import prisma from "../config/prisma.js";

export const loginService = async (username, password) => {
  const user = await prisma.user.findFirst({
    where: { email: username },
    include: { role: true },
  });

  if (!user || user.role.name !== "Admin") return null;

  //   const passwordMatch = await bcrypt.compare(password, user.password);
  if (user.password !== password) return null;

  return user;
};
