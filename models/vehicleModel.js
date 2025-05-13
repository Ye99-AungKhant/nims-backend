// import prisma from "../config/prisma.js";

export const createVehicleService = async (
  prisma,
  { client_id, plate_number, type_id, brand_id, model_id, year, odometer }
) => {
  const vehicle = await prisma.vehicle.create({
    data: {
      client_id,
      plate_number,
      type_id,
      brand_id,
      model_id,
      year,
      odometer,
    },
  });
  return vehicle;
};

export const getVehicleService = async (type_id) => {
  const vehicles = await prisma.vehicle.findMany({
    where: { type_id },
    include: {
      brand: {
        include: {
          model: true,
        },
      },
    },
  });
  return vehicles;
};
