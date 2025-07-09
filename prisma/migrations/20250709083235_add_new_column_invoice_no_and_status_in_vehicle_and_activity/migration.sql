-- AlterTable
ALTER TABLE "Vehicle" ADD COLUMN     "invoice_no" TEXT,
ADD COLUMN     "status" "StatusGroup" NOT NULL DEFAULT 'Active';

-- AlterTable
ALTER TABLE "VehicleActivity" ADD COLUMN     "invoice_no" TEXT;
