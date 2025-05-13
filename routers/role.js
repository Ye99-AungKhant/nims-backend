import express from "express";
import prisma from "../config/prisma.js";
import { apiResponse } from "../config/apiResponse.js";

const router = express.Router();

router.post("/", async (req, res) => {
  const { name, canLogin } = req.body;

  const role = await prisma.role.create({
    data: {
      name,
      ...(canLogin && { canLogin }),
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
    const roles = await prisma.role.findMany({ where: { canLogin: false } });

    res.status(200).json(roles);
  }
});

router.get("/auth-access", async (req, res) => {
  const { pageIndex, pageSize, search } = req.query;
  const currentPage = Math.max(Number(pageIndex) || 1, 1);
  const perPage = Number(pageSize) || 10;

  try {
    const whereCondition = {
      canLogin: true,
    };
    if (search) {
      whereCondition.name = {
        contains: search,
        mode: "insensitive", // case-insensitive search
      };
    }

    const queryOptions = {
      where: whereCondition,
      include: { permissions: true },
    };

    if (!search) {
      queryOptions.skip = (currentPage - 1) * perPage;
      queryOptions.take = perPage;
    }

    const roles = await prisma.role.findMany(queryOptions);
    const totalCount = roles.length;

    const totalPages = search ? 1 : Math.ceil(totalCount / perPage);

    apiResponse(res, 200, "", { roles, totalCount, totalPages });
  } catch (error) {
    apiResponse(res, 400, "Role not found.", error);
  }
});

router.post("/permission-assign", async (req, res) => {
  const { role, permissions } = req.body;

  try {
    // 1. Check if role exists
    const existingRole = await prisma.role.findUnique({
      where: { id: role.id },
    });

    if (!existingRole) {
      apiResponse(res, 404, "Role not found");
    }

    // 2. Delete existing permissions for that role (optional if updating)
    await prisma.permission.deleteMany({
      where: { roleId: role.id },
    });

    // 3. Create new permissions
    await prisma.permission.createMany({
      data: permissions.map((perm) => ({
        ...perm,
        roleId: role.id,
      })),
    });

    apiResponse(res, 200, "Permissions assigned successfully.");
  } catch (error) {
    apiResponse(res, 500, "Internal Server Error", error);
  }
});

router.patch("/", async (req, res) => {
  const { id, name } = req.body;
  try {
    const role = await prisma.role.update({
      where: { id },
      data: { name },
    });
    res.status(200).json(role);
  } catch (error) {
    res.json({ message: "This role not found" });
  }
});

router.delete("/:id", async (req, res) => {
  const { id } = req.params;
  const roleId = Number(id);

  try {
    const isSuperAdmin = await prisma.role.findFirst({
      where: { id: roleId },
    });
    if (isSuperAdmin.name === "Super Admin") {
      throw new Error("Super Admin role cannot be modified or deleted.");
    }
    await prisma.permission.deleteMany({
      where: { roleId },
    });

    await prisma.user.updateMany({
      where: { role_id: roleId },
      data: { role_id: null, canLogin: false },
    });

    await prisma.contactPerson.updateMany({
      where: { role_id: roleId },
      data: { role_id: null },
    });
    await prisma.role.delete({
      where: { id: roleId },
    });
    apiResponse(res, 200, "success");
  } catch (error) {
    apiResponse(res, 400, error.message, error);
  }
});

export { router as roleRouter };
