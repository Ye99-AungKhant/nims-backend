// import prisma from "../config/prisma.js";

export const createInstallationEngineerService = async (
  prisma,
  { user_id, server_id }
) => {
  const eng = await prisma.installationEngineer.create({
    data: { user_id, server_id },
  });
  return eng;
};
