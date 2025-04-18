import express from "express";
import {
  createType,
  deleteType,
  getType,
  updateType,
} from "../controllers/typeController.js";

const router = express.Router();

router.post("/", createType);

router.get("/", getType);

router.patch("/", updateType);
router.delete("/:id", deleteType);

export { router as typeRouter };
