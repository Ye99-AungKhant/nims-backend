-- CreateTable
CREATE TABLE "ExtraServer" (
    "id" SERIAL NOT NULL,
    "server_id" INTEGER NOT NULL,
    "type_id" INTEGER NOT NULL,
    "domain_id" INTEGER NOT NULL,
    "status" "StatusGroup" NOT NULL DEFAULT 'Active',

    CONSTRAINT "ExtraServer_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ExtraServer" ADD CONSTRAINT "ExtraServer_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "Type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExtraServer" ADD CONSTRAINT "ExtraServer_domain_id_fkey" FOREIGN KEY ("domain_id") REFERENCES "Brand"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExtraServer" ADD CONSTRAINT "ExtraServer_server_id_fkey" FOREIGN KEY ("server_id") REFERENCES "Server"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
