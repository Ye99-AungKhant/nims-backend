import express from "express";
import { fileUploader } from "../util/fileUpload.js";
import {
  createPlacement,
  createRepair,
  deleteReplacement,
  getAccessoryReplacementHistory,
  getGPSReplacementHistory,
  getPeripheralReplacementHistory,
  getRepairReplacementFullHistory,
  getSIMCardReplacementHistory,
  updateAccessoryReplacement,
  updateGPSReplacement,
  updatePeripheralReplacement,
  updateSIMCardReplacement,
} from "../controllers/repairReplacementController.js";

const router = express.Router();

router.post(
  "/replacement",
  fileUploader.array("installImage", 30),
  createPlacement
);

router.post("/repair", fileUploader.array("installImage", 30), createRepair);

router.get("/gps-replacement-history", getGPSReplacementHistory);
router.patch("/update/gps-replacement-history", updateGPSReplacement);

router.get("/simcard-replacement-history", getSIMCardReplacementHistory);
router.patch("/update/simcard-replacement-history", updateSIMCardReplacement);

router.get("/peripheral-replacement-history", getPeripheralReplacementHistory);
router.patch(
  "/update/peripheral-replacement-history",
  updatePeripheralReplacement
);

router.get("/accessory-replacement-history", getAccessoryReplacementHistory);
router.patch(
  "/update/accessory-replacement-history",
  updateAccessoryReplacement
);

router.get("/full-history", getRepairReplacementFullHistory);
router.patch("/delete", deleteReplacement);

export { router as repairReplacementRouter };
