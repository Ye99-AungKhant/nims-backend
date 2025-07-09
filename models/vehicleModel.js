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
  const vehicleExist = await prisma.vehicle.findFirst({
    where: { id: data.vehicle_id },
  });
  const vehicleActivity = await prisma.vehicleActivity.create({
    data: {
      vehicle_id: vehicleExist.id,
      plate_number: vehicleExist.plate_number,
      type_id: vehicleExist.type_id,
      brand_id: vehicleExist.brand_id,
      model_id: vehicleExist.model_id,
      year: vehicleExist.year,
      odometer: vehicleExist.odometer,
      changed_date: new Date(data.changed_date) || new Date(),
      reason: data.reason,
      invoice_no: data.invoice_no,
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
      changed_date: new Date(data.changed_date),
      odometer: data.odometer,
      invoice_no: data.invoice_no,
    },
  });
  return { vehicle, vehicleActivity };
};

export const getVehicleActivityService = async (prisma, vehicleId) => {
  const activities = await prisma.vehicleActivity.findMany({
    where: { vehicle_id: vehicleId },
    include: {
      type: true,
      brand: true,
      model: true,
    },
    orderBy: { id: "asc" },
  });
  const vehicle = await prisma.vehicle.findFirst({
    where: { id: vehicleId },
    include: {
      type: true,
      brand: true,
      model: true,
    },
  });
  const data = [...activities, vehicle];
  return data;
};

export const vehicleChangeUpdateService = async (prisma, data) => {
  const vehicleActivity = await prisma.vehicleActivity.update({
    where: { vehicle_id: data.vehicleActivity_id },
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
