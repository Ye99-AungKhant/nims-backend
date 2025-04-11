import { apiResponse } from "../config/apiResponse.js";
import { loginService } from "../models/authModel.js";

export const login = async (req, res) => {
  const { username, password } = req.body;

  try {
    const user = await loginService(username, password);

    if (!user) {
      return apiResponse(res, 401, "Invalid username or password");
    }

    return apiResponse(res, 200, "Login successful", user);
  } catch (error) {
    console.error(error);
    return apiResponse(res, 500, "Internal server error");
  }
};
