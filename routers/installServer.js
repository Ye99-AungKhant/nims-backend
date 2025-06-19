import express from "express";
import {
  createServer,
  renewalServer,
} from "../controllers/serverController.js";

const router = express.Router();

router.post("/", createServer);
router.post("/renew", renewalServer);

export { router as installServerRouter };
