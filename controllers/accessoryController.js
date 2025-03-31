import { apiResponse } from "../config/apiResponse.js";
import { createAccessoryService } from "../models/accessoryModel.js";

export const createAccessory = async (req, res) => {
  const { device_id, type_id, qty } = req.body;
  const accessory = await createAccessoryService(device_id, type_id, qty);
  apiResponse(res, 201, "Accessory created successfully", accessory);
};
