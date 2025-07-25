import express from "express";
import prisma from "../config/prisma.js";
import {
  createInstallEngineer,
  createUser,
  deleteUser,
  getInstallEngineer,
  getUser,
  updateUser,
  userCreateBySuperAdmin,
  userUpdateBySuperAdmin,
} from "../controllers/userController.js";

const router = express.Router();

router.post("/", createUser);

router.get("/", getUser);

router.get("/installation-engineer", getInstallEngineer);

router.post("/installation-engineer", createInstallEngineer);

router.post("/create-by-admin", userCreateBySuperAdmin);

router.patch("/", updateUser);
router.patch("/update-by-admin", userUpdateBySuperAdmin);
router.delete("/:id", deleteUser);

export { router as userRouter };
