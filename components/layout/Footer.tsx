import { profile } from "@/data/profile";

export function Footer(){return <footer className="auto-footer"><div><b>{profile.name}</b><span>{profile.role}</span><small>© 2026 {profile.name}</small></div><p>Designed as a product-engineering portfolio.</p><div className="auto-footer-links"><a href={profile.githubUrl} target="_blank" rel="noreferrer">GitHub</a><a href={profile.linkedinUrl} target="_blank" rel="noreferrer">LinkedIn</a><a href={`mailto:${profile.email}`}>Email</a><a href={profile.resumeUrl} download="Tanuj-Kohli-Resume.pdf">Resume</a></div></footer>}
