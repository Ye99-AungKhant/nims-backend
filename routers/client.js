import express from "express";
import prisma from "../config/prisma.js";
import {
  createClient,
  getClient,
  getClientWithContact,
} from "../controllers/clientController.js";

const router = express.Router();

router.post("/", createClient);

router.get("/", getClient);
router.get("/contact-person", getClientWithContact);

export { router as clientRouter };
