import { apiResponse } from "../config/apiResponse.js";
import { createServerService } from "../models/serverModel.js";

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
  apiResponse(res, 201, "Server created successfully", server);
};
