import express from "express";
import { createSimCard } from "../controllers/simCardController.js";

const router = express.Router();

router.post("/", createSimCard);

export { router as simCardRouter };
