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
  const today = new Date();
  const expireDate = new Date(expire_date);
  const normalize = (date) =>
    new Date(date.getFullYear(), date.getMonth(), date.getDate());

  const normalizedToday = normalize(today);
  const normalizedExpireDate = normalize(expireDate);

  let status = null;
  if (normalizedExpireDate.getTime() === normalizedToday.getTime()) {
    status = "Expired";
  } else if (normalizedExpireDate.getTime() < normalizedToday.getTime()) {
    status = "ExpireSoon"; // Already expired (in the past)
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
