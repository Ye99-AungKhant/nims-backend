import express from "express";
import prisma from "../config/prisma.js";
import {
  createInstallEngineer,
  getInstallEngineer,
  getUser,
} from "../controllers/userController.js";

const router = express.Router();

router.post("/", async (req, res) => {
  const { name, role_id, phone, email } = req.body;
  const user = await prisma.user.create({
    data: {
      name,
      role_id,
      phone,
      email,
    },
  });
  res.json(user);
});

router.get("/", getUser);

router.get("/installation-engineer", getInstallEngineer);

router.post("/installation-engineer", createInstallEngineer);

export { router as userRouter };
