// import prisma from "../config/prisma.js";

export const getContactPersonService = async (prisma, { id }) => {
  const contact = await prisma.contactPerson.findFirst({
    where: { id },
    include: { role: true },
  });
  return contact;
};

export const createContactPersonService = async (
  prisma,
  { client_id, name, role_id, phone, email }
) => {
  const contact = await prisma.contactPerson.create({
    data: {
      client_id,
      name,
      role_id,
      phone,
      email,
    },
  });
  const contacts = await getContactPersonService(prisma, { id: contact.id });
  return contacts;
};

export const updateContactPersonService = async (
  prisma,
  { client_id, id, name, role_id, phone, email }
) => {
  if (id) {
    const contact = await prisma.contactPerson.update({
      where: { id },
      data: {
        name,
        role_id,
        phone,
        email,
      },
    });
    return contact;
  }
  const contact = await prisma.contactPerson.create({
    data: {
      client_id,
      name,
      role_id,
      phone,
      email,
    },
  });
  return contact;
};

export const deleteContactPersonService = async (prisma, { id }) => {
  await prisma.contactPerson.delete({
    where: { id },
  });
  return;
};

export const deleteContactPersonOfClientService = async (prisma, { id }) => {
  await prisma.contactPerson.deleteMany({
    where: { client_id: id },
  });
  return;
};
