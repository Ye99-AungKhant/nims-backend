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

export const getClientWithContactService = async (id, currentPage, perPage) => {
  const whereCondition = {};
  if (id) {
    whereCondition.id = Number(id);
  }

  const queryOptions = {
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
  };

  // Only add pagination if id is not provided
  if (!id) {
    queryOptions.skip = (currentPage - 1) * perPage;
    queryOptions.take = perPage;
  }

  const clients = await prisma.client.findMany(queryOptions);

  const totalCount = id
    ? clients.length // only 1 or 0 result
    : await prisma.client.count();

  const totalPages = id ? 1 : Math.ceil(totalCount / perPage);

  return { clients, totalCount };
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
