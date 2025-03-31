import express from "express";
import {
  createForm,
  getInstalled,
} from "../controllers/createFormController.js";

const router = express.Router();

router.post("/", createForm);
router.get("/", getInstalled);

export { router as creatFormRouter };
