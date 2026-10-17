import { Navbar } from "@/components/layout/Navbar";
import { Footer } from "@/components/layout/Footer";
import { Hero } from "@/components/hero/Hero";
import { HeroAboutTransition } from "@/components/transition/HeroAboutTransition";
import { About } from "@/components/about/About";
import { ProjectsShowcase } from "@/components/projects/ProjectsShowcase";
import { Contact } from "@/components/contact/Contact";

export default function Home() {
  return <main><Navbar /><Hero /><HeroAboutTransition /><About /><ProjectsShowcase /><Contact /><Footer /></main>;
}
