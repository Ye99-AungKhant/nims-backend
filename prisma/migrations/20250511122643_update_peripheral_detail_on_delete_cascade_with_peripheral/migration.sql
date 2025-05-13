-- DropForeignKey
ALTER TABLE "PeripheralDetail" DROP CONSTRAINT "PeripheralDetail_peripheral_id_fkey";

-- AddForeignKey
ALTER TABLE "PeripheralDetail" ADD CONSTRAINT "PeripheralDetail_peripheral_id_fkey" FOREIGN KEY ("peripheral_id") REFERENCES "Peripheral"("id") ON DELETE CASCADE ON UPDATE CASCADE;
