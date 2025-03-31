import { apiResponse } from "../config/apiResponse.js";
import { createPeripheralService } from "../models/peripheralModel.js";

export const createPeripheral = async (req, res) => {
  const {
    device_id,
    sensor_type_id,
    brand_id,
    model_id,
    serial_no,
    qty,
    warranty_plan_id,
    warranty_expiry_date,
  } = req.body;
  const peripheral = await createPeripheralService(
    device_id,
    sensor_type_id,
    brand_id,
    model_id,
    serial_no,
    qty,
    warranty_plan_id,
    warranty_expiry_date
  );
  apiResponse(res, 201, "Peripheral created successfully", peripheral);
};
