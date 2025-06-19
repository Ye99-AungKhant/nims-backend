import multer from "multer";

// Store uploaded files in "public/uploads"
const storage = multer.diskStorage({
  destination: process.env.STORAGE_PATH,
  filename: (req, file, cb) => {
    const uniqueName = Date.now() + "_" + "nims" + "_" + file.originalname;
    cb(null, uniqueName);
  },
});

export const fileUploader = multer({ storage });
