export const createInstallImageService = async (prisma, imageRecords) => {
  await prisma.installImage.createMany({
    data: imageRecords,
    skipDuplicates: true,
  });
};
