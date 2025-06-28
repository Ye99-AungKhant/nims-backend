import express from "express";
import {
  createVehicle,
  getVehicle,
  getVehicleActivity,
  vehicleChange,
} from "../controllers/vehicleController.js";
import { fileUploader } from "../util/fileUpload.js";

const router = express.Router();

router.post("/", createVehicle);

router.get("/", getVehicle);

router.post("/change", fileUploader.array("installImage", 30), vehicleChange);
router.get("/change/activity", getVehicleActivity);

export { router as vehicleRouter };
