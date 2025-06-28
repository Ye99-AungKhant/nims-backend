-- AlterEnum
ALTER TYPE "RepairReplacementType" ADD VALUE 'VehicleChange';

-- AlterTable
ALTER TABLE "InstallImage" ADD COLUMN     "vehicle_activity_id" INTEGER;

-- AlterTable
ALTER TABLE "InstallationEngineer" ADD COLUMN     "vehicle_activity_id" INTEGER;

-- CreateTable
CREATE TABLE "VehicleActivity" (
    "id" SERIAL NOT NULL,
    "vehicle_id" INTEGER NOT NULL,
    "plate_number" TEXT NOT NULL,
    "type_id" INTEGER,
    "brand_id" INTEGER,
    "model_id" INTEGER,
    "year" INTEGER,
    "odometer" TEXT,
    "changed_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "reason" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "VehicleActivity_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "VehicleActivity" ADD CONSTRAINT "VehicleActivity_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "Type"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VehicleActivity" ADD CONSTRAINT "VehicleActivity_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "Brand"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VehicleActivity" ADD CONSTRAINT "VehicleActivity_model_id_fkey" FOREIGN KEY ("model_id") REFERENCES "Model"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InstallationEngineer" ADD CONSTRAINT "InstallationEngineer_vehicle_activity_id_fkey" FOREIGN KEY ("vehicle_activity_id") REFERENCES "VehicleActivity"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InstallImage" ADD CONSTRAINT "InstallImage_vehicle_activity_id_fkey" FOREIGN KEY ("vehicle_activity_id") REFERENCES "VehicleActivity"("id") ON DELETE SET NULL ON UPDATE CASCADE;
