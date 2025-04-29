/*
  Warnings:

  - You are about to drop the column `domain` on the `Server` table. All the data in the column will be lost.
  - Added the required column `domain_id` to the `Server` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Server" DROP COLUMN "domain",
ADD COLUMN     "domain_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Server" ADD CONSTRAINT "Server_domain_id_fkey" FOREIGN KEY ("domain_id") REFERENCES "Brand"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
