import { apiResponse } from "../config/apiResponse.js";
import prisma from "../config/prisma.js";
import { createAccessoryService } from "../models/accessoryModel.js";
import { createInstallImageService } from "../models/fileModel.js";
import { createGpsDeviceService } from "../models/gpsDeviceModel.js";
import { createInstallationEngineerService } from "../models/installationEngineerModel.js";
import { createPeripheralService } from "../models/peripheralModel.js";
import {
  createDeviceRepairReplacementService,
  deleteRplacementService,
  getAccessoryReplacementHistoryService,
  getGPSReplacementHistoryService,
  getPeripheralReplacementHistoryService,
  getRepairReplacementFullHistoryService,
  getSIMCardReplacementHistoryService,
  updateAccessoryReplacementService,
  updateGPSReplacementService,
  updatePeripheralReplacementService,
  updateSIMCardReplacementService,
} from "../models/repairReplacementModel.js";
import { createSimCardService } from "../models/simCardModel.js";
import logger from "../util/logger.js";

export const createPlacement = async (req, res) => {
  const bodyData = JSON.parse(req.body.data);
  const files = req.files;
  const vehicle_id = bodyData.vehicleId;
  const original_gps_id = bodyData.gpsId;
  const replaced_gps_id = bodyData.gpsId_replaced;
  const reason = bodyData?.reason;
  const invoice_no = bodyData?.invoice_no;
  const repair_replacement_by_user_id = bodyData?.repair_replacement_by_user_id;
  const repair_replacement_date = bodyData?.repair_replacement_date;
  const replacementType = bodyData.replacementType;
  const serverId = bodyData.server.id;
  let gpsDeviceId = replaced_gps_id;

  try {
    await prisma.$transaction(async (prisma) => {
      if (replacementType.length === 4) {
        const newgpsDevice = await createGpsDeviceService(prisma, {
          vehicle_id: vehicle_id,
          brand_id: Number(bodyData.gpsBrand),
          model_id: Number(bodyData.gpsModel),
          imei: bodyData.imei,
          serial_no: bodyData.gpsSerial,
          warranty_plan_id: Number(bodyData.warranty),
        });

        // 4. Create device replacement record
        const deviceReplacement = await createDeviceRepairReplacementService(
          prisma,
          {
            original_gps_id: original_gps_id,
            repair_replacement_gps_id: newgpsDevice.id,
            type: "Replacement",
            replacement_device_type: "Full_Device",
            reason: reason,
            invoice_no: invoice_no,
            repair_replacement_by_user_id: repair_replacement_by_user_id,
            repair_replacement_date: repair_replacement_date,
          }
        );

        await Promise.all(
          bodyData.operators.map(async (simData) => {
            if (!simData?.is_replacement) {
              return await prisma.simCard.update({
                where: { id: simData?.id },
                data: { device_id: newgpsDevice.id },
              });
            }

            const newSim = await createSimCardService(prisma, {
              device_id: newgpsDevice.id,
              phone_no: simData.phone_no,
              operator: simData.operator,
            });

            await prisma.componentReplacement.create({
              data: {
                device_replacement_id: deviceReplacement.id,
                component_type: "Operator",
                replacement_reason: reason,
                replacement_date: new Date(repair_replacement_date),
                original_simcard_id: simData.id,
                replacement_simcard_id: newSim.id,
              },
            });

            if (simData?.id) {
              await prisma.simCard.update({
                where: { id: simData?.id },
                data: { status: "Replaced" },
              });
            }
          })
        );

        await Promise.all(
          bodyData.peripheral.map(async (peripheralData) => {
            if (!peripheralData?.is_replacement) {
              return await prisma.peripheral.update({
                where: {
                  id: peripheralData?.id || peripheralData?.replaced_id,
                },
                data: { device_id: newgpsDevice.id },
              });
            }

            const newPeripheral = await createPeripheralService(prisma, {
              device_id: newgpsDevice.id,
              sensor_type_id: Number(peripheralData.sensor_type_id),
              qty: Number(peripheralData.qty),
              detail: peripheralData.detail,
            });

            await prisma.componentReplacement.create({
              data: {
                device_replacement_id: deviceReplacement.id,
                component_type: "Sensor",
                replacement_reason: reason,
                replacement_date: new Date(repair_replacement_date),
                original_peripheral_id:
                  peripheralData?.id || peripheralData.replaced_id,
                replacement_peripheral_id: newPeripheral.id,
              },
            });

            if (peripheralData?.id || peripheralData?.replaced_id) {
              await prisma.peripheral.update({
                where: {
                  id: peripheralData?.id || peripheralData?.replaced_id,
                },
                data: { status: "Replaced" },
              });
            }
          })
        );

        await Promise.all(
          bodyData.accessory.map(async (accessoryData) => {
            if (!accessoryData?.is_replacement) {
              return await prisma.accessory.update({
                where: {
                  id: accessoryData?.id || accessoryData?.replaced_id,
                },
                data: { device_id: newgpsDevice.id },
              });
            }

            const newAccessory = await createAccessoryService(prisma, {
              device_id: newgpsDevice.id,
              type_id: Number(accessoryData.type_id),
              qty: Number(accessoryData.qty),
            });

            await prisma.componentReplacement.create({
              data: {
                device_replacement_id: deviceReplacement.id,
                component_type: "Accessory",
                replacement_reason: reason,
                replacement_date: new Date(repair_replacement_date),
                original_accessory_id:
                  accessoryData?.id || accessoryData.replaced_id,
                replacement_accessory_id: newAccessory.id,
              },
            });

            if (accessoryData?.id || accessoryData?.replaced_id) {
              await prisma.accessory.update({
                where: {
                  id: accessoryData?.id || accessoryData?.replaced_id,
                },
                data: { status: "Replaced" },
              });
            }
          })
        );

        // 7. Update original device status
        await prisma.gPSDevice.update({
          where: { id: replaced_gps_id },
          data: { status: "Replaced" },
        });

        await Promise.all(
          bodyData.installationEngineer.map(
            async (eng) =>
              await createInstallationEngineerService(prisma, {
                user_id: Number(eng.user_id),
                device_repair_replacement_id: deviceReplacement.id,
              })
          )
        );

        // Save installImage
        if (files.length) {
          const imageRecords = files.map((file) => ({
            server_id: serverId,
            device_repair_replacement_id: deviceReplacement.id,
            type: "Replacement",
            image_url: `/uploads/${file.filename}`,
          }));

          await createInstallImageService(prisma, imageRecords);
        }
      } else {
        const isGPSReplaced = replacementType.includes("GPS_Device");

        if (isGPSReplaced) {
          const gpsDevice = await createGpsDeviceService(prisma, {
            vehicle_id: vehicle_id,
            brand_id: Number(bodyData.gpsBrand),
            model_id: Number(bodyData.gpsModel),
            imei: bodyData.imei,
            serial_no: bodyData.gpsSerial,
            warranty_plan_id: Number(bodyData.warranty),
          });
          gpsDeviceId = gpsDevice.id;

          await prisma.gPSDevice.update({
            where: { id: replaced_gps_id },
            data: { status: "Replaced" },
          });
        }

        const deviceReplacement = await createDeviceRepairReplacementService(
          prisma,
          {
            original_gps_id: original_gps_id,
            repair_replacement_gps_id: isGPSReplaced ? gpsDeviceId : null,
            type: "Replacement",
            replacement_device_type: isGPSReplaced
              ? "Partial_Replacement"
              : "Component_Only",
            reason: reason,
            invoice_no: invoice_no,
            repair_replacement_by_user_id: repair_replacement_by_user_id,
            repair_replacement_date: repair_replacement_date,
          }
        );

        //Re-associate any un-replaced components to the new device
        if (!replacementType.includes("SIM")) {
          await prisma.simCard.updateMany({
            where: { device_id: replaced_gps_id, status: "Active" },
            data: { device_id: gpsDeviceId },
          });
        }
        if (!replacementType.includes("Peripheral")) {
          await prisma.peripheral.updateMany({
            where: { device_id: replaced_gps_id, status: "Active" },
            data: { device_id: gpsDeviceId },
          });
        }
        if (!replacementType.includes("Accessories")) {
          await prisma.accessory.updateMany({
            where: { device_id: replaced_gps_id, status: "Active" },
            data: { device_id: gpsDeviceId },
          });
        }

        if (replacementType.includes("SIM")) {
          await Promise.all(
            bodyData.operators.map(async (simData) => {
              if (!simData?.is_replacement) {
                return await prisma.simCard.update({
                  where: { id: simData?.id },
                  data: { device_id: gpsDeviceId },
                });
              }

              if (!simData?.is_replacement) return;

              const newSim = await createSimCardService(prisma, {
                device_id: isGPSReplaced ? gpsDeviceId : replaced_gps_id,
                phone_no: simData.phone_no,
                operator: simData.operator,
              });

              await prisma.componentReplacement.create({
                data: {
                  device_replacement_id: deviceReplacement.id,
                  component_type: "Operator",
                  replacement_reason: reason,
                  replacement_date: new Date(repair_replacement_date),
                  original_simcard_id: simData.id,
                  replacement_simcard_id: newSim.id,
                },
              });

              if (simData?.id) {
                await prisma.simCard.update({
                  where: { id: simData?.id },
                  data: { status: "Replaced" },
                });
              }
            })
          );
        }

        if (replacementType.includes("Peripheral")) {
          await Promise.all(
            bodyData.peripheral.map(async (peripheralData) => {
              if (!peripheralData?.is_replacement) {
                return await prisma.peripheral.update({
                  where: {
                    id: peripheralData?.id || peripheralData?.replaced_id,
                  },
                  data: { device_id: gpsDeviceId },
                });
              }

              const newPeripheral = await createPeripheralService(prisma, {
                device_id: isGPSReplaced ? gpsDeviceId : replaced_gps_id,
                sensor_type_id: Number(peripheralData.sensor_type_id),
                qty: Number(peripheralData.qty),
                detail: peripheralData.detail,
              });

              await prisma.componentReplacement.create({
                data: {
                  device_replacement_id: deviceReplacement.id,
                  component_type: "Sensor",
                  replacement_reason: reason,
                  replacement_date: new Date(repair_replacement_date),
                  original_peripheral_id:
                    peripheralData?.id || peripheralData.replaced_id,
                  replacement_peripheral_id: newPeripheral.id,
                },
              });

              if (peripheralData?.id || peripheralData?.replaced_id) {
                await prisma.peripheral.update({
                  where: {
                    id: peripheralData?.id || peripheralData?.replaced_id,
                  },
                  data: { status: "Replaced" },
                });
              }
            })
          );
        }

        if (replacementType.includes("Accessories")) {
          await Promise.all(
            bodyData.accessory.map(async (accessoryData) => {
              if (!accessoryData?.is_replacement) {
                return await prisma.accessory.update({
                  where: {
                    id: accessoryData?.id || accessoryData?.replaced_id,
                  },
                  data: { device_id: gpsDeviceId },
                });
              }

              const newAccessory = await createAccessoryService(prisma, {
                device_id: isGPSReplaced ? gpsDeviceId : replaced_gps_id,
                type_id: Number(accessoryData.type_id),
                qty: Number(accessoryData.qty),
              });

              await prisma.componentReplacement.create({
                data: {
                  device_replacement_id: deviceReplacement.id,
                  component_type: "Accessory",
                  replacement_reason: reason,
                  replacement_date: new Date(repair_replacement_date),
                  original_accessory_id:
                    accessoryData?.id || accessoryData.replaced_id,
                  replacement_accessory_id: newAccessory.id,
                },
              });

              if (accessoryData?.id || accessoryData?.replaced_id) {
                await prisma.accessory.update({
                  where: {
                    id: accessoryData?.id || accessoryData?.replaced_id,
                  },
                  data: { status: "Replaced" },
                });
              }
            })
          );
        }

        if (bodyData.installationEngineer) {
          await Promise.all(
            bodyData.installationEngineer.map(
              async (eng) =>
                await createInstallationEngineerService(prisma, {
                  user_id: Number(eng.user_id),
                  device_repair_replacement_id: deviceReplacement.id,
                })
            )
          );
        }

        // Save installImage
        if (files.length) {
          const imageRecords = files.map((file) => ({
            server_id: serverId,
            device_repair_replacement_id: deviceReplacement.id,
            type: "Replacement",
            image_url: `/uploads/${file.filename}`,
          }));

          await createInstallImageService(prisma, imageRecords);
        }
      }
    });
    apiResponse(res, 201, "Object replaced successfully.");
  } catch (error) {
    logger.error(`Replacement Error: ${error?.stack || error}`);
    apiResponse(
      res,
      400,
      "Failed to replace the object. Please try again.",
      error
    );
  }
};

