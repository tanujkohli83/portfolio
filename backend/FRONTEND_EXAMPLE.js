// Example: How to connect your frontend form to the API

// Alternative 1: Vanilla JavaScript
function submitForm(event) {
  event.preventDefault(); // Don't reload page

  const name = document.getElementById("name").value;
  const email = document.getElementById("email").value;
  const message = document.getElementById("message").value;

  // Send to backend API
  fetch("http://localhost:5000/api/contact", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      name: name,
      email: email,
      message: message,
    }),
  })
    .then((response) => response.json())
    .then((data) => {
      if (data.success) {
        alert("✓ Message sent! Check your email soon.");
        document.getElementById("contactForm").reset(); // Clear the form
      } else {
        alert("✗ Error: " + data.message);
      }
    })
    .catch((error) => {
      console.error("Error:", error);
      alert("✗ Failed to send message");
    });
}

// Alternative 2: React Component
import React, { useState } from "react";

export default function ContactForm() {
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    message: "",
  });
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState("");

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      const response = await fetch("http://localhost:5000/api/contact", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(formData),
      });

      const result = await response.json();

      if (result.success) {
        setMessage("✓ Message sent successfully!");
        setFormData({ name: "", email: "", message: "" }); // Reset
      } else {
        setMessage("✗ " + result.message);
      }
    } catch (error) {
      setMessage("✗ Failed to send message");
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        name="name"
        placeholder="Your name"
        value={formData.name}
        onChange={handleChange}
        required
      />
      <input
        type="email"
        name="email"
        placeholder="Your email"
        value={formData.email}
        onChange={handleChange}
        required
      />
      <textarea
        name="message"
        placeholder="Your message"
        value={formData.message}
        onChange={handleChange}
        required
      />
      <button type="submit" disabled={loading}>
        {loading ? "Sending..." : "Send Message"}
      </button>
      {message && <p>{message}</p>}
    </form>
  );
}

// HTML Example (paste in your .html file)
/*
<form id="contactForm" onsubmit="submitForm(event)">
  <input type="text" id="name" placeholder="Your Name" required>
  <input type="email" id="email" placeholder="Your Email" required>
  <textarea id="message" placeholder="Your Message" required></textarea>
  <button type="submit">Send Message</button>
</form>

<script src="path/to/this/file.js"></script>
*/
