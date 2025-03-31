import express from "express";
import { createServer } from "../controllers/serverController.js";

const router = express.Router();

router.post("/", createServer);

export { router as installServerRouter };
