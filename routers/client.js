import express from "express";
import prisma from "../config/prisma.js";
import {
  createClient,
  createClientWithContact,
  deleteClientWithContact,
  getClient,
  getClientObjects,
  getClientWithContact,
  updateClientWithContact,
} from "../controllers/clientController.js";
import { exportInstalledObjectsXlsx } from "../controllers/exportController.js";

const router = express.Router();

router.post("/", createClient);
router.post("/createClientWithContact", createClientWithContact);

router.get("/", getClient);
router.get("/contact-person", getClientWithContact);
router.get("/object", getClientObjects);
router.post("/update", updateClientWithContact);
router.delete("/delete/:id", deleteClientWithContact);
router.get("/export-installed-object", exportInstalledObjectsXlsx);

export { router as clientRouter };
