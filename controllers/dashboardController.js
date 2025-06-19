import { apiResponse } from "../config/apiResponse.js";
import { getDashboardDataService } from "../models/dashboardModel.js";

export const getDashboardData = async (req, res) => {
  try {
    const filterYear = req.query.year;

    const dashboardData = await getDashboardDataService(filterYear);
    apiResponse(res, 200, "Dashboard data", dashboardData);
  } catch (error) {
    console.log(error);

    apiResponse(res, 400, "Dashboard not found", error);
  }
};
