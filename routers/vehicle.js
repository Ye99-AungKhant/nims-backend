import express from "express";
import {
  createVehicle,
  getVehicle,
  getVehicleActivity,
  vehicleChange,
} from "../controllers/vehicleController.js";

const router = express.Router();

router.post("/", createVehicle);

router.get("/", getVehicle);

router.post("/change", vehicleChange);
router.get("/change/activity", getVehicleActivity);

export { router as vehicleRouter };
