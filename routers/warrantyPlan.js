import express from "express";
import {
  createWarrantyPlan,
  deleteWarrantyPlan,
  getWarrantyPlan,
  updateWarrantyPlan,
} from "../controllers/warrantyPlanController.js";

const router = express.Router();

router.post("/", createWarrantyPlan);

router.get("/", getWarrantyPlan);
router.patch("/", updateWarrantyPlan);
router.delete("/:id", deleteWarrantyPlan);

export { router as warrantyPlanRouter };
