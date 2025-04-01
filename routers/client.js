import express from "express";
import prisma from "../config/prisma.js";
import {
  createClient,
  createClientWithContact,
  getClient,
  getClientWithContact,
} from "../controllers/clientController.js";

const router = express.Router();

router.post("/", createClient);
router.post("/createClientWithContact", createClientWithContact);

router.get("/", getClient);
router.get("/contact-person", getClientWithContact);

export { router as clientRouter };
