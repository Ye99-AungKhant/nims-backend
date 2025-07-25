import { apiResponse } from "../config/apiResponse.js";
import prisma from "../config/prisma.js";
import {
  deleteUserService,
  getInstallEngService,
  getUsersService,
  updateUserService,
  userCreateBySuperAdminService,
  userCreateService,
  userUpdateBySuperAdminService,
} from "../models/userModel.js";
import logger from "../util/logger.js";
import AuditLogService from "../models/auditLogModel.js";

export const createUser = async (req, res) => {
  const { name, role_id, phone, email } = req.body;
  try {
    const user = await prisma.user.create({
      data: {
        name,
        role_id,
        phone,
        email,
      },
    });
    try {
      await AuditLogService.create({
        user_id: req.user?.id || null,
        action: "CREATE",
        table_name: "User",
        record_id: user?.id || null,
        ip_address: req.ip || null,
      });
    } catch (auditError) {
      logger.error(`Audit log error: ${auditError?.stack || auditError}`);
    }

    apiResponse(res, 201, "User created successfully.", user);
  } catch (error) {
    apiResponse(res, 400, "User created failed.", error);
  }
};

export const createInstallEngineer = async (req, res) => {
  const { name } = req.body;
  try {
    const role = await prisma.role.findFirst({
      where: { name: "Installation Engineer" },
    });

    const installEng = await userCreateService({ name, role_id: role.id });
    try {
      await AuditLogService.create({
        user_id: req.user?.id || null,
        action: "CREATE",
        table_name: "User",
        record_id: user?.id || null,
        ip_address: req.ip || null,
        description: "Installation Engineer",
      });
    } catch (auditError) {
      logger.error(`Audit log error: ${auditError?.stack || auditError}`);
    }
    apiResponse(res, 201, "Install engineer created successfully.", installEng);
  } catch (error) {
    apiResponse(res, 400, "Install engineer created failed.", error);
  }
};

export const getInstallEngineer = async (req, res) => {
  try {
    const role = await prisma.role.findFirst({
      where: { name: "Installation Engineer" },
    });
    const eng = await getInstallEngService({ role_id: role.id });
    apiResponse(res, 200, "", eng);
  } catch (error) {
    apiResponse(res, 400, "Install engineer get failed.", error);
  }
};

export const getUser = async (req, res) => {
  const { pageIndex, pageSize, search } = req.query;
  const currentPage = Math.max(Number(pageIndex) || 1, 1);
  const perPage = Number(pageSize) || 10;
  console.log(req.query);

  try {
    const users = await getUsersService(currentPage, perPage, search);
    apiResponse(res, 200, "", users);
  } catch (error) {
    apiResponse(res, 400, "Users get failed.", error);
  }
};

export const updateUser = async (req, res) => {
  const { id, name } = req.body;
  try {
    const user = await updateUserService(id, name);
    try {
      await AuditLogService.create({
        user_id: req.user?.id || null,
        action: "UPDATE",
        table_name: "User",
        record_id: user?.id || null,
        ip_address: req.ip || null,
      });
    } catch (auditError) {
      logger.error(`Audit log error: ${auditError?.stack || auditError}`);
    }
    apiResponse(res, 200, "User updated successfully.", user);
  } catch (error) {
    apiResponse(res, 400, "Users update failed.", error);
  }
};

export const deleteUser = async (req, res) => {
  const { id } = req.params;
  try {
    await deleteUserService({ id: Number(id) });
    try {
      await AuditLogService.create({
        user_id: req.user?.id || null,
        action: "DELETE",
        table_name: "User",
        record_id: user?.id || null,
        ip_address: req.ip || null,
      });
    } catch (auditError) {
      logger.error(`Audit log error: ${auditError?.stack || auditError}`);
    }
    apiResponse(res, 200, "User deleted successfully.");
  } catch (error) {
    apiResponse(res, 400, "Users delete failed.", error);
  }
};

export const userCreateBySuperAdmin = async (req, res) => {
  const { name, role, email, phone, password, username } = req.body;
  try {
    const user = await userCreateBySuperAdminService({
      name,
      role: Number(role),
      email,
      phone,
      password,
      username,
    });

    try {
      await AuditLogService.create({
        user_id: req.user?.id || null,
        action: "CREATE",
        table_name: "User",
        record_id: user?.id || null,
        ip_address: req.ip || null,
        description: "Authentication user by super admin",
      });
    } catch (auditError) {
      logger.error(`Audit log error: ${auditError?.stack || auditError}`);
    }

    apiResponse(res, 200, "User created successfully.", user);
  } catch (error) {
    apiResponse(res, 400, "Users created failed.", error);
  }
};

export const userUpdateBySuperAdmin = async (req, res) => {
  const { id, name, role, email, phone, password, username, allow_login } =
    req.body;
  try {
    const user = await userUpdateBySuperAdminService({
      id,
      name,
      role: Number(role),
      email,
      phone,
      password,
      username,
      allow_login,
    });

    try {
      await AuditLogService.create({
        user_id: req.user?.id || null,
        action: "UPDATE",
        table_name: "User",
        record_id: user?.id || null,
        ip_address: req.ip || null,
        description: "Authentication user by super admin",
      });
    } catch (auditError) {
      logger.error(`Audit log error: ${auditError?.stack || auditError}`);
    }

    apiResponse(res, 200, "User updated successfully.", user);
  } catch (error) {
    apiResponse(res, 400, "Users updated failed.", user);
  }
};
