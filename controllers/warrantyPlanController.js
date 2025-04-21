import { apiResponse } from "../config/apiResponse.js";
import {
  createWarrantyPlanService,
  deleteWarrantyPlanService,
  getWarrantyPlanService,
  updateWarrantyPlanService,
} from "../models/warrantyPlanModel.js";

export const createWarrantyPlan = async (req, res) => {
  const { name } = req.body;
  try {
    const warranty = await createWarrantyPlanService(name);
    apiResponse(res, 201, "Warranty created successful.", warranty);
  } catch (error) {
    apiResponse(res, 400, "Warranty created failed.", error);
  }
};

export const getWarrantyPlan = async (req, res) => {
  try {
    const warranty = await getWarrantyPlanService();
    apiResponse(res, 200, "", warranty);
  } catch (error) {
    apiResponse(res, 400, "Warranty can not found.", error);
  }
};

export const updateWarrantyPlan = async (req, res) => {
  const { id, name } = req.body;
  try {
    const model = await updateWarrantyPlanService({
      id,
      name,
    });
    apiResponse(res, 200, "Warranty updated successful.", model);
  } catch (error) {
    apiResponse(res, 400, "Warranty update failed.", error);
  }
};

export const deleteWarrantyPlan = async (req, res) => {
  const { id } = req.params;
  try {
    await deleteWarrantyPlanService({ id: Number(id) });
    apiResponse(res, 200, "Warranty delete Successful.");
  } catch (error) {
    apiResponse(res, 400, "Warranty delete failed.", error);
  }
};
