import express from "express";
import cors from "cors";
import bodyParser from "body-parser";
import prisma from "./config/prisma.js";
import { clientRouter } from "./routers/client.js";
import { roleRouter } from "./routers/role.js";
import { contactPersonRouter } from "./routers/contactPerson.js";
import { typeRouter } from "./routers/type.js";
import { brandRouter } from "./routers/brand.js";
import { modelRouter } from "./routers/model.js";
import { vehicleRouter } from "./routers/vehicle.js";
import { warrantyPlanRouter } from "./routers/warrantyPlan.js";
import { gpsDeviceRouter } from "./routers/gpsDevice.js";
import { simCardRouter } from "./routers/simCard.js";
import { peripheralRouter } from "./routers/peripheral.js";
import { accessoryRouter } from "./routers/accessory.js";
import { installServerRouter } from "./routers/installServer.js";
import { userRouter } from "./routers/user.js";
import { creatFormRouter } from "./routers/createForm.js";
import { authRouter } from "./routers/auth.js";

const app = express();

app.use(cors());
app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

app.get("/", (req, res) => {
  res.send("Hello, World!");
});
app.use("/login", authRouter);
app.use("/createForm", creatFormRouter);
app.use("/user", userRouter);
app.use("/client", clientRouter);
app.use("/role", roleRouter);
app.use("/contact-person", contactPersonRouter);
app.use("/type", typeRouter);
app.use("/brand", brandRouter);
app.use("/model", modelRouter);
app.use("/vehicle", vehicleRouter);
app.use("/plan", warrantyPlanRouter);
app.use("/device", gpsDeviceRouter);
app.use("/sim-card", simCardRouter);
app.use("/peripheral", peripheralRouter);
app.use("/accessory", accessoryRouter);
app.use("/server", installServerRouter);

const PORT = process.env.PORT || 3001;
const server = app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

const gracefulShutdown = async () => {
  await prisma.$disconnect();
  server.close(() => {
    process.exit(0);
  });
};

process.on("SIGTERM", gracefulShutdown);
process.on("SIGINT", gracefulShutdown);
