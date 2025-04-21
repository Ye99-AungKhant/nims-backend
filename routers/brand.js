import express from "express";
import prisma from "../config/prisma.js";
import {
  createBrand,
  deleteBrand,
  getBrand,
  updateBrand,
} from "../controllers/brandController.js";

const router = express.Router();

router.post("/", createBrand);

router.get("/", getBrand);

router.patch("/", updateBrand);
router.delete("/:id", deleteBrand);

export { router as brandRouter };
