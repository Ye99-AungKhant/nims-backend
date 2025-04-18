import express from "express";
import prisma from "../config/prisma.js";
import {
  createBrand,
  getBrand,
  updateBrand,
} from "../controllers/brandController.js";

const router = express.Router();

router.post("/", createBrand);

router.get("/", getBrand);

router.patch("/", updateBrand);

export { router as brandRouter };
