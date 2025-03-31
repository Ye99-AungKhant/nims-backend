import { apiResponse } from "../config/apiResponse.js";
import { createModelService, getModelService } from "../models/modelModel.js";

export const createModel = async (req, res) => {
  const { name, type_group, brand_id } = req.body;
  const model = await createModelService(name, type_group, brand_id);
  apiResponse(res, 201, "Model created successfully", model);
};

export const getModel = async (req, res) => {
  const { type_group, brand_id } = req.query;
  const models = await getModelService(type_group, brand_id);

  apiResponse(res, 200, "", models);
};
