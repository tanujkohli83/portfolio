"use client";

import { useEffect, useState } from "react";
import { profile } from "@/data/profile";

const items = [
  ["00", "Home", "#home"],
  ["01", "About", "#about"],
  ["02", "Projects", "#projects"],
  ["03", "Contact", "#contact"],
] as const;

export function Navbar() {
  const [active, setActive] = useState("home");
  const [open, setOpen] = useState(false);

  useEffect(() => {
    const observer = new IntersectionObserver(entries => {
      const visible = entries
        .filter(entry => entry.isIntersecting)
        .sort((a, b) => b.intersectionRatio - a.intersectionRatio)[0];
      if (visible) setActive(visible.target.id);
    }, { rootMargin: "-35% 0px -55%" });

    items.forEach(([, , href]) => {
      const element = document.querySelector(href);
      if (element) observer.observe(element);
    });

    return () => observer.disconnect();
  }, []);

  return <header className="auto-nav">
    <nav className={open ? "auto-nav-open" : undefined} aria-label="Primary navigation">
      {items.map(([number, label, href]) => <a key={href} href={href} className={active === href.slice(1) ? "active" : undefined} aria-current={active === href.slice(1) ? "page" : undefined} onClick={() => setOpen(false)}><i>{number}</i>{label}</a>)}
    </nav>
    <a className="auto-nav-resume" href={profile.resumeUrl} download="Tanuj-Kohli-Resume.pdf">Resume <span>↗</span></a>
    <button className="auto-nav-toggle" type="button" aria-label="Toggle navigation" aria-expanded={open} onClick={() => setOpen(value => !value)}>{open ? "CLOSE" : "MENU"}</button>
  </header>;
}
