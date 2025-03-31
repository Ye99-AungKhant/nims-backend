import { apiResponse } from "../config/apiResponse.js";
import {
  createVehicleService,
  getVehicleService,
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
