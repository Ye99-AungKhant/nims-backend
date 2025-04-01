import { apiResponse } from "../config/apiResponse.js";
import {
  createClientService,
  getClientService,
  getClientWithContactService,
} from "../models/clientModel.js";
import { createContactPersonService } from "../models/contactPersonModel.js";
import prisma from "../config/prisma.js";

export const createClient = async (req, res) => {
  const { name, address, city } = req.body;
  console.log({ ...req.body });
  const client = await createClientService(req.body);
  apiResponse(res, 201, "Client created successfully", client);
};

export const createClientWithContact = async (req, res) => {
  const { clientData, contactPerson } = req.body;
  console.log(contactPerson);

  const client = await createClientService(clientData);

  contactPerson.map((person) =>
    createContactPersonService(prisma, {
      client_id: client.id,
      name: person.contactName,
      role_id: person.role_id,
      phone: person.phone,
      email: person.email,
    })
  );

  apiResponse(res, 201, "Client created successfully");
};

export const getClient = async (req, res) => {
  const clients = await getClientService();
  apiResponse(res, 200, "", clients);
};

export const getClientWithContact = async (req, res) => {
  const { id } = req.query;
  console.log(id);

  const clients = await getClientWithContactService(id);
  apiResponse(res, 200, "", clients);
};
