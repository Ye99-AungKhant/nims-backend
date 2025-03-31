import express from "express";
import prisma from "../config/prisma.js";

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

router.get("/installation-engineer", async (req, res) => {
  const role = await prisma.role.findFirst({
    where: { name: "InstallationEngineer" },
  });
  const eng = await prisma.user.findMany({
    where: { role_id: role.id },
  });
  res.status(200).json(eng);
});

export { router as userRouter };
