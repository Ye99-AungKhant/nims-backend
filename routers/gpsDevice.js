import express from "express";
import { createGpsDevice } from "../controllers/gpsDeviceController.js";

const router = express.Router();

router.post("/", createGpsDevice);

export { router as gpsDeviceRouter };