export const createRepair = async (req, res) => {
  const bodyData = JSON.parse(req.body.data);
  const files = req.files;
  const vehicle_id = bodyData.vehicleId;
  const original_gps_id = bodyData.gpsId;
  const reason = bodyData?.reason;
  const invoice_no = bodyData?.invoice_no;
  const repair_replacement_by_user_id = bodyData?.repair_replacement_by_user_id;
  const repair_replacement_date = bodyData?.repair_replacement_date;
  const serverId = bodyData.server.id;
  const user_false = bodyData.user_false;

  try {
    const deviceRepair = await createDeviceRepairReplacementService(prisma, {
      original_gps_id: original_gps_id,
      type: "Repair",
      reason: reason,
      invoice_no: invoice_no,
      repair_replacement_by_user_id: repair_replacement_by_user_id,
      repair_replacement_date: repair_replacement_date,
      user_false: user_false,
    });

    if (bodyData.installationEngineer) {
      await Promise.all(
        bodyData.installationEngineer.map(
          async (eng) =>
            await createInstallationEngineerService(prisma, {
              user_id: Number(eng.user_id),
              device_repair_replacement_id: deviceRepair.id,
            })
        )
      );
    }

    // Save installImage
    if (files.length) {
      const imageRecords = files.map((file) => ({
        server_id: serverId,
        device_repair_replacement_id: deviceRepair.id,
        type: "Repair",
        image_url: `/uploads/${file.filename}`,
      }));

      await createInstallImageService(prisma, imageRecords);
    }
    apiResponse(res, 201, "Device repaired successfully.");
  } catch (error) {
    logger.error(`Repair Error: ${error?.stack || error}`);
    apiResponse(
      res,
      400,
      "Failed to repair the object. Please try again.",
      error
    );
  }
};

