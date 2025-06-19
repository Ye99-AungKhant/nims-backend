-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "StatusGroup" ADD VALUE 'Yes';
ALTER TYPE "StatusGroup" ADD VALUE 'No';

-- AlterTable
ALTER TABLE "DeviceRepairReplacement" ADD COLUMN     "user_false" "StatusGroup",
ALTER COLUMN "replacement_device_type" DROP NOT NULL;
