import XLSX from "xlsx";
import { getInstalledObjectService } from "../models/installObjectModel.js";
import dayjs from "dayjs";
import logger from "../util/logger.js";

export const exportInstalledObjectsXlsx = async (req, res) => {
  try {
    // Fetch all data (remove pagination)
    const { data } = await getInstalledObjectService(
      null, // id
      1, // currentPage
      1000000, // perPage (large number to get all)
      req.query.search,
      req.query.filter_by_date,
      req.query.filter_by,
      req.query.fromDate,
      req.query.toDate,
      req.query.client_id
    );

    // Transform data for XLSX (flatten as needed)
    const rows = data.map((item) => {
      const expireDate = item.device[0]?.server[0]?.expire_date;
      const installedDate = item.device[0]?.server[0]?.installed_date;
      return {
        "Client Name": item.client?.name ?? "N/A",
        "Plate No.": item.plate_number ?? "N/A",
        "Device IMEI": item.device_imei ?? "N/A",
        "Installed Date": installedDate
          ? dayjs(installedDate).format("DD-MM-YYYY")
          : "N/A",
        "Expiry Date": expireDate
          ? dayjs(expireDate).format("DD-MM-YYYY")
          : "N/A",
        Status: item.device[0]?.server[0]?.status ?? "N/A",
        // Add more fields with human-readable headers as needed...
      };
    });

    // Create worksheet and workbook
    const worksheet = XLSX.utils.json_to_sheet(rows);
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, "InstalledObjects");

    // Write workbook to buffer
    const buffer = XLSX.write(workbook, {
      type: "buffer",
      bookType: "xlsx",
    });

    // Set response headers and send file
    res.setHeader(
      "Content-Disposition",
      "attachment; filename=installed_objects.xlsx"
    );
    res.setHeader(
      "Content-Type",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    );
    res.end(buffer);
  } catch (error) {
    logger.error("Error exporting installed objects to XLSX:", error);
    res.status(500).json({ error: "Failed to export XLSX", details: error });
  }
};
