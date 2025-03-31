import prisma from "../config/prisma.js";

export const createClientService = async (name, address) => {
  const client = await prisma.client.create({
    data: {
      name,
      address,
    },
  });
  return client;
};

export const getClientService = async () => {
  const clients = await prisma.client.findMany({
    select: { id: true, name: true, address: true },
  });
  return clients;
};

export const getClientWithContactService = async (id) => {
  const whereCondition = {};
  if (id) {
    whereCondition.id = Number(id);
  }

  const clients = await prisma.client.findMany({
    where: whereCondition,
    select: {
      id: true,
      name: true,
      address: true,
      contact_person: { include: { role: true } },
    },
  });
  return clients;
};
