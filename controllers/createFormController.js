import { apiResponse } from "../config/apiResponse.js";
import prisma from "../config/prisma.js";
import {
  createAccessoryService,
  updateAccessoryService,
} from "../models/accessoryModel.js";
import { createContactPersonService } from "../models/contactPersonModel.js";
import { createInstallImageService } from "../models/fileModel.js";
import {
  createExtraGPSDeviceService,
  createGpsDeviceService,
} from "../models/gpsDeviceModel.js";
import {
  createInstallationEngineerService,
  updateInstallationEngineerService,
} from "../models/installationEngineerModel.js";
import {
  deleteInstallObjectService,
  getInstalledObjectService,
  updateInstallObjectStatusService,
} from "../models/installObjectModel.js";
import {
  createPeripheralService,
  updatePeripheralService,
} from "../models/peripheralModel.js";
import {
  createExtraServerService,
  createServerService,
  updateExtraServerService,
} from "../models/serverModel.js";
import {
  createSimCardService,
  updateSimCardService,
} from "../models/simCardModel.js";
import { createVehicleService } from "../models/vehicleModel.js";
import logger from "../util/logger.js";

const now = new Date();
const currentYear = now.getFullYear();
const currentMonth = now.getMonth() + 1;

export const createInstallObject = async (req, res) => {
  const bodyData = JSON.parse(req.body.data);
  const files = req.files;
  const client_id = Number(bodyData.client);

  const buildVehicleData = {
    client_id,
    plate_number: bodyData.vehiclePlateNo,
  };

  if (bodyData.vehicleType) {
    buildVehicleData.type_id = Number(bodyData.vehicleType);
  }

  if (bodyData.vehicleBrand) {
    buildVehicleData.brand_id = Number(bodyData.vehicleBrand);
  }

  if (bodyData.vehicleModel) {
    buildVehicleData.model_id = Number(bodyData.vehicleModel);
  }

  if (bodyData.vehicleYear) {
    buildVehicleData.year = Number(bodyData.vehicleYear);
  }

  if (bodyData.vehicleOdometer) {
    buildVehicleData.odometer = bodyData.vehicleOdometer;
  }

  const createFormTransaction = async () => {
    try {
      await prisma.$transaction(async (prisma) => {
        // const vehicle = await createVehicleService(prisma, {
        //   client_id,
        //   plate_number: bodyData.vehiclePlateNo,
        //   type_id: Number(bodyData.vehicleType),
        //   brand_id: Number(bodyData.vehicleBrand),
        //   model_id: Number(bodyData.vehicleModel),
        //   year: Number(bodyData.vehicleYear),
        //   odometer: bodyData.vehicleOdometer,
        // });
        const vehicle = await createVehicleService(prisma, buildVehicleData);

        const gpsDevice = await createGpsDeviceService(prisma, {
          vehicle_id: vehicle.id,
          brand_id: Number(bodyData.gpsBrand),
          model_id: Number(bodyData.gpsModel),
          imei: bodyData.imei,
          serial_no: bodyData.gpsSerial,
          warranty_plan_id: Number(bodyData.warranty),
        });

        if (bodyData.extraGPS.length > 0) {
          await Promise.all(
            bodyData.extraGPS.map((extraGps) =>
              createExtraGPSDeviceService(prisma, {
                device_id: gpsDevice.id,
                brand_id: Number(extraGps.gpsBrand),
                model_id: Number(extraGps.gpsModel),
                imei: extraGps.imei,
                serial_no: extraGps.gpsSerial,
                warranty_plan_id: Number(extraGps.warranty),
              })
            )
          );
        }

        await Promise.all(
          bodyData.operators.map((sim) =>
            createSimCardService(prisma, {
              device_id: gpsDevice.id,
              phone_no: sim.phone_no,
              operator: sim.operator,
            })
          )
        );

        if (bodyData.peripheral.length) {
          await Promise.all(
            bodyData.peripheral.map((peripheralData) =>
              createPeripheralService(prisma, {
                device_id: gpsDevice.id,
                sensor_type_id: Number(peripheralData.sensor_type_id),
                qty: Number(peripheralData.qty),
                detail: peripheralData.detail,
                installed_date: peripheralData?.installed_date,
              })
            )
          );
        }

        await Promise.all(
          bodyData.accessory.map((accessoryData) =>
            createAccessoryService(prisma, {
              device_id: gpsDevice.id,
              type_id: Number(accessoryData.type_id),
              qty: Number(accessoryData.qty),
              installed_date: accessoryData?.installed_date,
            })
          )
        );

        const server = await createServerService(prisma, {
          domain_id: Number(bodyData.server.domain[0]),
          type_id: Number(bodyData.server.type_id),
          installed_date: bodyData.server.installed_date,
          subscription_plan_id: Number(bodyData.server.subscription_plan_id),
          expire_date: bodyData.server.expire_date,
          invoice_no: bodyData.server.invoice_no,
          object_base_fee: Number(bodyData.server.object_base_fee),
          gps_device_id: gpsDevice.id,
        });

        if (bodyData.server.domain.length > 1) {
          await createExtraServerService(prisma, {
            server_id: server.id,
            type_id: server.type_id,
            domain_id: Number(bodyData.server.domain[1]),
            status: server.status, // Default status is Active
          });
        }

        await Promise.all(
          bodyData.installationEngineer.map((eng) =>
            createInstallationEngineerService(prisma, {
              user_id: Number(eng.user_id),
              server_id: server.id,
            })
          )
        );

        // Save installImage
        if (files.length) {
          const imageRecords = files.map((file) => ({
            server_id: server.id,
            image_url: `/uploads/${file.filename}`,
          }));

          await createInstallImageService(prisma, imageRecords);
        }
      });
      apiResponse(res, 201, "Installation completed successfully.");
    } catch (error) {
      logger.error(`create new install Error: ${error?.stack || error}`);
      apiResponse(
        res,
        400,
        "Failed to install the object. Please try again.",
        error
      );
    }
  };

  await createFormTransaction();
};

