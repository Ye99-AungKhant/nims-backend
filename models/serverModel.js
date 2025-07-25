// import prisma from "../config/prisma.js";

const today = new Date();
const normalize = (date) =>
  new Date(date.getFullYear(), date.getMonth(), date.getDate());
const getNewDate = (date) => new Date(date);

export const createServerService = async (
  prisma,
  {
    domain_id,
    type_id,
    installed_date,
    subscription_plan_id,
    expire_date,
    invoice_no,
    object_base_fee,
    gps_device_id,
  }
) => {
  const expireDate = getNewDate(expire_date);
  const normalizedToday = normalize(today);
  const normalizedExpireDate = normalize(expireDate);
  const oneMonthFromToday = getNewDate(normalizedToday);
  oneMonthFromToday.setMonth(oneMonthFromToday.getMonth() + 1);

  let status;

  if (normalizedExpireDate.getTime() <= normalizedToday.getTime()) {
    status = "Expired";
  } else if (
    normalizedExpireDate.getTime() > normalizedToday.getTime() &&
    normalizedExpireDate.getTime() <= oneMonthFromToday.getTime()
  ) {
    status = "ExpireSoon";
  }

  const server = await prisma.server.create({
    data: {
      domain_id,
      type_id,
      installed_date: new Date(installed_date),
      subscription_plan_id,
      expire_date: new Date(expire_date),
      invoice_no,
      object_base_fee,
      gps_device_id,
      ...(status && { status }),
    },
  });
  return server;
};

export const createExtraServerService = async (
  prisma,
  {
    server_id,
    type_id,
    domain_id,
    status = "Active", // Default status is Active
  }
) => {
  return await prisma.extraServer.create({
    data: {
      server_id,
      type_id,
      domain_id,
      status,
    },
  });
};

export const updateExtraServerService = async (
  prisma,
  {
    id,
    server_id,
    type_id,
    domain_id,
    status = "Active", // Default status is Active
  }
) => {
  return await prisma.extraServer.update({
    where: { id },
    data: {
      server_id,
      type_id,
      domain_id,
      status,
    },
  });
};

export const renewalServerService = async (
  prisma,
  {
    id,
    domain,
    type_id,
    subscription_plan_id,
    object_base_fee,
    expire_date,
    invoice_no,
    renewal_date,
    extra_server_id,
  }
) => {
  const expireDate = getNewDate(expire_date);
  const normalizedToday = normalize(today);
  const normalizedExpireDate = normalize(expireDate);
  const oneMonthFromToday = getNewDate(normalizedToday);
  oneMonthFromToday.setMonth(oneMonthFromToday.getMonth() + 1);

  let status;

  if (normalizedExpireDate.getTime() <= normalizedToday.getTime()) {
    status = "Expired";
  } else if (
    normalizedExpireDate.getTime() > normalizedToday.getTime() &&
    normalizedExpireDate.getTime() <= oneMonthFromToday.getTime()
  ) {
    status = "ExpireSoon";
  }

  const serverOldData = await prisma.server.findFirst({
    where: { id },
  });

  try {
    return await prisma.$transaction(async (prismaTrans) => {
      await prismaTrans.serverActivity.create({
        data: {
          server_id: serverOldData.id,
          domain_id: serverOldData.domain_id,
          type_id: serverOldData.type_id,
          installed_date: serverOldData.installed_date,
          renewal_date: serverOldData.renewal_date,
          expire_date: serverOldData.expire_date,
          subscription_plan_id: serverOldData.subscription_plan_id,
          invoice_no: serverOldData.invoice_no,
          object_base_fee: serverOldData.object_base_fee,
          status: serverOldData.status,
        },
      });

      // await prismaTrans.serverActivity.create({
      //   data: {
      //     server_id: serverOldData.id,
      //     domain_id: domain_id,
      //     type_id: type_id,
      //     installed_date: serverOldData.installed_date,
      //     renewal_date: renewal_date,
      //     expire_date: expire_date,
      //     subscription_plan_id: subscription_plan_id,
      //     invoice_no: invoice_no,
      //     object_base_fee: object_base_fee,
      //     status: status,
      //   },
      // });

      const renewalData = await prismaTrans.server.update({
        where: { id },
        data: {
          domain_id: Number(domain[0]),
          type_id,
          subscription_plan_id,
          object_base_fee,
          renewal_date,
          expire_date,
          invoice_no,
          ...(status && { status }),
        },
      });

      if (domain.length > 1) {
        await updateExtraServerService(prismaTrans, {
          id: extra_server_id,
          server_id: renewalData.id,
          type_id: renewalData.type_id,
          domain_id: Number(domain[1]),
          status: renewalData.status, // Default status is Active
        });
      }
    });
  } catch (error) {
    return error;
  }
};

