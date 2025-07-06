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
    data:{
      server_id,
      type_id,
      domain_id,
      status
    }
  })
}

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
    extra_server_id
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

     const renewalData= await prismaTrans.server.update({
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
              })
      }
    });
  } catch (error) {
    return error;
  }
};
