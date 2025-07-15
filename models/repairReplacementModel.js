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
        orderBy: { id: "asc" },
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
          replacement_gps: {
            include: {
              simcard: true,
            },
          },
          component_replacements: {
            include: {
              original_simcard: true,
              replacement_simcard: true,
            },
          },
        },
      },
      simcard: true,
    },
  });

  // return simChain;

  const getComponentSimcardHistory = (componentReplacements) => {
    const result = [];

    const sorted = componentReplacements
      .filter((cr) => cr.component_type === "Operator")
      .sort((a, b) => a.id - b.id);

    if (!sorted.length || !sorted[0].original_simcard) return [];

    result.push(sorted[0].original_simcard);

    for (const cr of sorted) {
      if (cr.replacement_simcard) {
        result.push({
          ...cr.replacement_simcard,
          replacement_component_id: cr.id,
          replacement_reason: cr.replacement_reason,
          replacement_date: cr.replacement_date,
          replacement_id: cr.device_replacement_id,
        });
      }
    }

    return result;
  };

  const getSimcardHistory = (chain) => {
    const { replacements, simcard: activeSimcards } = chain;

    if (!replacements?.length) return activeSimcards;

    const replacedSimcards = replacements
      .flatMap((r) => r?.replacement_gps?.simcard)
      .filter(Boolean);

    const componentHistory = getComponentSimcardHistory(
      replacements.flatMap((r) => r.component_replacements)
    );

    console.log("componentHistory", componentHistory);

    // if (!componentHistory.length) return activeSimcards;

    const existingIds = new Set(componentHistory.map((s) => s?.id));
    console.log("existingIds", existingIds);

    const filteredReplaced = replacedSimcards.filter(
      (s) => !existingIds.has(s?.id)
    );

    const mergedSimcards = [...componentHistory, ...filteredReplaced]
      .filter(Boolean)
      .sort((a, b) => a?.id - b?.id);

    const mergedIds = new Set(mergedSimcards.map((s) => s?.id));
    const untouchedSimcards = activeSimcards.filter(
      (s) => !mergedIds.has(s?.id)
    );

    const result = [...untouchedSimcards, ...mergedSimcards].sort(
      (a, b) => a?.id - b?.id
    );

    return result;
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
  const peripheralChain = await prisma.gPSDevice.findUnique({
    where: { id: gpsDeviceId },
    include: {
      replacements: {
        where: { type: "Replacement", is_deleted: false },
        include: {
          replacement_gps: {
            include: {
              peripheral: {
                include: {
                  type: true,
                  peripheralDetail: {
                    include: { model: true, brand: true, warranty_plan: true },
                  },
                },
              },
            },
          },
          component_replacements: {
            include: {
              original_peripheral: {
                include: {
                  type: true,
                  peripheralDetail: {
                    include: { model: true, brand: true, warranty_plan: true },
                  },
                },
              },
              replacement_peripheral: {
                include: {
                  type: true,
                  peripheralDetail: {
                    include: { model: true, brand: true, warranty_plan: true },
                  },
                },
              },
            },
          },
        },
      },
      peripheral: {
        include: {
          type: true,
          peripheralDetail: {
            include: { model: true, brand: true, warranty_plan: true },
          },
        },
      },
    },
  });

  const getComponentHistory = (componentReplacements) => {
    const result = [];

    const sorted = componentReplacements
      .filter((cr) => cr.component_type === "Sensor")
      .sort((a, b) => a.id - b.id);

    if (!sorted.length || !sorted[0].original_peripheral) return [];

    result.push(sorted[0].original_peripheral);

    for (const cr of sorted) {
      if (cr.replacement_peripheral) {
        result.push({
          ...cr.replacement_peripheral,
          replacement_component_id: cr.id,
          replacement_reason: cr.replacement_reason,
          replacement_date: cr.replacement_date,
          replacement_id: cr.device_replacement_id,
        });
      }
    }

    return result;
  };

  const getPeripheralHistory = (chain) => {
    const { replacements, peripheral: activePeripherals } = chain;

    if (!replacements?.length) return activePeripherals;

    const replacedPeripherals = replacements
      .flatMap((r) => r?.replacement_gps?.peripheral)
      .filter(Boolean);

    const componentHistory = getComponentHistory(
      replacements.flatMap((r) => r.component_replacements)
    );

    // if (!componentHistory.length) return activePeripherals;

    const existingIds = new Set(componentHistory.map((p) => p?.id));
    const filteredReplaced = replacedPeripherals.filter(
      (p) => !existingIds.has(p?.id)
    );

    const mergedPeripherals = [...componentHistory, ...filteredReplaced]
      .filter(Boolean)
      .sort((a, b) => a?.id - b?.id);

    const mergedIds = new Set(mergedPeripherals.map((p) => p?.id));
    const untouchedPeripherals = activePeripherals.filter(
      (p) => !mergedIds.has(p?.id)
    );

    const result = [...untouchedPeripherals, ...mergedPeripherals].sort(
      (a, b) => a?.id - b?.id
    );
    return result;
  };

  return getPeripheralHistory(peripheralChain);
};

