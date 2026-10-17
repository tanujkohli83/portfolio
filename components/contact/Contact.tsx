"use client";

import { useState } from "react";
import type { FormEvent } from "react";
import { profile } from "@/data/profile";

type SubmissionStatus = "idle" | "submitting" | "success" | "error";
type ContactResponse = { success?: unknown; message?: unknown };

export function Contact() {
  const [status, setStatus] = useState<SubmissionStatus>("idle");
  const [feedback, setFeedback] = useState("");
  const handleSubmit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (status === "submitting") return;
    const form = event.currentTarget;
    const formData = new FormData(form);
    setStatus("submitting");
    setFeedback("Sending…");
    try {
      const response = await fetch("/api/contact", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify({ name: formData.get("name"), email: formData.get("email"), message: formData.get("message"), website: formData.get("website") }) });
      const result: ContactResponse = await response.json().catch(() => ({}));
      const serverMessage = typeof result.message === "string" ? result.message : "Unable to send your message.";
      if (!response.ok || result.success !== true) throw new Error(serverMessage);
      form.reset();
      setStatus("success");
      setFeedback(serverMessage);
    } catch (error) {
      setStatus("error");
      setFeedback(error instanceof Error ? error.message : "Something went wrong. Please try again.");
    }
  };
  const isSubmitting = status === "submitting";
  return <section id="contact" className="auto-contact"><div className="auto-contact-inner"><div className="auto-contact-copy"><p className="auto-section-kicker"></p><h2>Let&apos;s build<br /><em>something useful</em></h2><div className="auto-contact-details"></div><div className="auto-contact-social"><a href={profile.githubUrl} target="_blank" rel="noreferrer">GitHub ↗</a><a href={profile.linkedinUrl} target="_blank" rel="noreferrer">LinkedIn ↗</a></div></div><form className="auto-form" method="post" action="/api/contact" onSubmit={handleSubmit} aria-busy={isSubmitting}><label htmlFor="name">Name</label><input id="name" name="name" required placeholder="Your name" /><label htmlFor="email">Email</label><input id="email" name="email" type="email" required placeholder="you@example.com" /><label htmlFor="message">Message</label><textarea id="message" name="message" required placeholder="Tell me about the system or idea..." /><div className="auto-honeypot" aria-hidden="true"><label htmlFor="website">Website</label><input id="website" name="website" tabIndex={-1} autoComplete="off" /></div><button type="submit" disabled={isSubmitting}>{isSubmitting ? "Sending…" : status === "success" ? "Sent" : "Send message"} &nbsp;↗</button>{feedback && <small className={`auto-form-status auto-form-status-${status}`} role={status === "error" ? "alert" : "status"} aria-live="polite">{feedback}</small>}</form></div></section>;
}
