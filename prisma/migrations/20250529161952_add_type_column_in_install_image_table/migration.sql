-- AlterEnum
ALTER TYPE "RepairReplacementType" ADD VALUE 'Installed';

-- AlterTable
ALTER TABLE "InstallImage" ADD COLUMN     "type" "RepairReplacementType";
