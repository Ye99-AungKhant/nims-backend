-- CreateEnum
CREATE TYPE "StatusGroup" AS ENUM ('Active', 'Expired', 'Inactive');

-- AlterTable
ALTER TABLE "Server" ADD COLUMN     "status" "StatusGroup" NOT NULL DEFAULT 'Active';
