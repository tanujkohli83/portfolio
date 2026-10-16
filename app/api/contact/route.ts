import { Resend } from "resend";

const MAX_NAME_LENGTH = 100;
const MAX_EMAIL_LENGTH = 254;
const MAX_MESSAGE_LENGTH = 5000;
const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

type ContactPayload = {
  name?: unknown;
  email?: unknown;
  message?: unknown;
  website?: unknown;
};

function success(message: string, status = 200) {
  return Response.json({ success: true, message }, { status });
}

function failure(message: string, status: number, headers?: HeadersInit) {
  return Response.json({ success: false, message }, { status, headers });
}

function diagnostic(code: string, message: string, details?: Record<string, string>) {
  if (process.env.NODE_ENV !== "production") {
    console.warn(`[contact] ${code}: ${message}`, details ?? "");
  }
}

function errorProperty(error: unknown, property: string) {
  if (!error || typeof error !== "object" || !(property in error)) {
    return undefined;
  }

  const value = (error as Record<string, unknown>)[property];
  return typeof value === "string" || typeof value === "number" ? String(value) : undefined;
}

function sanitizedErrorMessage(message: string) {
  return message
    .replace(/re_[A-Za-z0-9_-]+/g, "[redacted-key]")
    .replace(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}/gi, "[redacted-email]")
    .slice(0, 240);
}

function escapeHtml(value: string) {
  return value.replace(/[&<>'"]/g, character => {
    const entities: Record<string, string> = {
      "&": "&amp;",
      "<": "&lt;",
      ">": "&gt;",
      "'": "&#39;",
      '"': "&quot;",
    };

    return entities[character];
  });
}

export async function POST(request: Request) {
  const contentType = request.headers.get("content-type") ?? "";

  if (!contentType.toLowerCase().includes("application/json")) {
    diagnostic("invalid_content_type", "Expected application/json.", {
      received: contentType || "missing",
    });
    return failure("Please send the form as JSON.", 415);
  }

  let payload: ContactPayload;

  try {
    const body: unknown = await request.json();

    if (!body || typeof body !== "object" || Array.isArray(body)) {
      diagnostic("invalid_body", "The JSON body must be an object.");
      return failure("Invalid request body.", 400);
    }

    payload = body as ContactPayload;
  } catch {
    diagnostic("invalid_json", "The request body could not be parsed as JSON.");
    return failure("Invalid JSON request.", 400);
  }

  const name = typeof payload.name === "string" ? payload.name.trim() : "";
  const email = typeof payload.email === "string" ? payload.email.trim() : "";
  const message = typeof payload.message === "string" ? payload.message.trim() : "";
  const website = typeof payload.website === "string" ? payload.website.trim() : "";

  if (website) {
    // Silently accept likely bot submissions without sending an email.
    diagnostic("honeypot", "The hidden anti-abuse field was populated.");
    return failure("We could not send your message. Please try again later.", 400);
  }

  if (!name || name.length > MAX_NAME_LENGTH) {
    diagnostic("invalid_name", "Name is missing or exceeds the length limit.");
    return failure("Please enter a valid name.", 400);
  }

  if (!email || email.length > MAX_EMAIL_LENGTH || !emailPattern.test(email)) {
    diagnostic("invalid_email", "Email is missing or invalid.");
    return failure("Please enter a valid email address.", 400);
  }

  if (!message || message.length > MAX_MESSAGE_LENGTH) {
    diagnostic("invalid_message", "Message is missing or exceeds the length limit.");
    return failure("Please enter a message under 5,000 characters.", 400);
  }

  const apiKey = process.env.RESEND_API_KEY;
  const contactEmail = process.env.CONTACT_EMAIL;
  const fromEmail = process.env.RESEND_FROM_EMAIL;

  if (!apiKey || !contactEmail || !fromEmail) {
    const missing = [
      !apiKey ? "RESEND_API_KEY" : "",
      !contactEmail ? "CONTACT_EMAIL" : "",
      !fromEmail ? "RESEND_FROM_EMAIL" : "",
    ].filter(Boolean).join(", ");
    diagnostic("missing_env", "Required contact environment variables are not configured.", { missing });
    return failure("Contact service is not configured yet.", 503);
  }

  const subjectName = name.replace(/[\r\n]+/g, " ");
  const safeName = escapeHtml(name);
  const safeEmail = escapeHtml(email);
  const safeMessage = escapeHtml(message).replace(/\n/g, "<br />");
  const resend = new Resend(apiKey);

  try {
    const { error } = await resend.emails.send({
      from: fromEmail,
      to: [contactEmail],
      replyTo: email,
      subject: `Portfolio contact: ${subjectName}`,
      text: `New portfolio contact message\n\nName: ${name}\nEmail: ${email}\n\nMessage:\n${message}`,
      html: `<h2>New portfolio contact message</h2><p><strong>Name:</strong> ${safeName}</p><p><strong>Email:</strong> ${safeEmail}</p><p><strong>Message:</strong><br />${safeMessage}</p>`,
    });

    if (error) {
      const code = errorProperty(error, "code") ?? errorProperty(error, "name") ?? errorProperty(error, "statusCode") ?? "unknown";
      const name = errorProperty(error, "name") ?? "ResendError";
      const status = errorProperty(error, "statusCode") ?? "unknown";
      const message = sanitizedErrorMessage(errorProperty(error, "message") ?? "Resend rejected the email request.");
      diagnostic("resend_rejected", message, { name, code, status });
      return failure("We could not send your message right now. Please try again later.", 502);
    }

    return success("Your message has been sent successfully.");
  } catch (error) {
    const message = sanitizedErrorMessage(error instanceof Error ? error.message : "Unexpected email delivery failure.");
    diagnostic("resend_exception", message, { name: error instanceof Error ? error.name : "UnknownError", code: "unexpected_error", status: "unknown" });
    return failure("We could not send your message right now. Please try again later.", 502);
  }
}

function methodNotAllowed() {
  return failure("Method not allowed.", 405, { Allow: "POST" });
}

export function GET() {
  return methodNotAllowed();
}

export function PUT() {
  return methodNotAllowed();
}

export function PATCH() {
  return methodNotAllowed();
}

export function DELETE() {
  return methodNotAllowed();
}
