-- CreateEnum
CREATE TYPE "RepairReplacementType" AS ENUM ('Repair', 'Replacement');

-- AlterEnum
ALTER TYPE "StatusGroup" ADD VALUE 'Replaced';

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "TypeGroup" ADD VALUE 'Full_Device';
ALTER TYPE "TypeGroup" ADD VALUE 'Component_Only';
ALTER TYPE "TypeGroup" ADD VALUE 'Partial_Replacement';

-- DropForeignKey
ALTER TABLE "InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_server_id_fkey";

-- DropIndex
DROP INDEX "GPSDevice_imei_key";

-- AlterTable
ALTER TABLE "Accessory" ADD COLUMN     "status" "StatusGroup" NOT NULL DEFAULT 'Active';

-- AlterTable
ALTER TABLE "GPSDevice" ADD COLUMN     "status" "StatusGroup" NOT NULL DEFAULT 'Active';

-- AlterTable
ALTER TABLE "InstallationEngineer" ADD COLUMN     "device_repair_replacement_id" INTEGER,
ALTER COLUMN "server_id" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Peripheral" ADD COLUMN     "status" "StatusGroup" NOT NULL DEFAULT 'Active';

-- AlterTable
ALTER TABLE "SimCard" ADD COLUMN     "status" "StatusGroup" NOT NULL DEFAULT 'Active';

-- CreateTable
CREATE TABLE "InstallImage" (
    "id" SERIAL NOT NULL,
    "server_id" INTEGER NOT NULL,
    "device_repair_replacement_id" INTEGER,
    "image_url" TEXT NOT NULL,

    CONSTRAINT "InstallImage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DeviceRepairReplacement" (
    "id" SERIAL NOT NULL,
    "original_gps_id" INTEGER NOT NULL,
    "repair_replacement_gps_id" INTEGER,
    "repair_replacement_by_user_id" INTEGER NOT NULL,
    "type" "RepairReplacementType" NOT NULL,
    "replacement_device_type" "TypeGroup" NOT NULL,
    "reason" TEXT NOT NULL,
    "repair_replacement_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DeviceRepairReplacement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ComponentReplacement" (
    "id" SERIAL NOT NULL,
    "device_replacement_id" INTEGER NOT NULL,
    "component_type" "TypeGroup" NOT NULL,
    "replacement_reason" TEXT,
    "replacement_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "original_simcard_id" INTEGER,
    "original_peripheral_id" INTEGER,
    "original_accessory_id" INTEGER,
    "replacement_simcard_id" INTEGER,
    "replacement_peripheral_id" INTEGER,
    "replacement_accessory_id" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ComponentReplacement_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "InstallationEngineer" ADD CONSTRAINT "InstallationEngineer_server_id_fkey" FOREIGN KEY ("server_id") REFERENCES "Server"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InstallationEngineer" ADD CONSTRAINT "InstallationEngineer_device_repair_replacement_id_fkey" FOREIGN KEY ("device_repair_replacement_id") REFERENCES "DeviceRepairReplacement"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InstallImage" ADD CONSTRAINT "InstallImage_server_id_fkey" FOREIGN KEY ("server_id") REFERENCES "Server"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InstallImage" ADD CONSTRAINT "InstallImage_device_repair_replacement_id_fkey" FOREIGN KEY ("device_repair_replacement_id") REFERENCES "DeviceRepairReplacement"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeviceRepairReplacement" ADD CONSTRAINT "DeviceRepairReplacement_original_gps_id_fkey" FOREIGN KEY ("original_gps_id") REFERENCES "GPSDevice"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeviceRepairReplacement" ADD CONSTRAINT "DeviceRepairReplacement_repair_replacement_gps_id_fkey" FOREIGN KEY ("repair_replacement_gps_id") REFERENCES "GPSDevice"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DeviceRepairReplacement" ADD CONSTRAINT "DeviceRepairReplacement_repair_replacement_by_user_id_fkey" FOREIGN KEY ("repair_replacement_by_user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ComponentReplacement" ADD CONSTRAINT "ComponentReplacement_device_replacement_id_fkey" FOREIGN KEY ("device_replacement_id") REFERENCES "DeviceRepairReplacement"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ComponentReplacement" ADD CONSTRAINT "ComponentReplacement_original_simcard_id_fkey" FOREIGN KEY ("original_simcard_id") REFERENCES "SimCard"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ComponentReplacement" ADD CONSTRAINT "ComponentReplacement_original_peripheral_id_fkey" FOREIGN KEY ("original_peripheral_id") REFERENCES "Peripheral"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ComponentReplacement" ADD CONSTRAINT "ComponentReplacement_original_accessory_id_fkey" FOREIGN KEY ("original_accessory_id") REFERENCES "Accessory"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ComponentReplacement" ADD CONSTRAINT "ComponentReplacement_replacement_simcard_id_fkey" FOREIGN KEY ("replacement_simcard_id") REFERENCES "SimCard"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ComponentReplacement" ADD CONSTRAINT "ComponentReplacement_replacement_peripheral_id_fkey" FOREIGN KEY ("replacement_peripheral_id") REFERENCES "Peripheral"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ComponentReplacement" ADD CONSTRAINT "ComponentReplacement_replacement_accessory_id_fkey" FOREIGN KEY ("replacement_accessory_id") REFERENCES "Accessory"("id") ON DELETE SET NULL ON UPDATE CASCADE;
