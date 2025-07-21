import { apiResponse } from "../config/apiResponse.js";
import { loginService } from "../models/authModel.js";
import jwt from "jsonwebtoken";

const generateAccessToken = (user) => {
  return jwt.sign(user, process.env.JWT_SECRET, {
    expiresIn: "1d",
  });
};

const generateRefreshToken = (user) => {
  return jwt.sign(user, process.env.JWT_REFRESH_SECRET, {
    expiresIn: "7d",
  });
};

// Refresh token controller
export const refreshToken = (req, res) => {
  const { refreshToken } = req.body;

  if (!refreshToken) {
    return apiResponse(res, 401, "Refresh token is required");
  }
  try {
    const payload = jwt.verify(
      refreshToken,
      process.env.JWT_REFRESH_SECRET || "your_jwt_refresh_secret"
    );
    const user = {
      id: payload.id,
      username: payload.username,
      role: payload.role,
    };
    const token = generateAccessToken(user);
    // Optionally, issue a new refresh token here
    return apiResponse(res, 200, "Token refreshed", { token });
  } catch (err) {
    return apiResponse(res, 401, "Invalid or expired refresh token");
  }
};
export const login = async (req, res) => {
  const { username, password } = req.body;

  try {
    const user = await loginService(username, password);
    if (!user) {
      return apiResponse(res, 401, "Invalid username or password");
    }
    const { password: pwd, ...userWithoutPassword } = user;
    const payload = { id: user.id, username: user.username, role: user.role };
    const token = generateAccessToken(payload);
    const refreshToken = generateRefreshToken(payload);
    return apiResponse(res, 200, "Login successful", {
      user: userWithoutPassword,
      token,
      refreshToken,
    });
  } catch (error) {
    return apiResponse(res, 401, "Invalid username or password");
  }
};
