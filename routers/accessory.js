import express from "express";
import { createAccessory } from "../controllers/accessoryController.js";

const router = express.Router();

router.post("/", createAccessory);

export { router as accessoryRouter };
