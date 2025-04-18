import { apiResponse } from "../config/apiResponse.js";
import {
  createBrandService,
  getBrandService,
  updateBrandService,
} from "../models/brandModel.js";

export const createBrand = async (req, res) => {
  const { name, type_id, type_group } = req.body;
  const brand = await createBrandService(name, type_id, type_group);
  apiResponse(res, 201, "Brand created successfully", brand);
};

export const getBrand = async (req, res) => {
  const { type_id, type_group } = req.query;

  try {
    const brands = await getBrandService({
      type_id: Number(type_id),
      type_group,
    });
    apiResponse(res, 200, "", brands);
  } catch (error) {
    apiResponse(res, 400, "Brand not found.", error);
  }
};

export const updateBrand = async (req, res) => {
  const { id, type_id, name } = req.body;
  try {
    const brand = await updateBrandService({
      id,
      type_id: Number(type_id),
      name,
    });
    apiResponse(res, 200, "Brand updated successful.", brand);
  } catch (error) {
    apiResponse(res, 400, "Brand update failed.", error);
  }
};
