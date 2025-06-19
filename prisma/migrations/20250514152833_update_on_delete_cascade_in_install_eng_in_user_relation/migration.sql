-- DropForeignKey
ALTER TABLE "InstallationEngineer" DROP CONSTRAINT "InstallationEngineer_user_id_fkey";

-- AddForeignKey
ALTER TABLE "InstallationEngineer" ADD CONSTRAINT "InstallationEngineer_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
