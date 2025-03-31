import { apiResponse } from "../config/apiResponse.js";
import prisma from "../config/prisma.js";
import {
  createContactPersonService,
  deleteContactPersonService,
  updateContactPersonService,
} from "../models/contactPersonModel.js";

export const createContactPerson = async (req, res) => {
  const { client_id, name, role_id, phone, email } = req.body;
  const contact = await createContactPersonService(prisma, {
    client_id,
    name,
    role_id: Number(role_id),
    phone,
    email,
  });
  apiResponse(res, 201, "Contact person created Successfully", contact);
};

export const updateContactPerson = async (req, res) => {
  const { id, name, role_id, phone, email } = req.body;
  const contact = await updateContactPersonService(prisma, {
    id: Number(id),
    name,
    role_id: Number(role_id),
    phone,
    email,
  });
  apiResponse(res, 201, "Contact person updated Successfully", contact);
};

export const deleteContactPerson = async (req, res) => {
  const { id } = req.params;
  await deleteContactPersonService(prisma, { id: Number(id) });
  apiResponse(res, 201, "Contact person delete Successfully");
};
