import { Navbar } from "@/components/layout/Navbar";
import { Footer } from "@/components/layout/Footer";
import { Hero } from "@/components/hero/Hero";
import { Skills } from "@/components/skills/Skills";
import { Experience } from "@/components/experience/Experience";
import { ProjectsShowcase } from "@/components/projects/ProjectsShowcase";
import { Contact } from "@/components/contact/Contact";
import { Education } from "@/components/education/Education";

export default function Home() {
  return <main><Navbar /><Hero /><Skills /><Experience /><Education /><ProjectsShowcase /><Contact /><Footer /></main>;
}
