import { createLogger, format, transports } from "winston";

const logger = createLogger({
  level: "error",
  format: format.combine(
    format.timestamp({ format: "YYYY-MM-DD HH:mm:ss" }),
    format.errors({ stack: true }),
    format.printf(({ timestamp, level, message, stack }) => {
      return `[${timestamp}] ${level.toUpperCase()}: ${stack || message}`;
    })
  ),
  transports: [new transports.File({ filename: "error.log" })],
});

export default logger;
