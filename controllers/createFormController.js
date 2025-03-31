import { apiResponse } from "../config/apiResponse.js";
import prisma from "../config/prisma.js";
import { createAccessoryService } from "../models/accessoryModel.js";
import { createContactPersonService } from "../models/contactPersonModel.js";
import { createGpsDeviceService } from "../models/gpsDeviceModel.js";
import { createInstallationEngineerService } from "../models/installationEngineerModel.js";
import { createPeripheralService } from "../models/peripheralModel.js";
import { createServerService } from "../models/serverModel.js";
import { createSimCardService } from "../models/simCardModel.js";
import { createVehicleService } from "../models/vehicleModel.js";

export const createForm = async (req, res) => {
  const bodyData = req.body;
  const client_id = Number(bodyData.client);

  const createFormTransaction = async () => {
    try {
      return await prisma.$transaction(async (prisma) => {
        await Promise.all(
          bodyData.contactPerson.map((contact) =>
            createContactPersonService(prisma, {
              client_id,
              name: contact.name,
              role_id: Number(contact.role),
              phone: contact.phone,
              email: contact.email,
            })
          )
        );

        const vehicle = await createVehicleService(prisma, {
          client_id,
          plate_number: bodyData.vehiclePlateNo,
          type_id: Number(bodyData.vehicleType),
          brand_id: Number(bodyData.vehicleBrand),
          model_id: Number(bodyData.vehicleModel),
          year: Number(bodyData.vehicleYear),
        });

        const gpsDevice = await createGpsDeviceService(prisma, {
          vehicle_id: vehicle.id,
          brand_id: Number(bodyData.gpsBrand),
          model_id: Number(bodyData.gpsModel),
          imei: bodyData.imei,
          serial_no: bodyData.gpsSerial,
          warranty_plan_id: Number(bodyData.warranty),
        });

        if (bodyData.operator) {
          await createSimCardService(prisma, {
            device_id: gpsDevice.id,
            phone_no: bodyData.operator.phone_no,
            operator: bodyData.operator.operator,
          });
        } else {
          await Promise.all(
            bodyData.operators.map((sim) =>
              createSimCardService(prisma, {
                device_id: gpsDevice.id,
                phone_no: sim.phone_no,
                operator: sim.operator,
              })
            )
          );
        }

        await Promise.all(
          bodyData.peripheral.map((peripheralData) =>
            createPeripheralService(prisma, {
              device_id: gpsDevice.id,
              sensor_type_id: Number(peripheralData.sensor_type_id),
              brand_id: Number(peripheralData.brand_id),
              model_id: Number(peripheralData.model_id),
              serial_no: peripheralData.serial_no,
              qty: Number(peripheralData.qty),
              warranty_plan_id: Number(peripheralData.warranty_plan_id),
              warranty_expiry_date: peripheralData.warranty_expiry_date,
            })
          )
        );

        await Promise.all(
          bodyData.accessory.map((accessoryData) =>
            createAccessoryService(prisma, {
              device_id: gpsDevice.id,
              type_id: Number(accessoryData.type_id),
              qty: Number(accessoryData.qty),
            })
          )
        );

        const server = await createServerService(prisma, {
          domain: bodyData.server.domain,
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
      });
    } catch (error) {
      console.error("Error creating vehicle and GPS device:", error);
      apiResponse(res, 400, "Form created failed", error);
    }
  };

  console.log(req.body);
  await createFormTransaction();
  apiResponse(res, 201, "Form created successfully");
};

export const getInstalled = async (req, res) => {
  const { filterByExpireDate } = req.query;
  const now = new Date();
  const currentYear = now.getFullYear();
  const currentMonth = now.getMonth() + 1;

  const whereCondition = filterByExpireDate
    ? {
        device: {
          some: {
            server: {
              some: {
                expire_date: {
                  gte: new Date(currentYear, 0, 1), // From Jan 1st of the current year
                  lt: new Date(currentYear, currentMonth + 1, 1), // Before the current month
                },
              },
            },
          },
        },
      }
    : {};

  const data = await prisma.vehicle.findMany({
    include: {
      client: true,
      device: {
        include: {
          server: true,
        },
      },
    },
    where: whereCondition,
  });
  apiResponse(res, 200, "", data);
};
