-- AlterTable
ALTER TABLE "Permission" ADD COLUMN     "renewal" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "repair" BOOLEAN NOT NULL DEFAULT false;
