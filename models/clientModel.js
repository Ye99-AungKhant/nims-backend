import prisma from "../config/prisma.js";

export const createClientService = async (body) => {
  const client = await prisma.client.create({
    data: {
      ...body,
    },
  });
  return client;
};

export const getClientService = async (search) => {
  const whereCondition = {};
  if (search) {
    console.log(search);

    whereCondition.name = {
      contains: search,
      mode: "insensitive",
    };
  }

  const clients = await prisma.client.findMany({
    where: whereCondition,
    select: { id: true, name: true, address: true },
  });
  return clients;
};

export const getClientWithContactService = async (
  id,
  currentPage,
  perPage,
  search,
  criteria
) => {
  const whereCondition = {};
  if (id) {
    whereCondition.id = Number(id);
  }

  if (search || criteria) {
    whereCondition.name = {
      contains:
        search && criteria ? `${search} ${criteria}` : search || criteria,
      mode: "insensitive", // case-insensitive search
    };
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
  const isParams = id || search || criteria;
  if (!isParams) {
    queryOptions.skip = (currentPage - 1) * perPage;
    queryOptions.take = perPage;
  }

  const clients = await prisma.client.findMany(queryOptions);

  const totalCount = isParams
    ? clients.length // only 1 or 0 result
    : await prisma.client.count();

  const totalPages = isParams ? 1 : Math.ceil(totalCount / perPage);

  return { clients, totalCount, totalPages };
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

export const getClientObjectService = async (id) => {
  const totalObjects = await prisma.vehicle.count({
    where: { client_id: id },
  });

  const totalVehicles = await prisma.vehicle.findMany({
    where: { client_id: id },
    select: { id, device: true },
  });
  const totalVehiclesData = totalVehicles
    .map((vehicle) => vehicle.device.map((gpsdevice) => gpsdevice.id))
    .flatMap((device) => device);

  const totalActiveObjects = await prisma.server.count({
    where: {
      status: "Active",
      gps_device_id: {
        in: totalVehiclesData,
      },
    },
  });
  const totalExpireSoonObjects = await prisma.server.count({
    where: {
      status: "ExpireSoon",
      gps_device_id: {
        in: totalVehiclesData,
      },
    },
  });
  const totalExpiredObjects = await prisma.server.count({
    where: {
      status: "Expired",
      gps_device_id: {
        in: totalVehiclesData,
      },
    },
  });
  return {
    totalObjects,
    totalActiveObjects,
    totalExpireSoonObjects,
    totalExpiredObjects,
  };
};

export const deleteClientService = async (id) => {
  await prisma.client.delete({ where: { id } });
  return;
};
