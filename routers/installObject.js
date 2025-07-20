import express from "express";
import {
  createInstallObject,
  deleteInstallObject,
  getInstalled,
  updateInstallObject,
  updateInstallObjectStatus,
} from "../controllers/createFormController.js";
import { fileUploader } from "../util/fileUpload.js";

const router = express.Router();

router.post("/", fileUploader.array("installImage", 30), createInstallObject);
router.post(
  "/update",
  fileUploader.array("installImage", 30),
  updateInstallObject
);
router.get("/", getInstalled);
router.get("/check-expiry", updateInstallObjectStatus);
router.delete("/:id", deleteInstallObject);

export { router as installObjectRouter };
