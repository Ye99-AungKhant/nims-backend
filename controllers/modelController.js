import { apiResponse } from "../config/apiResponse.js";
import {
  createModelService,
  deleteModelService,
  getModelService,
  updateModelService,
} from "../models/modelModel.js";

export const createModel = async (req, res) => {
  const { name, type_group, brand_id } = req.body;
  const model = await createModelService(name, type_group, brand_id);
  apiResponse(res, 201, "Model created successfully", model);
};

export const getModel = async (req, res) => {
  const { type_group, brand_id } = req.query;
  try {
    const models = await getModelService(type_group, brand_id);
    apiResponse(res, 200, "", models);
  } catch (error) {
    apiResponse(res, 400, "model not found", error);
  }
};

export const updateModel = async (req, res) => {
  const { id, brand_id, name } = req.body;
  try {
    const model = await updateModelService({
      id,
      brand_id: Number(brand_id),
      name,
    });
    apiResponse(res, 200, "Model updated successful.", model);
  } catch (error) {
    apiResponse(res, 400, "Model update failed.", error);
  }
};

export const deleteModel = async (req, res) => {
  const { id } = req.params;
  try {
    await deleteModelService({ id: Number(id) });
    apiResponse(res, 200, "Type delete Successful.");
  } catch (error) {
    apiResponse(res, 400, "Type delete failed.", error);
  }
};
