import express from "express";
import {
  accessoryReport,
  gpsDeviceReport,
  peripheralReport,
  serverReport,
  simcardReport,
} from "../controllers/reportController.js";

const router = express.Router();

router.get("/simcard", simcardReport);
router.get("/accessory", accessoryReport);
router.get("/gps-device", gpsDeviceReport);
router.get("/peripheral", peripheralReport);
router.get("/server", serverReport);

export { router as reportRouter };
