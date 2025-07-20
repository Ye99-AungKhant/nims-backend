import express from "express";
import { simcardReport } from "../controllers/reportController.js";

const router = express.Router();

router.get("/simcard", simcardReport);

export { router as reportRouter };
