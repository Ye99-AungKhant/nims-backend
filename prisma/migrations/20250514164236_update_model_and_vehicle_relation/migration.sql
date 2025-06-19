-- AddForeignKey
ALTER TABLE "Vehicle" ADD CONSTRAINT "Vehicle_model_id_fkey" FOREIGN KEY ("model_id") REFERENCES "Model"("id") ON DELETE SET NULL ON UPDATE CASCADE;
