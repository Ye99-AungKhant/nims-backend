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

export const createInstallEngineer = async (req, res) => {
  const { name } = req.body;
  try {
    const role = await prisma.role.findFirst({
      where: { name: "Installation Engineer" },
    });

    const installEng = await userCreateService({ name, role_id: role.id });
    apiResponse(res, 201, "Install engineer created successful.", installEng);
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
    apiResponse(res, 200, "User updated successful.", user);
  } catch (error) {
    apiResponse(res, 400, "Users update failed.", error);
  }
};

export const deleteUser = async (req, res) => {
  const { id } = req.params;
  try {
    await deleteUserService({ id: Number(id) });
    apiResponse(res, 200, "User deleted successful.");
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
    apiResponse(res, 200, "User created successful.", user);
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
    apiResponse(res, 200, "User updated successful.", user);
  } catch (error) {
    apiResponse(res, 400, "Users updated failed.", user);
  }
};
