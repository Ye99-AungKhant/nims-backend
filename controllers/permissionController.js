import { apiResponse } from "../config/apiResponse.js";
import { getPermissionService } from "../models/permissionModel.js";

export const getAllPermission = async (req, res) => {
  try {
    const permissions = await getPermissionService();
    apiResponse(res, 200, "", permissions);
  } catch (error) {
    apiResponse(res, 400, "", error);
  }
};
