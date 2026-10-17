"use client";

import { useLayoutEffect, useRef } from "react";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

export function HeroAboutTransition() {
  const transitionRef = useRef<HTMLDivElement>(null);
  const curveRef = useRef<HTMLDivElement>(null);

  useLayoutEffect(() => {
    const transition = transitionRef.current;
    const curve = curveRef.current;
    if (!transition || !curve || window.matchMedia("(prefers-reduced-motion: reduce)").matches || window.matchMedia("(max-width: 760px)").matches) return;

    gsap.registerPlugin(ScrollTrigger);
    const context = gsap.context(() => {
      transition.classList.add("is-active");
      gsap.set(curve, { y: 0 });
      gsap.to(curve, {
        y: "215vh",
        ease: "none",
        scrollTrigger: {
          trigger: transition,
          start: "top bottom",
          end: "top top+=92px",
          scrub: 1,
          invalidateOnRefresh: true,
        },
      });
    }, transition);

    return () => {
      transition.classList.remove("is-active");
      context.revert();
    };
  }, []);

  return <div ref={transitionRef} className="auto-about-transition" aria-hidden="true">
    <div className="auto-about-transition-surface">
      <div ref={curveRef} className="auto-about-transition-curve" />
    </div>
  </div>;
}
