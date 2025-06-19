-- DropForeignKey
ALTER TABLE "Vehicle" DROP CONSTRAINT "Vehicle_brand_id_fkey";

-- DropForeignKey
ALTER TABLE "Vehicle" DROP CONSTRAINT "Vehicle_type_id_fkey";

-- AlterTable
ALTER TABLE "Vehicle" ALTER COLUMN "type_id" DROP NOT NULL,
ALTER COLUMN "brand_id" DROP NOT NULL,
ALTER COLUMN "model_id" DROP NOT NULL,
ALTER COLUMN "year" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Vehicle" ADD CONSTRAINT "Vehicle_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "Type"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vehicle" ADD CONSTRAINT "Vehicle_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "Brand"("id") ON DELETE SET NULL ON UPDATE CASCADE;