export const serverReportService = async (
  prisma,
  {
    filterType,
    filterId,
    filter_by,
    search = "",
    client_id,
    currentPage,
    perPage,
  }
) => {
  let data = [];
  let totalCount = 0;
  let totalPages = 0;

  // Build search filter
  const searchOR = search
    ? [
        { device: { imei: { contains: search, mode: "insensitive" } } },
        {
          device: {
            vehicle: {
              plate_number: { contains: search, mode: "insensitive" },
            },
          },
        },
        { invoice_no: { contains: search, mode: "insensitive" } },
      ]
    : [];

  // Server (with extraServer included), filter by type or domain
  let where = {};
  if (filterType === "type" && filterId) {
    where.type_id = Number(filterId);
  } else if (filterType === "domain" && filterId) {
    where.domain_id = Number(filterId);
  }
  if (filter_by) {
    where.status = filter_by;
  }
  if (client_id) {
    where.device = {
      vehicle: {
        client_id: Number(client_id),
      },
    };
  }
  if (searchOR.length) where = { ...where, OR: searchOR };
  totalCount = await prisma.server.count({ where });
  totalPages = Math.ceil(totalCount / perPage);
  const servers = await prisma.server.findMany({
    where,
    include: {
      device: {
        include: {
          vehicle: {
            include: { client: true },
          },
        },
      },
      type: true,
      domain: true,
      extra_server: {
        include: {
          type: true,
          domain: true,
        },
      },
    },
    orderBy: { id: "desc" },
    skip: (currentPage - 1) * perPage,
    take: perPage,
  });
  data = servers.map((s) => ({
    source: "server",
    server_id: s.id,
    type: s.type?.name,
    domain: s.domain?.name,
    installed_date: s.installed_date,
    renewal_date: s.renewal_date,
    expire_date: s.expire_date,
    invoice_no: s.invoice_no,
    object_base_fee: s.object_base_fee,
    status: s.status,
    device_id: s.device?.id,
    device_imei: s.device?.imei,
    vehicle_id: s.device?.vehicle?.id,
    vehicle_plate_number: s.device?.vehicle?.plate_number,
    client: {
      id: s.device?.vehicle?.client?.id,
      name: s.device?.vehicle?.client?.name,
    },
    extra_server: Array.isArray(s.extra_server)
      ? s.extra_server.map((es) => ({
          extra_server_id: es.id,
          type: es.type?.name,
          domain: es.domain?.name,
          status: es.status,
        }))
      : [],
  }));

  // ExtraServer
  // if (filterType === "extraServer") {
  //   let where = {};
  //   if (filterId) where.id = Number(filterId);
  //   if (searchOR.length) where = { ...where, OR: searchOR };
  //   totalCount = await prisma.extraServer.count({ where });
  //   totalPages = Math.ceil(totalCount / perPage);
  //   const extraServers = await prisma.extraServer.findMany({
  //     where,
  //     include: {
  //       server: {
  //         include: {
  //           device: {
  //             include: {
  //               vehicle: {
  //                 include: { client: true },
  //               },
  //             },
  //           },
  //         },
  //       },
  //       type: true,
  //       domain: true,
  //     },
  //     orderBy: { id: "desc" },
  //     skip: (currentPage - 1) * perPage,
  //     take: perPage,
  //   });
  //   data = extraServers.map((es) => ({
  //     source: "extraServer",
  //     extra_server_id: es.id,
  //     type: es.type?.name,
  //     domain: es.domain?.name,
  //     status: es.status,
  //     server_id: es.server?.id,
  //     installed_date: es.server?.installed_date,
  //     renewal_date: es.server?.renewal_date,
  //     expire_date: es.server?.expire_date,
  //     invoice_no: es.server?.invoice_no,
  //     object_base_fee: es.server?.object_base_fee,
  //     status: es.server?.status,
  //     device_id: es.server?.device?.id,
  //     device_imei: es.server?.device?.imei,
  //     vehicle_id: es.server?.device?.vehicle?.id,
  //     vehicle_plate_number: es.server?.device?.vehicle?.plate_number,
  //     client: {
  //       id: es.server?.device?.vehicle?.client?.id,
  //       name: es.server?.device?.vehicle?.client?.name,
  //     },
  //   }));
  // }

  // ServerActivity
  // if (filterType === "activity") {
  //   let where = {};
  //   if (filterId) where.id = Number(filterId);
  //   if (searchOR.length) where = { ...where, OR: searchOR };
  //   totalCount = await prisma.serverActivity.count({ where });
  //   totalPages = Math.ceil(totalCount / perPage);
  //   const activities = await prisma.serverActivity.findMany({
  //     where,
  //     include: {
  //       server: {
  //         include: {
  //           device: {
  //             include: {
  //               vehicle: {
  //                 include: { client: true },
  //               },
  //             },
  //           },
  //         },
  //       },
  //       type: true,
  //       domain: true,
  //     },
  //     orderBy: { id: "desc" },
  //     skip: (currentPage - 1) * perPage,
  //     take: perPage,
  //   });
  //   data = activities.map((a) => ({
  //     source: "activity",
  //     activity_id: a.id,
  //     type: a.type?.name,
  //     domain: a.domain?.name,
  //     installed_date: a.installed_date,
  //     renewal_date: a.renewal_date,
  //     expire_date: a.expire_date,
  //     invoice_no: a.invoice_no,
  //     object_base_fee: a.object_base_fee,
  //     status: a.status,
  //     server_id: a.server?.id,
  //     device_id: a.server?.device?.id,
  //     device_imei: a.server?.device?.imei,
  //     vehicle_id: a.server?.device?.vehicle?.id,
  //     vehicle_plate_number: a.server?.device?.vehicle?.plate_number,
  //     client: {
  //       id: a.server?.device?.vehicle?.client?.id,
  //       name: a.server?.device?.vehicle?.client?.name,
  //     },
  //   }));
  // }

  return {
    data,
    totalCount,
    totalPages,
    currentPage,
    perPage,
  };
};
