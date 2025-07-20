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
