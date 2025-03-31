import express from "express";
import { createVehicle, getVehicle } from "../controllers/vehicleController.js";

const router = express.Router();

router.post("/", createVehicle);

router.get("/", getVehicle);

export { router as vehicleRouter };
