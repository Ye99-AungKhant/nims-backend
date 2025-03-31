import { apiResponse } from "../config/apiResponse.js";
import { createGpsDeviceService } from "../models/gpsDeviceModel.js";

export const createGpsDevice = async (req, res) => {
  const { vehicle_id, brand_id, model_id, imei, serial_no, warranty_plan_id } =
    req.body;
  const device = await createGpsDeviceService(
    vehicle_id,
    brand_id,
    model_id,
    imei,
    serial_no,
    warranty_plan_id
  );
  apiResponse(res, 201, "Device created successfully", device);
};
