import prisma from "../config/prisma.js";
import { unlink } from "fs/promises";
import path from "path";

export const deleteInstallImageService = async (id) => {
  const file = await prisma.installImage.findFirst({
    where: { id },
  });

  if (!file) {
    return file;
  }

  // 2. Delete the file from the filesystem
  const filePath = path.join("public", file.image_url); // Adjust path if needed

  await unlink(filePath, (err) => {
    if (err) {
      console.error("Error deleting file:", err);
    } else {
      console.log("File deleted:", filePath);
    }
  });

  // 3. Delete the record from DB
  await prisma.installImage.delete({
    where: { id },
  });

  return;
};
