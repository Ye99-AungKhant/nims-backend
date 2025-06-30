import { updateAccessoryService } from "./accessoryModel.js";
import { updateGPSDeviceService } from "./gpsDeviceModel.js";
import { updatePeripheralService } from "./peripheralModel.js";
import { updateSimCardService } from "./simCardModel.js";

export const createDeviceRepairReplacementService = async (prisma, data) => {
  const res = await prisma.deviceRepairReplacement.create({
    data: {
      ...data,
      repair_replacement_date: new Date(data.repair_replacement_date),
    },
  });

  return res;
};

export const getGPSReplacementHistoryService = async (prisma, deviceId) => {
  console.log(deviceId);
  const gpsChain = await prisma.gPSDevice.findUnique({
    where: { id: deviceId },
    include: {
      replacements: {
        where: { type: "Replacement", is_deleted: false },
        include: {
          replacement_gps: {
            include: {
              brand: true,
              model: true,
              warranty_plan: true,
            },
          },
          replaced_by_user: true,
        },
      },
      brand: true,
      model: true,
      warranty_plan: true,
      extra_gps_device: {
        include: {
          brand: true,
          model: true,
          warranty_plan: true,
        },
      },
    },
  });

  if (gpsChain.status === "Active") {
    return { ...gpsChain, replacements: [] };
  }

  return gpsChain;
};

export const updateGPSReplacementService = async (prisma, data) => {
  const gpsData = {
    id: data.gpsId,
    brand_id: Number(data.gpsBrand),
    model_id: Number(data.gpsModel),
    imei: data.imei,
    serial_no: data.gpsSerial,
    warranty_plan_id: Number(data.warranty),
  };
  await updateGPSDeviceService(prisma, gpsData);

  if (data.reason || data.repair_replacement_date) {
    await prisma.deviceRepairReplacement.update({
      where: { id: data.id },
      data: {
        reason: data.reason,
        repair_replacement_date: new Date(data.repair_replacement_date),
      },
    });
  }
  return;
};

export const getSIMCardReplacementHistoryService = async (
  prisma,
  gpsDeviceId
) => {
  const simChain = await prisma.gPSDevice.findUnique({
    where: { id: gpsDeviceId },
    include: {
      replacements: {
        where: { type: "Replacement", is_deleted: false },
        include: {
          replacement_gps: true,
          component_replacements: {
            include: {
              original_simcard: true,
              replacement_simcard: true,
            },
          },
        },
      },
      simcard: { where: { status: "Active" } },
    },
  });

  const getSimcardHistory = (simChain) => {
    const simcards = [];
    if (simChain.replacements.length == 0) return simChain.simcard;

    const componentReplacements = simChain.replacements.flatMap(
      (r) => r.component_replacements
    );
    // console.log(simChain.replacements.id);

    if (componentReplacements.length > 0) {
      if (!componentReplacements[0].original_simcard) return simChain.simcard;
      simcards.push(componentReplacements[0].original_simcard);

      componentReplacements.forEach((cr, index) => {
        if (!cr.replacement_simcard) return simChain.simcard;
        simcards.push({
          ...cr.replacement_simcard,
          replacement_component_id: cr.id,
          replacement_reason: cr.replacement_reason,
          replacement_date: cr.replacement_date,
          replacement_id: simChain.replacements[index].id,
        });
      });

      return simcards;
    }
  };
  return getSimcardHistory(simChain);
};

export const updateSIMCardReplacementService = async (prisma, data) => {
  const simData = data.operators[0];
  await updateSimCardService(prisma, simData);

  if (data.reason || data.repair_replacement_date) {
    await prisma.deviceRepairReplacement.update({
      where: { id: data.replacementId },
      data: {
        reason: data.reason,
        repair_replacement_date: new Date(data.repair_replacement_date),
      },
    });

    await prisma.componentReplacement.update({
      where: {
        id: data.replacement_component_id,
      },
      data: {
        replacement_reason: data.reason,
        replacement_date: new Date(data.repair_replacement_date),
      },
    });
  }
  return;
};

