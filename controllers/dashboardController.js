import { apiResponse } from "../config/apiResponse.js";
import {
  getAccessoryUsageService,
  getDashboardDataService,
  getGPSUsageService,
  getObjectFeeService,
  getPeripheralUsageService,
  getSimCardUsageService,
} from "../models/dashboardModel.js";

export const getDashboardData = async (req, res) => {
  try {
    const filterYear = req.query.year;

    const dashboardData = await getDashboardDataService(filterYear);
    apiResponse(res, 200, "Dashboard data", dashboardData);
  } catch (error) {
    apiResponse(res, 400, "Dashboard not found", error);
  }
};

export const getGPSUsage = async (req, res) => {
  try {
    const gpsUsage = await getGPSUsageService();
    apiResponse(res, 200, "GPS usage data", gpsUsage);
  } catch (error) {
    apiResponse(res, 400, "GPS usage data not found", error);
  }
};

export const getPeripheralUsage = async (req, res) => {
  try {
    const peripheralUsage = await getPeripheralUsageService();
    apiResponse(res, 200, "Peripheral usage data", peripheralUsage);
  } catch (error) {
    console.log(error);

    apiResponse(res, 400, "Peripheral usage data not found", error);
  }
};

export const getAccessoryUsage = async (req, res) => {
  try {
    const accessoryUsage = await getAccessoryUsageService();
    apiResponse(res, 200, "Accessory usage data", accessoryUsage);
  } catch (error) {
    apiResponse(res, 400, "Accessory usage data not found", error);
  }
};

export const getSimCardUsage = async (req, res) => {
  try {
    const simCardUsage = await getSimCardUsageService();
    apiResponse(res, 200, "Sim Card usage data", simCardUsage);
  } catch (error) {
    apiResponse(res, 400, "Sim Card usage data not found", error);
  }
};

export const getObjectFee = async (req, res) => {
  try {
    const objectFee = await getObjectFeeService();
    apiResponse(res, 200, "Object fee data", objectFee);
  } catch (error) {
    apiResponse(res, 400, "Object fee data not found", error);
  }
};
