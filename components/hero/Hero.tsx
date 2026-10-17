import { profile } from "@/data/profile";

export function Hero() {
  return <section id="home" className="auto-hero">
    <div className="auto-hero-inner">
      <div className="auto-hero-copy">
        <p className="auto-kicker">Android / Mobile Developer</p>
        <h1><span>Tanuj</span><em>Kohli</em></h1>
        <p className="auto-hero-title">Building Android products with Kotlin, real-time communication, and backend-connected systems.</p>
        <div className="auto-actions">
          <a className="auto-button" href="#projects">Explore projects <span>↗</span></a>
          <a className="auto-text-link" href={profile.resumeUrl} download="Tanuj-Kohli-Resume.pdf">Download resume</a>
          <a className="auto-text-link" href="#contact">Contact me</a>
        </div>
      </div>
      <aside className="auto-hero-note" aria-label="Profile summary">
        <span className="auto-hero-note-number">01</span>
        <p>Mobile systems that stay clear under real-world pressure: communication, data, and dependable interfaces.</p>
        <dl>
          <div><dt>Based in</dt><dd>{profile.location}</dd></div>
          <div><dt>Focus</dt><dd>Kotlin / Flutter / APIs</dd></div>
        </dl>
      </aside>
    </div>
    <div className="auto-scroll-cue">Scroll to explore</div>
  </section>;
}
