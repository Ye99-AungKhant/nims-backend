import { apiResponse } from "../config/apiResponse.js";
import { createTypeService, getTypeService } from "../models/typeModel.js";

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
