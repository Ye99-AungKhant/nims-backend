// import prisma from "../config/prisma.js";

export const createVehicleService = async (
  prisma,
  data
  // { client_id, plate_number, type_id, brand_id, model_id, year, odometer }
) => {
  const vehicle = await prisma.vehicle.create({ data });
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

export const vehicleChangeService = async (prisma, data) => {
  const vehicleActivity = await prisma.vehicleActivity.create({
    data: {
      vehicle_id: data.vehicle_id,
      plate_number: data.plate_number,
      type_id: data.type_id,
      brand_id: data.brand_id,
      model_id: data.model_id,
      year: data.year,
      odometer: data.odometer,
      changed_date: data.changed_date || new Date(),
      reason: data.reason,
    },
  });

  const vehicle = await prisma.vehicle.update({
    where: { id: data.vehicle_id },
    data: {
      plate_number: data.plate_number,
      type_id: data.type_id,
      brand_id: data.brand_id,
      model_id: data.model_id,
      year: data.year,
      odometer: data.odometer,
    },
  });
  return { vehicle, vehicleActivity };
};

export const getVehicleActivityService = async (prisma, vehicleId) => {
  const activities = await prisma.vehicleActivity.findMany({
    where: { vehicle_id: vehicleId },
    include: {
      type:true,
      brand: true,
      model: true,
    },
    orderBy: { changed_date: "desc" },
  });
  const vehicle = await prisma.vehicle.findFirst({
    where:{id: vehicleId},
    include: {
      type:true,
      brand: true,
      model: true,
    },
  })
  const data = [...activities,vehicle]
  return data;
};

export const vehicleChangeUpdateService = async (prisma, data) => {
  const vehicleActivity = await prisma.vehicleActivity.update({
    where:{vehicle_id: data.vehicleActivity_id},
    data: {
      plate_number: data.plate_number,
      type_id: data.type_id,
      brand_id: data.brand_id,
      model_id: data.model_id,
      year: data.year,
      odometer: data.odometer,
      changed_date: data.changed_date || new Date(),
      reason: data.reason,
    },
  });

  const vehicle = await prisma.vehicle.update({
    where: { id: data.vehicle_id },
    data: {
      plate_number: data.plate_number,
      type_id: data.type_id,
      brand_id: data.brand_id,
      model_id: data.model_id,
      year: data.year,
      odometer: data.odometer,
    },
  });
  return { vehicle, vehicleActivity };
};