-- CreateTable
CREATE TABLE "ServerActivity" (
    "id" SERIAL NOT NULL,
    "server_id" INTEGER NOT NULL,
    "type_id" INTEGER,
    "domain_id" INTEGER,
    "subscription_plan_id" INTEGER,
    "installed_date" TIMESTAMP(3) NOT NULL,
    "renewal_date" TIMESTAMP(3),
    "expire_date" TIMESTAMP(3) NOT NULL,
    "invoice_no" TEXT,
    "object_base_fee" INTEGER NOT NULL,
    "status" "StatusGroup" NOT NULL DEFAULT 'Active',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ServerActivity_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ServerActivity" ADD CONSTRAINT "ServerActivity_server_id_fkey" FOREIGN KEY ("server_id") REFERENCES "Server"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServerActivity" ADD CONSTRAINT "ServerActivity_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "Type"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServerActivity" ADD CONSTRAINT "ServerActivity_subscription_plan_id_fkey" FOREIGN KEY ("subscription_plan_id") REFERENCES "WarrantyPlan"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ServerActivity" ADD CONSTRAINT "ServerActivity_domain_id_fkey" FOREIGN KEY ("domain_id") REFERENCES "Brand"("id") ON DELETE SET NULL ON UPDATE CASCADE;