export const getGPSReplacementHistory = async (req, res) => {
  try {
    const history = await getGPSReplacementHistoryService(
      prisma,
      Number(req.query.deviceId)
    );
    apiResponse(res, 200, "", history);
  } catch (error) {
    logger.error(`GetGPSReplacementHistory Error: ${error?.stack || error}`);
    apiResponse(
      res,
      400,
      "Oops! Couldn't load GPS device activity. Please try again.",
      error
    );
  }
};

export const updateGPSReplacement = async (req, res) => {
  try {
    const bodyData = req.body;
    await updateGPSReplacementService(prisma, bodyData);
    apiResponse(res, 200, "GPS replacement updated successfully.");
  } catch (error) {
    logger.error(`UpdateGPSReplacement Error: ${error?.stack || error}`);
    apiResponse(res, 400, "Update GPS replacement failed.", error);
  }
};

export const getSIMCardReplacementHistory = async (req, res) => {
  try {
    const history = await getSIMCardReplacementHistoryService(
      prisma,
      Number(req.query.gpsDeviceId)
    );
    apiResponse(res, 200, "", history);
  } catch (error) {
    logger.error(
      `GetSIMCardReplacementHistory Error: ${error?.stack || error}`
    );
    apiResponse(
      res,
      400,
      "Oops! Couldn't load SIM card activity. Please try again.",
      error
    );
  }
};

