import express from "express";
import {
  createModel,
  deleteModel,
  getAllModel,
  getModel,
  updateModel,
} from "../controllers/modelController.js";

const router = express.Router();

router.post("/", createModel);

router.get("/", getModel);

router.get("/all", getAllModel);

router.patch("/", updateModel);

router.delete("/:id", deleteModel);

export { router as modelRouter };
