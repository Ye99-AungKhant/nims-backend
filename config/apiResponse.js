export const apiResponse = (res, status, message, data = null) => {
  if (res.headersSent) return;
  return res.status(status).json({
    status,
    message,
    data,
  });
};
