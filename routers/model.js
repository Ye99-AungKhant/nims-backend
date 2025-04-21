import express from "express";
import {
  createModel,
  deleteModel,
  getModel,
  updateModel,
} from "../controllers/modelController.js";

const router = express.Router();

router.post("/", createModel);

router.get("/", getModel);

router.patch("/", updateModel);

router.delete("/:id", deleteModel);

export { router as modelRouter };
