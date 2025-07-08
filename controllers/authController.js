import { apiResponse } from "../config/apiResponse.js";
import { loginService } from "../models/authModel.js";
import jwt from "jsonwebtoken";

export const login = async (req, res) => {
  const { username, password } = req.body;

  try {
    const user = await loginService(username, password);

    if (!user) {
      return apiResponse(res, 401, "Invalid username or password");
    }

    // Remove password from user object before sending
    const { password: pwd, ...userWithoutPassword } = user;

    // Generate JWT token
    const token = jwt.sign(
      { id: user.id, username: user.username, role: user.role },
      process.env.JWT_SECRET || "your_jwt_secret",
      { expiresIn: "1d" }
    );

    apiResponse(res, 200, "Login successful", { user: userWithoutPassword, token });
  } catch (error) {
    console.error(error);
    apiResponse(res, 500, "Internal server error");
  }
};
