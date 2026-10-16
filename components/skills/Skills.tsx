import { skillGroups } from "@/data/skills";

const capabilityGroups = [
  { name: "Core Android", description: "Mobile architecture and UI systems.", items: skillGroups[0].items.slice(1, 7) },
  { name: "Languages", description: "Primary languages used across the stack.", items: ["Kotlin", "Java", "JSON"] },
  { name: "Backend & APIs", description: "Connected services and realtime communication.", items: skillGroups[1].items.slice(1, 7) },
  { name: "Data & Tools", description: "Storage, auth, and dependable workflows.", items: ["Firebase", "MongoDB", "JWT Authentication", "Git / GitHub"] },
] as const;

export function Skills(){return <section id="skills" className="auto-section auto-capabilities"><div className="auto-section-heading"><span className="auto-section-number">02 / 05</span><h2>What I<br/><em>build with</em></h2><p className="auto-section-intro">A compact view of the tools behind Android applications and connected mobile products.</p></div><div className="auto-capability-layout"><div className="auto-rail"><strong>STACK</strong><span>ANDROID / API / DATA</span></div><div className="auto-skill-matrix">{capabilityGroups.map((group,index)=><article className="auto-skill-block" key={group.name}><header><span>0{index+1}</span><h3>{group.name}</h3></header><p>{group.description}</p><div className="auto-skill-list">{group.items.map(item=><span key={item}>{item}</span>)}</div></article>)}</div></div></section>}
