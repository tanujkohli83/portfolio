import type { Metadata } from "next";
import { JetBrains_Mono, Space_Grotesk } from "next/font/google";
import "./globals.css";
import "./stitch-theme.css";
import "./mono-theme.css";
import "./scene-motion.css";
import "./resume-content.css";
import "./automotive-theme.css";
import "./signal-theme.css";
import "./dezerv-theme.css";

const techSans = Space_Grotesk({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const techMono = JetBrains_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "Tanuj Kohli — Mobile Developer",
  description: "Portfolio of Tanuj Kohli, a Mobile Developer building Android applications with Kotlin, Firebase, REST APIs, and Kotlin Multiplatform.",
  openGraph: {
    title: "Tanuj Kohli — Mobile Developer",
    description: "Portfolio of Tanuj Kohli, a Mobile Developer building Android applications with Kotlin, Firebase, REST APIs, and Kotlin Multiplatform.",
    type: "website",
  },
  twitter: {
    card: "summary",
    title: "Tanuj Kohli — Mobile Developer",
    description: "Portfolio of Tanuj Kohli, a Mobile Developer building Android applications with Kotlin, Firebase, REST APIs, and Kotlin Multiplatform.",
  },
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html
      lang="en"
      className={`${techSans.variable} ${techMono.variable} h-full antialiased`}
    >
      <body className="min-h-full flex flex-col">{children}</body>
    </html>
  );
}
