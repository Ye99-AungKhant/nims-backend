// import prisma from "../config/prisma.js";

export const createSimCardService = async (
  prisma,
  { device_id, phone_no, operator }
) => {
  const simCard = await prisma.simCard.create({
    data: {
      device_id,
      phone_no,
      operator,
    },
  });
  return simCard;
};
