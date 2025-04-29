import express from "express";
import prisma from "../config/prisma.js";
import {
  createInstallEngineer,
  deleteUser,
  getInstallEngineer,
  getUser,
  updateUser,
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

router.patch("/", updateUser);
router.delete("/:id", deleteUser);

export { router as userRouter };
