import { peripheralReportService } from "../models/peripheralModel.js";
import { gpsDeviceReportService } from "../models/gpsDeviceModel.js";
import { accessoryReportService } from "../models/accessoryModel.js";
import { apiResponse } from "../config/apiResponse.js";
import prisma from "../config/prisma.js";
import { simcardReportService } from "../models/simCardModel.js";

export const simcardReport = async (req, res) => {
  const { operator, pageIndex, pageSize, search } = req.query;
  try {
    const currentPage = Math.max(Number(pageIndex) || 1, 1);
    const perPage = Number(pageSize) || 10;
    const report = await simcardReportService(prisma, {
      operator,
      search,
      currentPage,
      perPage,
    });

    apiResponse(res, 200, "Simcard report generated successfully", report);
  } catch (error) {
    console.log(error);

    apiResponse(res, 500, "Error generating simcard report", error);
  }
};

export const accessoryReport = async (req, res) => {
  const { type_id, pageIndex, pageSize, search } = req.query;
  try {
    const currentPage = Math.max(Number(pageIndex) || 1, 1);
    const perPage = Number(pageSize) || 10;
    const report = await accessoryReportService(prisma, {
      type_id: Number(type_id),
      search,
      currentPage,
      perPage,
    });

    apiResponse(res, 200, "Accessory report generated successfully", report);
  } catch (error) {
    console.log(error);
    apiResponse(res, 500, "Error generating accessory report", error);
  }
};

export const gpsDeviceReport = async (req, res) => {
  const { filterType, filterId, pageIndex, pageSize, client_id, search } =
    req.query;
  try {
    const currentPage = Math.max(Number(pageIndex) || 1, 1);
    const perPage = Number(pageSize) || 10;
    const report = await gpsDeviceReportService(prisma, {
      filterType,
      filterId,
      client_id,
      search,
      currentPage,
      perPage,
    });

    apiResponse(res, 200, "GPS Device report generated successfully", report);
  } catch (error) {
    console.log(error);
    apiResponse(res, 500, "Error generating GPS Device report", error);
  }
};

export const peripheralReport = async (req, res) => {
  const { filterType, filterId, pageIndex, pageSize, client_id, search } =
    req.query;
  try {
    const currentPage = Math.max(Number(pageIndex) || 1, 1);
    const perPage = Number(pageSize) || 10;
    const report = await peripheralReportService(prisma, {
      filterType,
      filterId,
      client_id,
      search,
      currentPage,
      perPage,
    });

    apiResponse(res, 200, "Peripheral report generated successfully", report);
  } catch (error) {
    console.log(error);
    apiResponse(res, 500, "Error generating Peripheral report", error);
  }
};