export const updatePeripheralReplacementService = async (prisma, data) => {
  const peripheralData = {
    id: data.peripheral[0].id,
    sensor_type_id: Number(data.peripheral[0].sensor_type_id),
    qty: Number(data.peripheral[0].qty),
    detail: data.peripheral[0].detail,
  };
  await updatePeripheralService(prisma, peripheralData);

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

export const getAccessoryReplacementHistoryService = async (
  prisma,
  gpsDeviceId
) => {
  const accessoryChain = await prisma.gPSDevice.findUnique({
    where: { id: gpsDeviceId },
    include: {
      replacements: {
        where: { type: "Replacement", is_deleted: false },
        include: {
          replacement_gps: {
            include: {
              accessory: { include: { type: true } },
            },
          },
          component_replacements: {
            include: {
              original_accessory: { include: { type: true } },
              replacement_accessory: { include: { type: true } },
            },
          },
        },
      },
      accessory: {
        include: { type: true },
      },
    },
  });

  // return accessoryChain;

  const getComponentAccessoryHistory = (componentReplacements) => {
    const result = [];

    const sorted = componentReplacements
      .filter((cr) => cr.component_type === "Accessory")
      .sort((a, b) => a.id - b.id);

    if (!sorted.length || !sorted[0].original_accessory) return [];

    result.push(sorted[0].original_accessory);

    for (const cr of sorted) {
      if (cr.replacement_accessory) {
        result.push({
          ...cr.replacement_accessory,
          replacement_component_id: cr.id,
          replacement_reason: cr.replacement_reason,
          replacement_date: cr.replacement_date,
          replacement_id: cr.device_replacement_id,
        });
      }
    }

    return result;
  };

  const getAccessoryHistory = (chain) => {
    const { replacements, accessory: activeAccessories } = chain;

    if (!replacements?.length) return activeAccessories;

    const replacedAccessories = replacements
      .flatMap((r) => r?.replacement_gps?.accessory)
      .filter(Boolean);

    const componentHistory = getComponentAccessoryHistory(
      replacements.flatMap((r) => r.component_replacements)
    );

    // if (!componentHistory.length) return activeAccessories;

    const existingIds = new Set(componentHistory.map((a) => a?.id));
    const filteredReplaced = replacedAccessories.filter(
      (a) => !existingIds.has(a?.id)
    );

    const mergedAccessories = [...componentHistory, ...filteredReplaced].filter(
      Boolean
    );

    const mergedIds = new Set(mergedAccessories.map((a) => a?.id));
    const untouchedAccessories = activeAccessories.filter(
      (a) => !mergedIds.has(a?.id)
    );

    const result = [...untouchedAccessories, ...mergedAccessories].sort(
      (a, b) => a?.id - b?.id
    );

    return result;
  };

  return getAccessoryHistory(accessoryChain);
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

  const activities = await prisma.vehicleActivity.findMany({
    where: { vehicle_id: gpsChain.vehicle_id },
    include: {
      type: true,
      brand: true,
      model: true,
    },
    orderBy: { id: "asc" },
  });

  // if (gpsChain.status === "Active") {
  //   return { ...gpsChain, replacements: [] };
  // }

  return { ...gpsChain, vehicleChange: activities };
};

export const deleteRplacementService = async (prisma, id) => {
  await prisma.deviceRepairReplacement.update({
    where: { id },
    data: { is_deleted: true },
  });
  return;
};
