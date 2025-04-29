import express from "express";
import {
  createInstallObject,
  getInstalled,
} from "../controllers/createFormController.js";

const router = express.Router();

router.post("/", createInstallObject);
router.get("/", getInstalled);

export { router as installObjectRouter };
