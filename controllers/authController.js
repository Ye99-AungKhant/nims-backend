import { apiResponse } from "../config/apiResponse.js";
import { loginService } from "../models/authModel.js";

export const login = async (req, res) => {
  const { username, password } = req.body;

  try {
    const user = await loginService(username, password);

    if (!user) {
      apiResponse(res, 401, "Invalid username or password");
    }

    apiResponse(res, 200, "Login successful", user);
  } catch (error) {
    console.error(error);
    apiResponse(res, 500, "Internal server error");
  }
};
