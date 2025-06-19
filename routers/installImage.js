import express from "express";
import { deleteInstallImage } from "../controllers/installImageController.js";
const router = express.Router();

router.delete("/:id", deleteInstallImage);

export { router as installImageRouter };
