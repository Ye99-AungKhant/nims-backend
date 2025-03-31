import express from "express";
import { createPeripheral } from "../controllers/peripheralController.js";

const router = express.Router();

router.post("/", createPeripheral);

export { router as peripheralRouter };