export const updateSIMCardReplacement = async (req, res) => {
  try {
    const bodyData = req.body;
    await updateSIMCardReplacementService(prisma, bodyData);
    apiResponse(res, 200, "SIM card replacement updated successfully.");
  } catch (error) {
    logger.error(`UpdateSIMCardReplacement Error: ${error?.stack || error}`);
    console.log(error);
    apiResponse(res, 400, "Update simcard replacement failed.", error);
  }
};

export const getPeripheralReplacementHistory = async (req, res) => {
  try {
    const history = await getPeripheralReplacementHistoryService(
      prisma,
      Number(req.query.gpsDeviceId)
    );
    apiResponse(res, 200, "", history);
  } catch (error) {
    logger.error(
      `GetPeripheralReplacementHistory Error: ${error?.stack || error}`
    );
    apiResponse(
      res,
      400,
      "Oops! Couldn't load peripheral activity. Please try again.",
      error
    );
  }
};

export const updatePeripheralReplacement = async (req, res) => {
  try {
    const bodyData = req.body;
    await updatePeripheralReplacementService(prisma, bodyData);
    apiResponse(res, 200, "Peripheral replacement updated successfully.");
  } catch (error) {
    logger.error(`UpdatePeripheralReplacement Error: ${error?.stack || error}`);
    apiResponse(res, 400, "Update peripheral replacement failed.", error);
  }
};

export const getAccessoryReplacementHistory = async (req, res) => {
  try {
    const history = await getAccessoryReplacementHistoryService(
      prisma,
      Number(req.query.gpsDeviceId)
    );
    apiResponse(res, 200, "", history);
  } catch (error) {
    logger.error(
      `GetAccessoryReplacementHistory Error: ${error?.stack || error}`
    );
    apiResponse(
      res,
      400,
      "Oops! Couldn't load accessory activity. Please try again.",
      error
    );
  }
};

export const updateAccessoryReplacement = async (req, res) => {
  try {
    const bodyData = req.body;
    await updateAccessoryReplacementService(prisma, bodyData);
    apiResponse(res, 200, "Accessory replacement updated successfully.");
  } catch (error) {
    logger.error(`UpdateAccessoryReplacement Error: ${error?.stack || error}`);
    apiResponse(res, 400, "Update accessory replacement failed.", error);
  }
};

export const getRepairReplacementFullHistory = async (req, res) => {
  try {
    const history = await getRepairReplacementFullHistoryService(
      prisma,
      Number(req.query.gpsDeviceId)
    );
    apiResponse(res, 200, "", history);
  } catch (error) {
    logger.error(
      `GetRepairReplacementFullHistory Error: ${error?.stack || error}`
    );
    apiResponse(
      res,
      400,
      "Oops! Couldn't load repair/replacement history. Please try again.",
      error
    );
  }
};

export const deleteReplacement = async (req, res) => {
  try {
    const { id } = req.body;
    await deleteRplacementService(prisma, id);
    apiResponse(res, 200, "Type delete Successful.");
  } catch (error) {
    logger.error(`DeleteReplacement Error: ${error?.stack || error}`);
    apiResponse(res, 400, "Type delete failed.", error);
  }
};
