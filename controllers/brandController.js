import { apiResponse } from "../config/apiResponse.js";
import { createBrandService, getBrandService } from "../models/brandModel.js";

export const createBrand = async (req, res) => {
  const { name, type_group } = req.body;
  const brand = await createBrandService(name, type_group);
  apiResponse(res, 201, "Brand created successfully", brand);
};

export const getBrand = async (req, res) => {
  const { type_group } = req.query;

  const brands = await getBrandService(type_group);
  apiResponse(res, 200, "", brands);
};
