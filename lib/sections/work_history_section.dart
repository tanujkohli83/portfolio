import 'package:flutter/material.dart';
import '../widgets/section_title.dart';
import '../widgets/timeline_item.dart';

class WorkHistorySection extends StatelessWidget {
  const WorkHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Work_History'),
          const SizedBox(height: 48),
          const TimelineItem(
            role: 'Application Development Intern',
            company: 'Bright InfoTech Pvt. Ltd.',
            period: 'Jan 2026 — PRESENT',
            points: [
              'Devloped the Admin Panel in Flutter Web Application .',
              'Integrated 10+ REST APIs to connect frontend components with core backend services.',
              'Managed application state and built accessible, responsive UIs across web platforms.',
            ],
          ),
          const TimelineItem(
            role: 'Mobile App Developer Intern',
            company: 'Paramount Infosystem Pvt. Ltd.',
            period: 'July 2025 – Oct 2025',
            points: [
              'Built 2 mobile apps using Kotlin multiplatform and compose multiplatform with ASP.NET backend.',
              'Integrated 10+ REST APIs to connect frontend components with core backend services.',
              'Managed application state and built accessible, responsive UIs across mobile platforms.',
            ],
          ),
          const TimelineItem(
            role: 'Software Developer Intern',
            company: 'Utopian Gateway',
            period: 'Mar 2025 - Apr 2025',
            points: [
              'Developed mobile apps using Flutter and Django (backend).',
              'Managed the end-to-end integration of RESTful APIs to connect frontend and backend services, improving data flow.',
              'Built responsive UI and backend services with Flutter',
            ],
            isLast: true,
          ),
        ],
      ),
    );
  }
}
