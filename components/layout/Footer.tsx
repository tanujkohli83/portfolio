import { profile } from "@/data/profile";

export function Footer() {
  return <footer className="auto-footer">
    <nav className="auto-footer-links" aria-label="Footer links">
      <a href={profile.githubUrl} target="_blank" rel="noreferrer">GitHub</a>
      <a href={profile.linkedinUrl} target="_blank" rel="noreferrer">LinkedIn</a>
      <a href={`mailto:${profile.email}`}>Email</a>
      <a href={profile.resumeUrl} download="Tanuj-Kohli-Resume.pdf">Resume</a>
    </nav>
  </footer>;
}
