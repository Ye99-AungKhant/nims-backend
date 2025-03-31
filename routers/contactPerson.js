import express from "express";
import {
  createContactPerson,
  deleteContactPerson,
  updateContactPerson,
} from "../controllers/contactPersonController.js";

const router = express.Router();

router.post("/", createContactPerson);
router.patch("/", updateContactPerson);
router.delete("/:id", deleteContactPerson);

export { router as contactPersonRouter };
