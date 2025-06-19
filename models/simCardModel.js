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

export const updateSimCardService = async (
  prisma,
  { id, phone_no, operator }
) => {
  const simCard = await prisma.simCard.update({
    where: { id },
    data: {
      phone_no,
      operator,
    },
  });
  return simCard;
};
