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

  const getSimcardHistory = (simChain) => {
    const simcards = [];
    if (simChain.replacements.length == 0) return simChain.simcard;

    const replaced_sim = simChain.replacements.flatMap(
      (r) => r?.replacement_gps?.simcard
    );

    const componentReplacements = simChain.replacements
      .flatMap((r) => r.component_replacements)
      .filter((cr) => cr.component_type === "Operator")
      .sort((a, b) => a.id - b.id);

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
          replacement_id: cr.device_replacement_id,
        });
      });

      const simcardIds = new Set(simcards.map((s) => s.id));

      // Step 2: Filter out any replaced_sim entries that are already in simcards
      const filteredReplaced = replaced_sim.filter(
        (s) => !simcardIds.has(s?.id)
      );

      // Step 3: Combine the simcards with the filtered replaced sims
      const mergedSimcards = [...simcards, ...filteredReplaced]
        .filter((s) => s !== null && s !== undefined)
        .sort((a, b) => a.id - b.id);

      return mergedSimcards;
    } else {
      return simChain.simcard;
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
        where: { status: "Active" },
        include: {
          type: true,
          peripheralDetail: {
            include: { model: true, brand: true, warranty_plan: true },
          },
        },
      },
    },
  });
  // return peripheralChain;

  const getPeripheralHistory = (peripheralChain) => {
    const peripherals = [];
    if (peripheralChain.replacements.length == 0)
      return peripheralChain.peripheral;

    const replaced_peripherals = peripheralChain.replacements.flatMap(
      (r) => r?.replacement_gps?.peripheral
    );

    const componentReplacements = peripheralChain.replacements
      .flatMap((r) => r.component_replacements)
      .filter((cr) => cr.component_type === "Sensor")
      .sort((a, b) => a.id - b.id);

    if (componentReplacements.length > 0) {
      if (!componentReplacements[0].original_peripheral)
        return peripheralChain.peripheral;
      peripherals.push(componentReplacements[0].original_peripheral);

      componentReplacements.forEach((cr, index) => {
        if (!cr.replacement_peripheral) return peripheralChain.peripheral;
        peripherals.push({
          ...cr.replacement_peripheral,
          replacement_component_id: cr.id,
          replacement_reason: cr.replacement_reason,
          replacement_date: cr.replacement_date,
          replacement_id: cr.device_replacement_id,
        });
      });

      const peripheralIds = new Set(peripherals.map((s) => s.id));

      // Step 2: Filter out any replaced_peripheral entries that are already in peripherals
      const filteredReplaced = replaced_peripherals.filter(
        (s) => !peripheralIds.has(s?.id)
      );

      // Step 3: Combine the peripherals with the filtered replaced peripherals
      const mergedPeripherals = [...peripherals, ...filteredReplaced]
        .filter((s) => s !== null && s !== undefined)
        .sort((a, b) => a.id - b.id);

      return mergedPeripherals;
    } else {
      return peripheralChain.peripheral;
    }
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
              original_accessory: {
                include: { type: true },
              },
              replacement_accessory: {
                include: { type: true },
              },
            },
          },
        },
      },
      accessory: {
        where: { status: "Active" },
        include: { type: true },
      },
    },
  });

  // return accessoryChain;

  const getAccessoryHistory = (accessoryChain) => {
    const accessories = [];
    if (accessoryChain.replacements.length == 0)
      return accessoryChain.accessory;

    const replaced_accessory = accessoryChain.replacements.flatMap(
      (r) => r?.replacement_gps?.accessory
    );

    const componentReplacements = accessoryChain.replacements
      .flatMap((r) => r.component_replacements)
      .filter((cr) => cr.component_type === "Accessory")
      .sort((a, b) => a.id - b.id);

    console.log(componentReplacements);

    if (componentReplacements.length > 0) {
      if (!componentReplacements[0].original_accessory)
        return accessoryChain.accessory;
      accessories.push(componentReplacements[0].original_accessory);

      componentReplacements.forEach((cr, index) => {
        if (!cr.replacement_accessory) return accessoryChain.accessory;
        accessories.push({
          ...cr.replacement_accessory,
          replacement_component_id: cr.id,
          replacement_reason: cr.replacement_reason,
          replacement_date: cr.replacement_date,
          replacement_id: cr.device_replacement_id,
        });
      });

      const accessoryIds = new Set(accessories.map((s) => s.id));

      // Step 2: Filter out any replaced_accessory entries that are already in accessories
      const filteredReplaced = replaced_accessory.filter(
        (s) => !accessoryIds.has(s?.id)
      );

      // Step 3: Combine the accessories with the filtered replaced accessories
      const mergedAccessories = [...accessories, ...filteredReplaced]
        .filter((s) => s !== null && s !== undefined)
        .sort((a, b) => a.id - b.id);

      return mergedAccessories;
    } else {
      return accessoryChain.accessory;
    }
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