export const updateInstallObject = async (req, res) => {
  const bodyData = JSON.parse(req.body.data);
  const files = req.files;
  const client_id = Number(bodyData.client);
  const vehicle_id = bodyData.vehicleId;
  const gps_id = bodyData.gpsId; // assuming you're passing this

  const installEngIdsToDelete = bodyData.installationEngineer.map(
    (eng) => eng.id
  );

  const updateFormTransaction = async () => {
    try {
      await prisma.$transaction(async (prisma) => {
        // Update vehicle
        await prisma.vehicle.update({
          where: { id: vehicle_id },
          data: {
            client_id,
            plate_number: bodyData.vehiclePlateNo,
            type_id: bodyData.vehicleType ? Number(bodyData.vehicleType) : null,
            brand_id: bodyData.vehicleBrand
              ? Number(bodyData.vehicleBrand)
              : null,
            model_id: bodyData.vehicleModel
              ? Number(bodyData.vehicleModel)
              : null,
            year: bodyData.vehicleYear ? Number(bodyData.vehicleYear) : null,
            odometer: bodyData.vehicleOdometer
              ? bodyData.vehicleOdometer
              : null,
          },
        });

        // Update GPS device
        const gpsDevice = await prisma.gPSDevice.update({
          where: { id: gps_id },
          data: {
            brand_id: Number(bodyData.gpsBrand),
            model_id: Number(bodyData.gpsModel),
            imei: bodyData.imei,
            serial_no: bodyData.gpsSerial,
            warranty_plan_id: Number(bodyData.warranty),
          },
        });

        // Update new SIMs
        await Promise.all(
          bodyData.operators.map((sim) => {
            if (sim.id) {
              return updateSimCardService(prisma, {
                id: sim.id,
                phone_no: sim.phone_no,
                operator: sim.operator,
              });
            } else {
              return createSimCardService(prisma, {
                device_id: gpsDevice.id,
                phone_no: sim.phone_no,
                operator: sim.operator,
              });
            }
          })
        );

        // Update Peripherals
        if (bodyData.peripheral.length) {
          await Promise.all(
            bodyData.peripheral.map((peripheralData) => {
              if (peripheralData.id) {
                return updatePeripheralService(prisma, {
                  id: peripheralData.id,
                  sensor_type_id: Number(peripheralData.sensor_type_id),
                  qty: Number(peripheralData.qty),
                  detail: peripheralData.detail,
                  installed_date: peripheralData?.installed_date,
                });
              } else {
                return createPeripheralService(prisma, {
                  device_id: gpsDevice.id,
                  sensor_type_id: Number(peripheralData.sensor_type_id),
                  qty: Number(peripheralData.qty),
                  detail: peripheralData.detail,
                  installed_date: peripheralData?.installed_date,
                });
              }
            })
          );
        }

        // Update Accessories
        await Promise.all(
          bodyData.accessory.map((accessoryData) => {
            if (accessoryData.id) {
              return updateAccessoryService(prisma, {
                id: accessoryData.id,
                type_id: Number(accessoryData.type_id),
                qty: Number(accessoryData.qty),
                installed_date: accessoryData?.installed_date,
              });
            } else {
              return createAccessoryService(prisma, {
                device_id: gpsDevice.id,
                type_id: Number(accessoryData.type_id),
                qty: Number(accessoryData.qty),
                installed_date: accessoryData?.installed_date,
              });
            }
          })
        );

        // Update server
        const server = await prisma.server.update({
          where: { id: bodyData.server.id },
          data: {
            domain_id: Number(bodyData.server.domain[0]),
            type_id: Number(bodyData.server.type_id),
            installed_date: bodyData.server.installed_date,
            subscription_plan_id: Number(bodyData.server.subscription_plan_id),
            expire_date: bodyData.server.expire_date,
            invoice_no: bodyData.server.invoice_no,
            object_base_fee: Number(bodyData.server.object_base_fee),
          },
        });

        if (bodyData.server.domain.length > 1) {
          if (bodyData.server?.extra_server_id) {
            await updateExtraServerService(prisma, {
              id: bodyData.server.extra_server_id,
              server_id: server.id,
              type_id: server.type_id,
              domain_id: Number(bodyData.server.domain[1]),
              status: server.status, // Default status is Active
            });
          } else {
            await createExtraServerService(prisma, {
              server_id: server.id,
              type_id: server.type_id,
              domain_id: Number(bodyData.server.domain[1]),
              status: server.status, // Default status is Active
            });
          }
        }

        // Update engineers
        await Promise.all(
          bodyData.installationEngineer.map((eng) => {
            if (eng.id) {
              return updateInstallationEngineerService(prisma, {
                id: eng.id,
                user_id: Number(eng.user_id),
              });
            } else {
              return createInstallationEngineerService(prisma, {
                user_id: Number(eng.user_id),
                server_id: server.id,
              });
            }
          })
        );

        if (files.length) {
          const imageRecords = files.map((file) => ({
            server_id: server.id,
            image_url: `/uploads/${file.filename}`,
          }));

          await createInstallImageService(prisma, imageRecords);
        }
      });

      apiResponse(res, 200, "Installation completed successfully.");
    } catch (error) {
      logger.error(`update installed object Error: ${error?.stack || error}`);
      apiResponse(
        res,
        400,
        "Failed to update installed object. Please try again.",
        error
      );
    }
  };

  await updateFormTransaction();
};

