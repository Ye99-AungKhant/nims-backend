import prisma from "../config/prisma.js";

export const createClientService = async (body) => {
  const client = await prisma.client.create({
    data: {
      ...body,
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
      city: true,
      state: true,
      country: true,
      postal: true,
      contact_person: { include: { role: true } },
    },
  });
  return clients;
};

export const updateClientService = async (id, body) => {
  const client = await prisma.client.update({
    where: { id },
    data: {
      ...body,
    },
  });
  return client;
};

export const deleteClientService = async (id) => {
  await prisma.client.delete({ where: { id } });
  return;
};
