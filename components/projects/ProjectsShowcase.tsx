"use client";

import { useLayoutEffect, useRef } from "react";
import type { CSSProperties } from "react";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { profile } from "@/data/profile";
import { projects } from "@/data/projects";

const summaries = [
  "Trainer-member communication across chat, appointments, video calls, session logging, and feedback workflows.",
  "Real-time chat with authentication and Firestore-based messaging.",
  "BLE monitoring for soil temperature and moisture with offline caching and charts.",
  "Doctor appointment booking and scheduling through an ASP.NET Core REST API.",
] as const;

function ProjectVisual({ index }: { index: number }) {
  if (index === 2) return <div className="auto-project-object"><div className="auto-soil-graph"><span>SOIL / SENSOR READINGS</span><div className="auto-soil-bars"><i/><i/><i/><i/><i/></div></div></div>;
  if (index === 3) return <div className="auto-project-object"><div className="auto-clinic-board"><span>APPOINTMENT / SCHEDULING</span><div className="auto-clinic-row"><i/><b>09:00</b><span>01</span></div><div className="auto-clinic-row"><i/><b>10:30</b><span>02</span></div><div className="auto-clinic-row"><i/><b>12:00</b><span>03</span></div></div></div>;
  return <div className="auto-project-object"><div className="auto-phone"><div className="auto-phone-top"><span>{index === 0 ? "FITBRIDGE" : "AIR CHAT"}</span><span>09:41</span></div><strong>01</strong><div className="auto-phone-rule"/><p>{index === 0 ? <>Fit<br/><em>Bridge</em></> : <>Air<br/><em>Chat</em></>}</p><div className="auto-phone-lines"><i/><i/><i/></div></div>{index === 0 && <div className="auto-bridge-link"/>}</div>;
}

function setCardAccessibility(cards: HTMLElement[], activeIndex: number) {
  cards.forEach((card, index) => {
    const isActive = index === activeIndex;
    card.setAttribute("aria-hidden", String(!isActive));
    card.querySelectorAll<HTMLElement>("a, button").forEach(control => {
      control.tabIndex = isActive ? 0 : -1;
    });
  });
}

export function ProjectsShowcase() {
  const storyRef = useRef<HTMLDivElement>(null);

  useLayoutEffect(() => {
    const story = storyRef.current;
    if (!story || window.matchMedia("(prefers-reduced-motion: reduce)").matches || window.matchMedia("(max-width: 760px)").matches) return;

    gsap.registerPlugin(ScrollTrigger);
    const cards = gsap.utils.toArray<HTMLElement>(".dezerv-story-card", story);
    if (!cards.length) return;

    story.classList.add("is-enhanced");
    setCardAccessibility(cards, 0);

    const context = gsap.context(() => {
      gsap.set(cards, { autoAlpha: 0, yPercent: 8, scale: .965, zIndex: 0 });
      gsap.set(cards[0], { autoAlpha: 1, yPercent: 0, scale: 1, zIndex: 2 });

      const timeline = gsap.timeline({
        defaults: { ease: "none" },
        scrollTrigger: {
          trigger: story,
          pin: true,
          scrub: .8,
          start: "top top+=88px",
          end: () => `+=${Math.max(window.innerHeight * 3.1, cards.length * 560)}`,
          invalidateOnRefresh: true,
          anticipatePin: 1,
          onUpdate: trigger => setCardAccessibility(cards, Math.min(cards.length - 1, Math.round(trigger.progress * (cards.length - 1)))),
        },
      });

      cards.slice(1).forEach((card, index) => {
        const previous = cards[index];
        timeline.to(previous, { scale: .93, yPercent: 0, autoAlpha: .34, duration: 1 }, index)
          .fromTo(card, { autoAlpha: 0, yPercent: 5, scale: .97, zIndex: index + 2 }, { autoAlpha: 1, yPercent: 0, scale: 1, duration: 1 }, index + .12);
      });
    }, story);

    return () => {
      story.classList.remove("is-enhanced");
      setCardAccessibility(cards, 0);
      context.revert();
    };
  }, []);

  return <section id="projects" className="auto-section auto-projects dezerv-projects dezerv-project-story"><div className="auto-projects-heading"><div className="auto-section-heading"><span className="auto-section-number">01 / 04</span><h2>Selected<br/><em>projects</em></h2></div><p className="auto-section-intro">Four verified builds, presented as product studies with the problem, system, and interface in view.</p></div><div ref={storyRef} className="dezerv-story" aria-label="Featured projects">{projects.map((project,index)=><article className="dezerv-story-card" style={{"--story-index": index} as CSSProperties} key={project.title}><div className="auto-project-visual"><span className="auto-project-visual-label">{project.category}</span><span className="auto-project-visual-index">{project.label}</span><ProjectVisual index={index}/></div><div className="auto-project-info"><div><div className="auto-project-info-top"><span>Product study / {String(index+1).padStart(2,"0")}</span><span>{project.category}</span></div><h3>{project.title}</h3><p>{summaries[index]}</p><p className="dezerv-project-contribution">{project.description}</p></div><div className="auto-project-bottom"><div className="auto-project-tags">{project.technologies.slice(0,4).map(tag=><span key={tag}>{tag}</span>)}</div><a className="auto-project-link" href={project.githubUrl || project.liveUrl} target="_blank" rel="noreferrer">View on GitHub <span>↗</span></a></div></div></article>)}</div><a className="auto-text-link" href={profile.githubUrl} target="_blank" rel="noreferrer">View GitHub archive <span>↗</span></a></section>;
}
