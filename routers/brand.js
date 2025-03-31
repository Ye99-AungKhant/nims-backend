import express from "express";
import prisma from "../config/prisma.js";
import { createBrand, getBrand } from "../controllers/brandController.js";

const router = express.Router();

router.post("/", createBrand);

router.get("/", getBrand);

export { router as brandRouter };
