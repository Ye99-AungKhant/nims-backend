-- AlterTable
ALTER TABLE "Accessory" ADD COLUMN     "installed_date" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "Peripheral" ADD COLUMN     "installed_date" TIMESTAMP(3);

-- CreateTable
CREATE TABLE "ExtraGPSDevice" (
    "id" SERIAL NOT NULL,
    "device_id" INTEGER NOT NULL,
    "brand_id" INTEGER NOT NULL,
    "model_id" INTEGER NOT NULL,
    "imei" TEXT NOT NULL,
    "serial_no" TEXT NOT NULL,
    "warranty_plan_id" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ExtraGPSDevice_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ExtraGPSDevice" ADD CONSTRAINT "ExtraGPSDevice_device_id_fkey" FOREIGN KEY ("device_id") REFERENCES "GPSDevice"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExtraGPSDevice" ADD CONSTRAINT "ExtraGPSDevice_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "Brand"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExtraGPSDevice" ADD CONSTRAINT "ExtraGPSDevice_model_id_fkey" FOREIGN KEY ("model_id") REFERENCES "Model"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExtraGPSDevice" ADD CONSTRAINT "ExtraGPSDevice_warranty_plan_id_fkey" FOREIGN KEY ("warranty_plan_id") REFERENCES "WarrantyPlan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
