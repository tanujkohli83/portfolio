"use client";
import { useEffect, useRef } from "react";

export function MonochromeScene() {
  const ref = useRef<HTMLDivElement>(null);
  useEffect(() => {
    const scene = ref.current;
    if (!scene) return;
    const reduced = window.matchMedia("(prefers-reduced-motion: reduce)");
    const touch = window.matchMedia("(hover: none), (pointer: coarse)");
    let targetScroll = 0;
    let smoothScroll = 0;
    let targetX = 0;
    let targetY = 0;
    let smoothX = 0;
    let smoothY = 0;
    let raf = 0;
    let active = true;
    const setSceneState = () => {
      const hero = scene.closest(".auto-hero, .mono-hero");
      const start = hero ? (hero as HTMLElement).offsetTop : 0;
      const range = Math.max(window.innerHeight * 2.6, 1200);
      targetScroll = Math.min(Math.max((window.scrollY - start) / range, 0), 1);
    };
    const pointer = (event: PointerEvent) => {
      if (touch.matches || reduced.matches) return;
      targetX = ((event.clientX / window.innerWidth) - .5) * 5;
      targetY = ((event.clientY / window.innerHeight) - .5) * -4;
    };
    const tick = () => {
      smoothScroll += (targetScroll - smoothScroll) * .075;
      smoothX += (targetX - smoothX) * .06;
      smoothY += (targetY - smoothY) * .06;
      const project = smoothScroll * 100;
      scene.style.setProperty("--scene-progress", `${smoothScroll}`);
      scene.style.setProperty("--camera-x", `${smoothX}deg`);
      scene.style.setProperty("--camera-y", `${smoothY}deg`);
      scene.style.setProperty("--camera-z", `${smoothScroll * -78}px`);
      scene.style.setProperty("--phone-z", `${80 + smoothScroll * 150}px`);
      scene.style.setProperty("--layer-spread", `${smoothScroll * 70}px`);
      scene.style.setProperty("--timeline-progress", `${project}%`);
      const state = smoothScroll < .22 ? "intro" : smoothScroll < .48 ? "capabilities" : smoothScroll < .74 ? "experience" : "projects";
      scene.dataset.state = state;
      if (active) raf = requestAnimationFrame(tick);
    };
    const onScroll = () => setSceneState();
    const stopForReducedMotion = () => { if (reduced.matches) { targetScroll = 0; targetX = 0; targetY = 0; } };
    window.addEventListener("pointermove", pointer, { passive: true });
    window.addEventListener("scroll", onScroll, { passive: true });
    reduced.addEventListener("change", stopForReducedMotion);
    setSceneState();
    stopForReducedMotion();
    raf = requestAnimationFrame(tick);
    return () => { active = false; cancelAnimationFrame(raf); window.removeEventListener("pointermove", pointer); window.removeEventListener("scroll", onScroll); reduced.removeEventListener("change", stopForReducedMotion); };
  }, []);
  return <div ref={ref} className="mono-scene" data-state="intro" aria-label="Monochrome mobile systems architecture visual"><div className="scene-camera"><div className="scene-floor"/><div className="scene-frame frame-a"/><div className="scene-frame frame-b"/><div className="scene-frame frame-c"/><div className="scene-panel panel-a"><span>API / 001</span><b>09:41</b><i/><i/><i/></div><div className="scene-panel panel-b"><span>DATA FLOW</span><b>CONNECTED</b><em>01—02—03</em></div><div className="scene-panel panel-c"><span>STATE</span><b>STABLE</b></div><div className="scene-phone"><div className="phone-speaker"/><small>BUILD / MOBILE</small><strong>01</strong><div className="phone-rule"/><p>Air<br/><em>Chat</em></p><div className="phone-bars"><i/><i/><i/></div></div><div className="scene-architecture"><i/><i/><i/><span>UI</span><span>API</span><span>DATA</span></div></div><div className="scene-timeline"><i/><i/><i/><i/></div><div className="scene-caption">MOBILE SYSTEMS<br/><span>STRUCTURE / INTERFACE / FLOW</span></div></div>;
}
