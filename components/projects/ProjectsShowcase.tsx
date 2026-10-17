"use client";

import { useLayoutEffect, useRef } from "react";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { profile } from "@/data/profile";
import { projects } from "@/data/projects";

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
      gsap.set(cards, { autoAlpha: 0, scale: .965, zIndex: 0 });
      gsap.set(cards[0], { autoAlpha: 1, scale: 1, zIndex: 2 });

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
        timeline.to(previous, { scale: .93, autoAlpha: .34, duration: 1 }, index)
          .fromTo(card, { autoAlpha: 0, scale: .97, zIndex: index + 2 }, { autoAlpha: 1, scale: 1, duration: 1 }, index + .12);
      });
    }, story);

    return () => {
      story.classList.remove("is-enhanced");
      setCardAccessibility(cards, 0);
      context.revert();
    };
  }, []);

  return <section id="projects" className="auto-section auto-projects dezerv-projects dezerv-project-story">
    <div className="auto-projects-heading">
      <div className="auto-section-heading">
        <span className="auto-section-number"></span>
        <h2>Selected<br/><em>projects</em></h2>
      </div>

    </div>

    <div ref={storyRef} className="dezerv-story" aria-label="Featured projects">
      {projects.map((project, index) => <article className="dezerv-story-card" key={project.title}>
        <div className="dezerv-project-panel">
          <div className="dezerv-project-top">
            <span className="dezerv-project-number">{String(index + 1).padStart(2, "0")}</span>
            <span>{project.category}</span>
          </div>
          <div className="dezerv-project-middle">
            <h3>{project.title}</h3>
            <p className="dezerv-project-description">{project.description}</p>
          </div>
          <div className="dezerv-project-footer">
            <div className="auto-project-tags">{project.technologies.slice(0, 5).map(tag => <span key={tag}>{tag}</span>)}</div>
            <a className="auto-project-link" href={project.githubUrl || project.liveUrl} target="_blank" rel="noreferrer">View on GitHub <span>↗</span></a>
          </div>
        </div>
      </article>)}
    </div>

    <a className="auto-text-link" href={profile.githubUrl} target="_blank" rel="noreferrer">View GitHub archive <span>↗</span></a>
  </section>;
}
