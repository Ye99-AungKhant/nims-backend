import express from "express";
import prisma from "../config/prisma.js";

const router = express.Router();

router.post("/", async (req, res) => {
  const { name } = req.body;
  const warrantyPlan = await prisma.warrantyPlan.create({
    data: {
      name,
    },
  });
  res.json(warrantyPlan);
});

router.get("/", async (req, res) => {
  const warrantyPlans = await prisma.warrantyPlan.findMany();
  res.status(200).json(warrantyPlans);
});

export { router as warrantyPlanRouter };
