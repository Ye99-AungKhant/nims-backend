import prisma from "../config/prisma.js";

async function main() {
  // Delete existing data (optional)
  //   await prisma.permission.deleteMany();
  //   await prisma.role.deleteMany();

  // Seed roles and assign permissions
  const role = await prisma.role.create({
    data: {
      name: "Super Admin",
      canLogin: true,
      permissions: {
        create: [
          {
            page_name: "installed_objects",
            view: true,
            create: true,
            update: true,
            delete: false,
            repair: true,
            renewal: true,
          },
          {
            page_name: "clients",
            view: true,
            create: true,
            update: true,
            delete: true,
          },
          {
            page_name: "users",
            view: true,
            create: true,
            update: true,
            delete: true,
          },
          {
            page_name: "roles",
            view: true,
            create: true,
            update: true,
            delete: true,
          },
        ],
      },
    },
  });

  await prisma.user.create({
    data: {
      name: "Super Admin",
      role_id: role.id,
      email: "superadmin@gmail.com",
      phone: "09793550943",
      password: "admin#12345",
      username: "superAdmin",
      canLogin: true,
    },
  });

  console.log("Seeding complete.");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
