import { apiResponse } from "../config/apiResponse.js";
import {
  createClientService,
  deleteClientService,
  getClientObjectService,
  getClientService,
  getClientWithContactService,
  updateClientService,
} from "../models/clientModel.js";
import {
  createContactPersonService,
  deleteContactPersonOfClientService,
  updateContactPersonService,
} from "../models/contactPersonModel.js";
import prisma from "../config/prisma.js";
import logger from "../util/logger.js";
import AuditLogService from "../models/auditLogModel.js";

export const createClient = async (req, res) => {
  const client = await createClientService(req.body);

  try {
    await AuditLogService.create({
      user_id: req.user?.id || null,
      action: "CREATE",
      table_name: "Client",
      record_id: client?.id || null,
      ip_address: req.ip || null,
    });
  } catch (auditError) {
    logger.error(`Audit log error: ${auditError?.stack || auditError}`);
  }
  apiResponse(res, 201, "Client created successfully", client);
};

export const createClientWithContact = async (req, res) => {
  const { clientData, contactPerson } = req.body;

  try {
    const client = await createClientService(clientData);

    await Promise.all(
      contactPerson.map((person) =>
        createContactPersonService(prisma, {
          client_id: client.id,
          name: person.contactName,
          role_id: person.role_id,
          phone: person.phone,
          email: person.email,
        })
      )
    );
    try {
      await AuditLogService.create({
        user_id: req.user?.id || null,
        action: "CREATE",
        table_name: "Client",
        record_id: client?.id || null,
        ip_address: req.ip || null,
        description: "Client with Contacts",
      });
    } catch (auditError) {
      logger.error(`Audit log error: ${auditError?.stack || auditError}`);
    }

    apiResponse(res, 201, "Client created successfully");
  } catch (error) {
    console.error("Error creating client with contacts:", error);
    apiResponse(res, 500, "Failed to create client with contacts");
  }
};

export const updateClientWithContact = async (req, res) => {
  const { id, data } = req.body;
  const { clientData, contactPerson } = data;

  const client = await updateClientService(id, clientData);

  await Promise.all(
    contactPerson.map((person) =>
      updateContactPersonService(prisma, {
        client_id: id,
        id: Number(person.id),
        name: person.contactName,
        role_id: Number(person.role_id),
        phone: person.phone,
        email: person.email,
      })
    )
  );
  try {
    await AuditLogService.create({
      user_id: req.user?.id || null,
      action: "UPDATE",
      table_name: "Client",
      record_id: client?.id || null,
      ip_address: req.ip || null,
      description: "Client with Contacts",
    });
  } catch (auditError) {
    logger.error(`Audit log error: ${auditError?.stack || auditError}`);
  }

  apiResponse(res, 201, "Client updated successfully");
};

export const getClient = async (req, res) => {
  const { search } = req.query;
  const clients = await getClientService(search);
  apiResponse(res, 200, "", clients);
};

export const getClientWithContact = async (req, res) => {
  const { id, pageIndex, pageSize, search, criteria } = req.query;
  const currentPage = Math.max(Number(pageIndex) || 1, 1);
  const perPage = Number(pageSize) || 10;

  const data = await getClientWithContactService(
    id,
    currentPage,
    perPage,
    search,
    criteria
  );
  apiResponse(res, 200, "", data);
};

export const getClientObjects = async (req, res) => {
  try {
    const { id } = req.query;
    const data = await getClientObjectService(Number(id));
    apiResponse(res, 200, "", data);
  } catch (error) {
    apiResponse(res, 400, "This client have not installed objects", error);
  }
};

export const deleteClientWithContact = async (req, res) => {
  const { id } = req.params;

  await deleteContactPersonOfClientService(prisma, { id: Number(id) });
  await deleteClientService(Number(id));
  try {
    await AuditLogService.create({
      user_id: req.user?.id || null,
      action: "DELETE",
      table_name: "Client",
      record_id: client?.id || null,
      ip_address: req.ip || null,
      description: "Client with Contacts",
    });
  } catch (auditError) {
    logger.error(`Audit log error: ${auditError?.stack || auditError}`);
  }
  apiResponse(res, 200, "Client deleted successfully.");
};
