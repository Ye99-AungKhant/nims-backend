import jwt from "jsonwebtoken";
import { apiResponse } from "../config/apiResponse.js";

export const authenticateToken = (req, res, next) => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];

  if (!token) {
    return apiResponse(res, 401, "No token provided");
  }

  jwt.verify(
    token,
    process.env.JWT_SECRET || "your_jwt_secret",
    (err, user) => {
      if (err) {
        // If token is expired or invalid, block access
        return apiResponse(res, 401, "Token expired or invalid");
      }
      req.user = user;
      next();
    }
  );
};
