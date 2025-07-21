import express from "express";
import { login, refreshToken } from "../controllers/authController.js";

const router = express.Router();

router.post("/", login);
router.post("/refresh-token", refreshToken);

export { router as authRouter };
