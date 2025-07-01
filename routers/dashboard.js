import express from "express";
import {
  getAccessoryUsage,
  getDashboardData,
  getGPSUsage,
  getObjectFee,
  getPeripheralUsage,
  getSimCardUsage,
} from "../controllers/dashboardController.js";

const router = express.Router();
router.get("/", getDashboardData);
router.get("/gps-usage", getGPSUsage);
router.get("/peripheral-usage", getPeripheralUsage);
router.get("/accessory-usage", getAccessoryUsage);
router.get("/simcard-usage", getSimCardUsage);
router.get("/object-fee", getObjectFee);

export { router as dashboardRouter };
