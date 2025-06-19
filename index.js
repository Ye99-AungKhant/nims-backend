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
import { authRouter } from "./routers/auth.js";
import { installObjectRouter } from "./routers/installObject.js";
import { permissionRouter } from "./routers/permission.js";
import { dashboardRouter } from "./routers/dashboard.js";
import { installImageRouter } from "./routers/installImage.js";
import { repairReplacementRouter } from "./routers/repairReplacement.js";

const app = express();
const apiRouter = express.Router();

app.use(cors());
app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);
app.use("/uploads", express.static("public/uploads"));

app.get("/", (req, res) => {
  res.send("Hello, World!");
});
apiRouter.use("/dashboard", dashboardRouter);
apiRouter.use("/login", authRouter);
apiRouter.use("/installObject", installObjectRouter);
apiRouter.use("/user", userRouter);
apiRouter.use("/client", clientRouter);
apiRouter.use("/role", roleRouter);
apiRouter.use("/contact-person", contactPersonRouter);
apiRouter.use("/type", typeRouter);
apiRouter.use("/brand", brandRouter);
apiRouter.use("/model", modelRouter);
apiRouter.use("/vehicle", vehicleRouter);
apiRouter.use("/plan", warrantyPlanRouter);
apiRouter.use("/device", gpsDeviceRouter);
apiRouter.use("/sim-card", simCardRouter);
apiRouter.use("/peripheral", peripheralRouter);
apiRouter.use("/accessory", accessoryRouter);
apiRouter.use("/server", installServerRouter);
apiRouter.use("/permission", permissionRouter);
apiRouter.use("/installImage", installImageRouter);
apiRouter.use("/repair-replacement", repairReplacementRouter);

app.use("/api", apiRouter);

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
