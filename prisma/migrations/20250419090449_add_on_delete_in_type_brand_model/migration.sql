-- DropForeignKey
ALTER TABLE "Brand" DROP CONSTRAINT "Brand_type_id_fkey";

-- DropForeignKey
ALTER TABLE "Model" DROP CONSTRAINT "Model_brand_id_fkey";

-- AddForeignKey
ALTER TABLE "Brand" ADD CONSTRAINT "Brand_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "Type"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Model" ADD CONSTRAINT "Model_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "Brand"("id") ON DELETE CASCADE ON UPDATE CASCADE;
