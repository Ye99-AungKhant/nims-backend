import { apiResponse } from "../config/apiResponse.js";
import { deleteInstallImageService } from "../models/InstallImage.js";

export const deleteInstallImage = async (req, res) => {
  const id = Number(req.params.id);
  try {
    await deleteInstallImageService(id);
    apiResponse(res, 200, "Photo delete successful.");
  } catch (error) {
    apiResponse(res, 400, "Photo delete failed.");
  }
};
