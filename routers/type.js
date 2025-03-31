import express from "express";
import { createType, getType } from "../controllers/typeController.js";

const router = express.Router();

router.post("/", createType);

router.get("/", getType);

export { router as typeRouter };
