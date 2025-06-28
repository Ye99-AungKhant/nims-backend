import { apiResponse } from "../config/apiResponse.js";
import prisma from "../config/prisma.js";
import { createInstallImageService } from "../models/fileModel.js";
import { createInstallationEngineerService } from "../models/installationEngineerModel.js";
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
  console.log("Vehicle Change Request Body:", req.body);

  const bodyData = JSON.parse(req.body.data);
  const files = req.files;
  const buildVehicleData = {
    vehicle_id: bodyData.id,
    plate_number: bodyData.vehiclePlateNo,
    changed_date: bodyData.vehicleChangedDate,
    reason: bodyData.reason ?? null,
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

  try {
    await prisma.$transaction(async (prisma) => {
      const vehicleData = await vehicleChangeService(prisma, buildVehicleData);

      await Promise.all(
        bodyData.installationEngineer.map(
          async (eng) =>
            await createInstallationEngineerService(prisma, {
              user_id: Number(eng.user_id),
              vehicle_activity_id: vehicleData.vehicleActivity.id,
            })
        )
      );

      // Save installImage
      if (files.length) {
        const imageRecords = files.map((file) => ({
          server_id: serverId,
          vehicle_activity_id: vehicleData.vehicleActivity.id,
          image_url: `/uploads/${file.filename}`,
        }));

        await createInstallImageService(prisma, imageRecords);
      }
    });
    apiResponse(res, 200, "Vehicle updated successfully");
  } catch (error) {
    apiResponse(res, 400, "Vehicle update failed.", error);
  }
};

export const getVehicleActivity = async (req, res) => {
  const vehicleId = Number(req.query.id);
  const activities = await getVehicleActivityService(prisma, vehicleId);
  apiResponse(res, 200, "", activities);
};
