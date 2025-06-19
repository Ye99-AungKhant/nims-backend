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

const router = express.Router();

router.post("/", createClient);
router.post("/createClientWithContact", createClientWithContact);

router.get("/", getClient);
router.get("/contact-person", getClientWithContact);
router.get("/object", getClientObjects);
router.post("/update", updateClientWithContact);
router.delete("/delete/:id", deleteClientWithContact);

export { router as clientRouter };
