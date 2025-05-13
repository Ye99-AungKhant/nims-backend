import express from "express";
import {
  createInstallObject,
  getInstalled,
  updateInstallObject,
  updateInstallObjectStatus,
} from "../controllers/createFormController.js";

const router = express.Router();

router.post("/", createInstallObject);
router.post("/update", updateInstallObject);
router.get("/", getInstalled);
router.get("/check-expiry", updateInstallObjectStatus);

export { router as installObjectRouter };
