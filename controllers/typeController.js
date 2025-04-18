import { apiResponse } from "../config/apiResponse.js";
import {
  createTypeService,
  deleteTypeService,
  getTypeService,
  updateTypeService,
} from "../models/typeModel.js";

export const createType = async (req, res) => {
  const { name, type_group } = req.body;
  const type = await createTypeService(name, type_group);
  apiResponse(res, 201, "Type created successfully", type);
};

export const getType = async (req, res) => {
  const { type_group } = req.query;

  const types = await getTypeService(type_group);
  apiResponse(res, 200, "", types);
};

export const updateType = async (req, res) => {
  const { id, name } = req.body;
  try {
    const type = await updateTypeService(id, name);
    apiResponse(res, 200, "Type updated successful.", type);
  } catch (error) {
    apiResponse(res, 400, "Type update failed.", error);
  }
};

export const deleteType = async (req, res) => {
  const { id } = req.params;
  try {
    await deleteTypeService({ id: Number(id) });
    apiResponse(res, 200, "Type delete Successful.");
  } catch (error) {
    apiResponse(res, 400, "Type delete failed.", error);
  }
};
