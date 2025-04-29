/*
  Warnings:

  - You are about to drop the column `brand_id` on the `Peripheral` table. All the data in the column will be lost.
  - You are about to drop the column `model_id` on the `Peripheral` table. All the data in the column will be lost.
  - You are about to drop the column `serial_no` on the `Peripheral` table. All the data in the column will be lost.
  - You are about to drop the column `warranty_expiry_date` on the `Peripheral` table. All the data in the column will be lost.
  - You are about to drop the column `warranty_plan_id` on the `Peripheral` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Peripheral" DROP CONSTRAINT "Peripheral_warranty_plan_id_fkey";

-- AlterTable
ALTER TABLE "Peripheral" DROP COLUMN "brand_id",
DROP COLUMN "model_id",
DROP COLUMN "serial_no",
DROP COLUMN "warranty_expiry_date",
DROP COLUMN "warranty_plan_id";

-- CreateTable
CREATE TABLE "PeripheralDetail" (
    "id" SERIAL NOT NULL,
    "peripheral_id" INTEGER NOT NULL,
    "brand_id" INTEGER NOT NULL,
    "model_id" INTEGER NOT NULL,
    "warranty_plan_id" INTEGER NOT NULL,
    "serial_no" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PeripheralDetail_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "PeripheralDetail" ADD CONSTRAINT "PeripheralDetail_peripheral_id_fkey" FOREIGN KEY ("peripheral_id") REFERENCES "Peripheral"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PeripheralDetail" ADD CONSTRAINT "PeripheralDetail_warranty_plan_id_fkey" FOREIGN KEY ("warranty_plan_id") REFERENCES "WarrantyPlan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PeripheralDetail" ADD CONSTRAINT "PeripheralDetail_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "Brand"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PeripheralDetail" ADD CONSTRAINT "PeripheralDetail_model_id_fkey" FOREIGN KEY ("model_id") REFERENCES "Model"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
