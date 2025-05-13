import express from "express";
import prisma from "../config/prisma.js";
import {
  createInstallEngineer,
  deleteUser,
  getInstallEngineer,
  getUser,
  updateUser,
  userCreateBySuperAdmin,
  userUpdateBySuperAdmin,
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

router.post("/create-by-admin", userCreateBySuperAdmin);

router.patch("/", updateUser);
router.patch("/update-by-admin", userUpdateBySuperAdmin);
router.delete("/:id", deleteUser);

export { router as userRouter };
