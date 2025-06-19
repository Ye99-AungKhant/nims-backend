import { apiResponse } from "../config/apiResponse.js";
import prisma from "../config/prisma.js";
import {
  createVehicleService,
  getVehicleActivityService,
  getVehicleService,
  vehicleChangeService,
} from "../models/vehicleModel.js";

export const createVehicle = async (req, res) => {
  const { client_id, plate_number, type_id, brand_id, model_id, year } =
    req.body;
  const vehicle = await createVehicleService(
    client_id,
    plate_number,
    type_id,
    brand_id,
    model_id,
    year
  );
  apiResponse(res, 201, "Vehicle created successfully", vehicle);
};

export const getVehicle = async (req, res) => {
  const type_id = Number(req.query.type_id);
  const vehicles = await getVehicleService(type_id);
  apiResponse(res, 200, "", vehicles);
};

export const vehicleChange = async (req, res) => {
  const bodyData = req.body;
  const buildVehicleData = {
    vehicle_id: bodyData.vehicleId,
    plate_number: bodyData.vehiclePlateNo,
    changed_date: bodyData.vehicleChangedDate,
  };

  if (bodyData.vehicleType) {
    buildVehicleData.type_id = Number(bodyData.vehicleType);
  }

  if (bodyData.vehicleBrand) {
    buildVehicleData.brand_id = Number(bodyData.vehicleBrand);
  }

  if (bodyData.vehicleModel) {
    buildVehicleData.model_id = Number(bodyData.vehicleModel);
  }

  if (bodyData.vehicleYear) {
    buildVehicleData.year = Number(bodyData.vehicleYear);
  }

  if (bodyData.vehicleOdometer) {
    buildVehicleData.odometer = bodyData.vehicleOdometer;
  }

  const vehicle = await vehicleChangeService(prisma, buildVehicleData);
  apiResponse(res, 200, "Vehicle updated successfully", vehicle);
};

export const getVehicleActivity = async (req, res) => {
  const vehicleId = Number(req.query.vehicle_id);
  const activities = await getVehicleActivityService(prisma, vehicleId);
  apiResponse(res, 200, "", activities);
};
