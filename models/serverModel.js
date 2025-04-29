// import prisma from "../config/prisma.js";

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
    },
  });
  return server;
};