export const getPeripheralReplacementHistoryService = async (
  prisma,
  gpsDeviceId
) => {
  const periperalChain = await prisma.peripheral.findMany({
    where: {
      device_id: gpsDeviceId,
    },
    include: {
      type: true,
      replacement_of: {
        include: {
          device_replacement: true,
        },
      },
      peripheralDetail: {
        include: { model: true, brand: true, warranty_plan: true },
      },
    },
    orderBy: { id: "asc" },
  });

  const getPeripheralHistory = (periperalChain) => {
    return periperalChain
      .map((item) => {
        if (item.replacement_of) {
          if (!item.replacement_of.length > 0) return item;
          return {
            ...item,
            replacement_id: item.replacement_of[0].id,
            replacement_reason: item.replacement_of[0].replacement_reason,
            replacement_date: item.replacement_of[0].replacement_date,
          };
        }
      })
      .filter((peripheral) => {
        if (peripheral.replacement_of.length > 0) {
          return peripheral.replacement_of[0].device_replacement?.is_deleted ==
            false
            ? peripheral
            : null;
        } else {
          return peripheral;
        }
      });
  };
  return getPeripheralHistory(periperalChain);
};

export const updatePeripheralReplacementService = async (prisma, data) => {
  const peripheralData = {
    id: data.peripheral[0].id,
    sensor_type_id: Number(data.peripheral[0].sensor_type_id),
    qty: Number(data.peripheral[0].qty),
    detail: data.peripheral[0].detail,
  };
  await updatePeripheralService(prisma, peripheralData);

  const component = await prisma.componentReplacement.update({
    where: { id: data.replacementId },
    data: {
      replacement_reason: data.reason,
      replacement_date: new Date(data.repair_replacement_date),
    },
  });

  await prisma.deviceRepairReplacement.update({
    where: { id: component.device_replacement_id },
    data: {
      reason: data.reason,
      repair_replacement_date: new Date(data.repair_replacement_date),
    },
  });
  return;
};

export const getAccessoryReplacementHistoryService = async (
  prisma,
  gpsDeviceId
) => {
  const accessoryChain = await prisma.accessory.findMany({
    where: { device_id: gpsDeviceId },
    include: {
      type: true,
      replacement_of: {
        include: {
          device_replacement: true,
        },
      },
    },
    orderBy: { id: "asc" },
  });

  const getAccessoryChainHistory = (accessoryChain) => {
    return accessoryChain
      .map((item) => {
        if (item.replacement_of) {
          if (!item.replacement_of.length > 0) return item;
          return {
            ...item,
            replacement_reason: item.replacement_of[0].replacement_reason,
            replacement_date: item.replacement_of[0].replacement_date,
          };
        }
      })
      .filter((accessory) => {
        if (accessory.replacement_of.length > 0) {
          return accessory.replacement_of[0].device_replacement?.is_deleted ==
            false
            ? accessory
            : null;
        } else {
          return accessory;
        }
      });
  };
  return getAccessoryChainHistory(accessoryChain);
};

export const updateAccessoryReplacementService = async (prisma, data) => {
  const accessoryData = data.accessory[0];
  await updateAccessoryService(prisma, accessoryData);

  if (data.reason || data.repair_replacement_date) {
    const component = await prisma.componentReplacement.update({
      where: {
        id: data.replacement_component_id,
      },
      data: {
        replacement_reason: data.reason,
        replacement_date: new Date(data.repair_replacement_date),
      },
    });

    await prisma.deviceRepairReplacement.update({
      where: { id: component.device_replacement_id },
      data: {
        reason: data.reason,
        repair_replacement_date: new Date(data.repair_replacement_date),
      },
    });
  }
  return;
};

export const getRepairReplacementFullHistoryService = async (
  prisma,
  gpsDeviceId
) => {
  const gpsChain = await prisma.gPSDevice.findUnique({
    where: { id: gpsDeviceId },
    include: {
      brand: true,
      model: true,
      warranty_plan: true,
      replacements: {
        where: { is_deleted: false },
        include: {
          replacement_gps: {
            include: {
              brand: true,
              model: true,
              warranty_plan: true,
            },
          },
          install_engineer: { include: { user: true } },
          component_replacements: {
            include: {
              replacement_simcard: true,
              replacement_peripheral: true,
              replacement_accessory: true,
            },
          },
        },
        orderBy: { id: "asc" },
      },
    },
  });

  // if (gpsChain.status === "Active") {
  //   return { ...gpsChain, replacements: [] };
  // }

  return gpsChain;
};

export const deleteRplacementService = async (prisma, id) => {
  await prisma.deviceRepairReplacement.update({
    where: { id },
    data: { is_deleted: true },
  });
  return;
};
