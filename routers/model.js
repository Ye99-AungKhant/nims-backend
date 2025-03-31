import express from "express";
import { createModel, getModel } from "../controllers/modelController.js";

const router = express.Router();

router.post("/", createModel);

router.get("/", getModel);

export { router as modelRouter };
