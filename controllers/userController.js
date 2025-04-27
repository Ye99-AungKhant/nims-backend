import { apiResponse } from "../config/apiResponse.js";
import prisma from "../config/prisma.js";
import { getUsersService, userCreateService } from "../models/userModel.js";

export const createInstallEngineer = async (req, res) => {
  const { name } = req.body;
  try {
    const role = await prisma.role.findFirst({
      where: { name: "Installation Engineer" },
    });

    const installEng = await userCreateService({ name, role_id: role.id });
    apiResponse(res, 201, "Install engineer created successfully", installEng);
  } catch (error) {
    apiResponse(res, 400, "Install engineer created failed.", error);
  }
};

export const getInstallEngineer = async (req, res) => {
  try {
    const role = await prisma.role.findFirst({
      where: { name: "Installation Engineer" },
    });
    const eng = await getUsersService({ role_id: role.id });
    apiResponse(res, 200, "", eng);
  } catch (error) {
    apiResponse(res, 400, "Install engineer get failed.", error);
  }
};

export const getUser = async (req, res) => {
  try {
    const users = await getUsersService();
    apiResponse(res, 200, "", users);
  } catch (error) {
    apiResponse(res, 400, "Users get failed.", error);
  }
};
