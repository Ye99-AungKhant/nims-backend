import express from "express";
import prisma from "../config/prisma.js";

const router = express.Router();

router.post("/", async (req, res) => {
  const { name } = req.body;
  const role = await prisma.role.create({
    data: {
      name,
    },
  });
  res.json(role);
});

router.get("/", async (req, res) => {
  const { name } = req.query;
  if (name) {
    try {
      const roles = await prisma.role.findMany({ where: name });
      res.status(200).json(roles);
    } catch (error) {
      res.json({ message: "This role not found" });
    }
  } else {
    const roles = await prisma.role.findMany();
    res.status(200).json(roles);
  }
});

export { router as roleRouter };
