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

export function ProjectsShowcase(){return <section id="projects" className="auto-section auto-projects"><div className="auto-projects-heading"><div className="auto-section-heading"><span className="auto-section-number">03 / 05</span><h2>Selected<br/><em>projects</em></h2></div><p className="auto-section-intro">Four verified builds presented as product studies, not generic cards.</p></div><div className="auto-project-list">{projects.map((project,index)=><article className="auto-project-row" key={project.title}><div className="auto-project-visual"><span className="auto-project-visual-label">{project.category}</span><span className="auto-project-visual-index">{project.label}</span><ProjectVisual index={index}/></div><div className="auto-project-info"><div><div className="auto-project-info-top"><span>Product study / {String(index+1).padStart(2,"0")}</span><span>{project.category}</span></div><h3>{project.title}</h3><p>{summaries[index]}</p></div><div className="auto-project-bottom"><div className="auto-project-tags">{project.technologies.slice(0,4).map(tag=><span key={tag}>{tag}</span>)}</div><a className="auto-project-link" href={project.githubUrl || project.liveUrl} target="_blank" rel="noreferrer">GitHub ↗</a></div></div></article>)}</div><a className="auto-text-link" href={profile.githubUrl} target="_blank" rel="noreferrer">View GitHub archive →</a></section>}
