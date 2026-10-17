import type { Metadata, Viewport } from "next";
import { JetBrains_Mono, Space_Grotesk } from "next/font/google";
import "./globals.css";
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

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
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
