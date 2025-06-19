// import prisma from "../config/prisma.js";

export const createInstallationEngineerService = async (
  prisma,
  { user_id, server_id, device_repair_replacement_id }
) => {
  const eng = await prisma.installationEngineer.create({
    data: { user_id, server_id, device_repair_replacement_id },
  });
  return eng;
};
