import { apiResponse } from "../config/apiResponse.js";
import prisma from "../config/prisma.js";
import {
  createServerService,
  renewalServerService,
} from "../models/serverModel.js";
import AuditLogService from "../models/auditLogModel.js";

export const createServer = async (req, res) => {
  const {
    domain,
    type_id,
    installed_date,
    subscription_plan_id,
    expire_date,
    invoice_no,
    object_base_fee,
    gps_device_id,
  } = req.body;
  const server = await createServerService(
    domain,
    type_id,
    installed_date,
    subscription_plan_id,
    expire_date,
    invoice_no,
    object_base_fee,
    gps_device_id
  );
  // Audit log integration
  try {
    await AuditLogService.create({
      user_id: req.user?.id || null,
      action: "CREATE",
      table_name: "Server",
      record_id: server?.id || null,
      ip_address: req.ip || null,
    });
  } catch (auditError) {
    console.error(`Audit log error: ${auditError?.stack || auditError}`);
  }
  apiResponse(res, 201, "Server created successfully", server);
};

export const renewalServer = async (req, res) => {
  const {
    id,
    renewalDate,
    expireDate,
    subscriptionPlan,
    objectBaseFee,
    type,
    domain,
    invoiceNo,
    extra_server_id,
  } = req.body;

  try {
    await renewalServerService(prisma, {
      id,
      domain: domain,
      type_id: Number(type),
      subscription_plan_id: Number(subscriptionPlan),
      object_base_fee: Number(objectBaseFee),
      expire_date: expireDate,
      invoice_no: invoiceNo,
      renewal_date: renewalDate,
      extra_server_id,
    });

    // Audit log integration
    try {
      await AuditLogService.create({
        user_id: req.user?.id || null,
        action: "RENEWAL",
        table_name: "Server",
        record_id: id,
        ip_address: req.ip || null,
      });
    } catch (auditError) {
      console.error(`Audit log error: ${auditError?.stack || auditError}`);
    }
    apiResponse(res, 200, "Server was successfully renewed.");
  } catch (error) {
    console.log(error);
    apiResponse(
      res,
      400,
      "Something went wrong while renewing the server. Please try again.",
      error
    );
  }
};
