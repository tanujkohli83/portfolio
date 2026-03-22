const express = require("express");
const cors = require("cors");
require("dotenv").config();
const nodemailer = require("nodemailer");

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Create a transporter for sending emails
const transporter = nodemailer.createTransport({
  service: "gmail", // Using Gmail (easy setup)
  auth: {
    user: process.env.EMAIL_USER, // Your Gmail address
    pass: process.env.EMAIL_PASSWORD, // Your Gmail app password
  },
});

// API Route to handle contact form submission
app.post("/api/contact", async (req, res) => {
  try {
    const { name, email, message } = req.body;

    // Validate input
    if (!name || !email || !message) {
      return res.status(400).json({
        success: false,
        message: "Please fill in all fields (name, email, message)",
      });
    }

    // Email options - what to send to your personal email
    const mailOptions = {
      from: process.env.EMAIL_USER, // Your email
      to: process.env.RECEIVE_EMAIL, // Your personal email (where you get notifications)
      subject: `New Contact Form: ${name}`,
      html: `
        <h2>New Contact Form Submission</h2>
        <p><strong>Name:</strong> ${name}</p>
        <p><strong>Email:</strong> ${email}</p>
        <p><strong>Message:</strong></p>
        <p>${message.replace(/\n/g, "<br>")}</p>
      `,
    };

    // Send the email
    await transporter.sendMail(mailOptions);

    // Send success response to frontend
    res.json({
      success: true,
      message: "Form submitted successfully! We will contact you soon.",
    });
  } catch (error) {
    console.error("Error sending email:", error);
    res.status(500).json({
      success: false,
      message: "Error submitting form. Please try again.",
    });
  }
});

// Test route to check if server is running
app.get("/api/test", (req, res) => {
  res.json({ message: "Server is running!" });
});

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
  console.log("Ready to receive contact form submissions!");
});
