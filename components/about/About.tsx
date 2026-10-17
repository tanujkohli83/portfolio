import { education } from "@/data/education";
import { experience } from "@/data/experience";
import { profile } from "@/data/profile";

export function About() {
  const currentRole = experience[0];

  return <section id="about" className="auto-about">
    <div className="auto-about-heading">
      <span className="auto-section-number"></span>
      <h2>A little<br/><em>about me</em></h2>
    </div>
    <div className="auto-about-grid">
      <div className="auto-about-copy">
        <p className="auto-about-lead">{profile.name} is a mobile developer based in {profile.location}. He works mainly with Kotlin and Flutter, building applications that connect people to real-time services, APIs, and dependable local data.</p>
        <p>His recent work includes a Kotlin stock-market application with live WebSocket updates and cross-platform products built with Kotlin Multiplatform. Earlier projects cover trainer–member communication, chat, Bluetooth sensor monitoring, and appointment scheduling.</p>
        <p>He is interested in mobile products where the interface, application state, and backend have to work together clearly.</p>
      </div>
      <div className="auto-about-facts" aria-label="Professional details">
        <div><span>Now</span><strong>{currentRole.role}</strong><small>{currentRole.company}</small></div>
        <div><span>Studying</span><strong>{education.degree}</strong><small>{education.institution} · {education.status}</small></div>
        <div><span>Works with</span><strong>Kotlin · Flutter</strong><small>Firebase · REST APIs · WebSockets</small></div>
      </div>
    </div>
  </section>;
}
