import prisma from "../config/prisma.js";

export const createWarrantyPlanService = async (name) => {
  const warrantyPlan = await prisma.warrantyPlan.create({
    data: {
      name,
    },
  });
  return warrantyPlan;
};

export const getWarrantyPlanService = async () => {
  const warrantyPlans = await prisma.warrantyPlan.findMany();
  return warrantyPlans;
};

export const updateWarrantyPlanService = async ({ id, name }) => {
  const warrantyPlan = await prisma.warrantyPlan.update({
    where: { id },
    data: { name },
  });
  return warrantyPlan;
};

export const deleteWarrantyPlanService = async ({ id }) => {
  await prisma.warrantyPlan.delete({
    where: { id },
  });
  return;
};
