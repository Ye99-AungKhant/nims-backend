import { apiResponse } from "../config/apiResponse.js";
import prisma from "../config/prisma.js";
import { createAccessoryService } from "../models/accessoryModel.js";
import { createContactPersonService } from "../models/contactPersonModel.js";
import { createInstallImageService } from "../models/fileModel.js";
import {
  createExtraGPSDeviceService,
  createGpsDeviceService,
} from "../models/gpsDeviceModel.js";
import { createInstallationEngineerService } from "../models/installationEngineerModel.js";
import {
  getInstalledObjectService,
  updateInstallObjectStatusService,
} from "../models/installObjectModel.js";
import { createPeripheralService } from "../models/peripheralModel.js";
import { createServerService } from "../models/serverModel.js";
import { createSimCardService } from "../models/simCardModel.js";
import { createVehicleService } from "../models/vehicleModel.js";

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
          domain_id: Number(bodyData.server.domain),
          type_id: Number(bodyData.server.type_id),
          installed_date: bodyData.server.installed_date,
          subscription_plan_id: Number(bodyData.server.subscription_plan_id),
          expire_date: bodyData.server.expire_date,
          invoice_no: bodyData.server.invoice_no,
          object_base_fee: Number(bodyData.server.object_base_fee),
          gps_device_id: gpsDevice.id,
        });

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
      apiResponse(res, 201, "Object installation created successful.");
    } catch (error) {
      console.error("Error:", error);
      apiResponse(res, 400, "Form created failed", error);
    }
  };

  await createFormTransaction();
  // apiResponse(res, 201, "Object installation created successful.");
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

        // Delete old SIMs, Peripherals, Accessories
        await prisma.simCard.deleteMany({
          where: { device_id: gpsDevice.id },
        });
        await prisma.peripheral.deleteMany({
          where: { device_id: gpsDevice.id },
        });
        await prisma.accessory.deleteMany({
          where: { device_id: gpsDevice.id },
        });

        // Recreate new SIMs
        await Promise.all(
          bodyData.operators.map((sim) =>
            createSimCardService(prisma, {
              device_id: gpsDevice.id,
              phone_no: sim.phone_no,
              operator: sim.operator,
            })
          )
        );

        // Recreate new Peripherals
        if (bodyData.peripheral.length) {
          await Promise.all(
            bodyData.peripheral.map((peripheralData) =>
              createPeripheralService(prisma, {
                device_id: gpsDevice.id,
                sensor_type_id: Number(peripheralData.sensor_type_id),
                qty: Number(peripheralData.qty),
                detail: peripheralData.detail,
              })
            )
          );
        }

        // Recreate new Accessories
        await Promise.all(
          bodyData.accessory.map((accessoryData) =>
            createAccessoryService(prisma, {
              device_id: gpsDevice.id,
              type_id: Number(accessoryData.type_id),
              qty: Number(accessoryData.qty),
            })
          )
        );

        // Update server
        const server = await prisma.server.update({
          where: { id: bodyData.server.id },
          data: {
            domain_id: Number(bodyData.server.domain),
            type_id: Number(bodyData.server.type_id),
            installed_date: bodyData.server.installed_date,
            subscription_plan_id: Number(bodyData.server.subscription_plan_id),
            expire_date: bodyData.server.expire_date,
            invoice_no: bodyData.server.invoice_no,
            object_base_fee: Number(bodyData.server.object_base_fee),
          },
        });

        // Delete old engineers
        await prisma.installationEngineer.deleteMany({
          where: {
            server_id: server.id,
          },
        });

        // Recreate engineers
        await Promise.all(
          bodyData.installationEngineer.map((eng) =>
            createInstallationEngineerService(prisma, {
              user_id: Number(eng.user_id),
              server_id: server.id,
            })
          )
        );

        if (files.length) {
          const imageRecords = files.map((file) => ({
            server_id: server.id,
            image_url: `/uploads/${file.filename}`,
          }));

          await createInstallImageService(prisma, imageRecords);
        }
      });

      apiResponse(res, 200, "Object installation updated successfully.");
    } catch (error) {
      console.error("Error updating vehicle and GPS device:", error);
      apiResponse(res, 400, "Form update failed", error);
    }
  };

  await updateFormTransaction();
};

export const getInstalled = async (req, res) => {
  const {
    filterByExpireDate,
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

  const installedObjects = await getInstalledObjectService(
    filterByExpireDate,
    currentYear,
    currentMonth,
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

  apiResponse(res, 200, "", installedObjects);
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
