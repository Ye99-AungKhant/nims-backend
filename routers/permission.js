import express from "express";
import { getAllPermission } from "../controllers/permissionController.js";

const router = express.Router();

router.get("/", getAllPermission);

export { router as permissionRouter };
