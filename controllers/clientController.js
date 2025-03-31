import { apiResponse } from "../config/apiResponse.js";
import {
  createClientService,
  getClientService,
  getClientWithContactService,
} from "../models/clientModel.js";

export const createClient = async (req, res) => {
  const { name, address } = req.body;
  const client = await createClientService(name, address);
  apiResponse(res, 201, "Client created successfully", client);
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