export const getInstalled = async (req, res) => {
  const {
    id,
    pageIndex,
    pageSize,
    search,
    filter_by_date,
    filter_by,
    fromDate,
    toDate,
    client_id,
  } = req.query;

  const currentPage = Math.max(Number(pageIndex) || 1, 1);
  const perPage = Number(pageSize) || 10;

  try {
    const installedObjects = await getInstalledObjectService(
      id,
      currentPage,
      perPage,
      search,
      filter_by_date,
      filter_by,
      fromDate,
      toDate,
      client_id
    );
    return apiResponse(res, 200, "", installedObjects);
  } catch (error) {
    return apiResponse(
      res,
      400,
      "Failed to load installed objects due to a network issue. Please try again.",
      error
    );
  }
};

export const updateInstallObjectStatus = async (req, res) => {
  try {
    const objects = await updateInstallObjectStatusService(
      currentYear,
      currentMonth
    );
    console.log(objects);

    apiResponse(res, 200, "Installed objects status updated successful.");
  } catch (error) {
    console.log(error);

    apiResponse(res, 400, "Installed objects status updated failed", error);
  }
};

export const deleteInstallObject = async (req, res) => {
  const { id } = req.params;

  try {
    await deleteInstallObjectService({ vehicleId: Number(id) });
    apiResponse(res, 200, "Installed object deleted successfully.");
  } catch (error) {
    apiResponse(res, 400, "Failed to delete installed object.", error);
  }
};
