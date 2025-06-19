import dayjs from "dayjs";
import prisma from "./../config/prisma.js";
import { log } from "console";

const now = new Date();
const currentYear = now.getFullYear();

export const getDashboardDataService = async (filterYear) => {
  const totalObjects = await prisma.vehicle.count();
  const totalActiveObjects = await prisma.server.count({
    where: { status: "Active" },
  });
  const totalExpireSoonObjects = await prisma.server.count({
    where: { status: "ExpireSoon" },
  });
  const totalExpiredObjects = await prisma.server.count({
    where: { status: "Expired" },
  });
  const totalClients = await prisma.client.count();

  const year = parseInt(filterYear) || dayjs().year();

  const startDate = dayjs(`${year}-01-01`).startOf("year").toDate();
  const endDate = dayjs(`${year}-12-31`).endOf("year").toDate();

  const servers = await prisma.server.findMany({
    where: {
      OR: [
        {
          installed_date: {
            gte: startDate,
            lte: endDate,
          },
        },
        {
          expire_date: {
            gte: startDate,
            lte: endDate,
          },
        },
      ],
    },
    select: {
      installed_date: true,
      expire_date: true,
      server_activity: {
        where: { renewal_date: { not: null } },
        select: { renewal_date: true },
      },
    },
  });

  const monthlyStats = {};
  //   console.log(servers);

  for (const server of servers) {
    const installMonth = dayjs(server.installed_date).format("MMM YYYY");
    const expireMonth = dayjs(server.expire_date).format("MMM YYYY");

    // Count installed
    if (dayjs(server.installed_date).year() === year) {
      monthlyStats[installMonth] ??= {
        InstallObject: 0,
        ExpiredObject: 0,
        RenewalObject: 0,
      };
      monthlyStats[installMonth].InstallObject++;
    }

    // Count expired
    if (dayjs(server.expire_date).year() === year) {
      monthlyStats[expireMonth] ??= {
        InstallObject: 0,
        ExpiredObject: 0,
        RenewalObject: 0,
      };
      monthlyStats[expireMonth].ExpiredObject++;
    }

    // Count renewals
    for (const activity of server.server_activity) {
      if (
        activity.renewal_date &&
        dayjs(activity.renewal_date).year() === year
      ) {
        const renewalMonth = dayjs(activity.renewal_date).format("MMM YYYY");
        monthlyStats[renewalMonth] ??= {
          InstallObject: 0,
          ExpiredObject: 0,
          RenewalObject: 0,
        };
        monthlyStats[renewalMonth].RenewalObject++;
      }
    }
  }

  const monthlyData = Object.entries(monthlyStats)
    .sort(
      ([a], [b]) => new Date(`1 ${a}`).getTime() - new Date(`1 ${b}`).getTime()
    )
    .map(([month, values]) => ({ month, ...values }));

  const uniqueBrands = await prisma.gPSDevice.findMany({
    distinct: ["brand_id"],
    select: { brand: true },
  });
  const brandCount = uniqueBrands.length;

  // Count unique models
  const uniqueModels = await prisma.gPSDevice.findMany({
    distinct: ["model_id"],
    select: { model: true },
  });
  const modelCount = uniqueModels.length;

  const domainIdCounts = await prisma.server.groupBy({
    by: ["domain_id"],
    _count: { domain_id: true },
  });
  log("Domain ID Counts:", domainIdCounts);

  const domainIds = domainIdCounts.map((item) => item.domain_id);

  const domainBrands = await prisma.brand.findMany({
    where: { id: { in: domainIds } },
    select: {
      id: true,
      name: true,
    },
  });

  // Step 3: Merge counts with names
  const usedServer = domainIdCounts.map((countItem) => {
    const domain = domainBrands.find((d) => d.id === countItem.domain_id);
    return {
      domain_id: countItem.domain_id,
      domain_name: domain?.name ?? null,
      count: countItem._count.domain_id,
    };
  });

  return {
    totalObjects,
    totalActiveObjects,
    totalExpireSoonObjects,
    totalExpiredObjects,
    totalClients,
    monthlyData,
    brandCount,
    modelCount,
    usedServer,
  };
};
