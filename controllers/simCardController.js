import { createSimCardService } from "../models/simCardModel.js";
import { apiResponse } from "./../config/apiResponse.js";

export const createSimCard = async (req, res) => {
  const { device_id, phone_no, operator } = req.body;
  const simCard = await createSimCardService(device_id, phone_no, operator);
  apiResponse(res, 201, "Sim card created successfully", simCard);
};
