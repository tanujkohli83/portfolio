import 'package:flutter/material.dart';
import '../widgets/section_title.dart';
import '../widgets/timeline_item.dart';
import '../core/constants/app_colors.dart';
import '../core/theme/app_theme.dart';

class WorkHistorySection extends StatelessWidget {
  final double scrollOffset;

  const WorkHistorySection({super.key, this.scrollOffset = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Two-column header
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'COMMIT_LOG',
                    style: AppTheme.monoStyle.copyWith(
                      color: AppColors.primary,
                      fontSize: 11,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const SectionTitle(title: 'Deployment_History'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 48),
          const TimelineItem(
            role: 'Application Development Intern',
            company: 'Bright InfoTech Pvt. Ltd.',
            period: 'Jan 2026 — PRESENT',
            tags: ['DART', 'FLUTTER'],
            points: [
              'Developed the Admin Panel in Flutter Web Application.',
              'Integrated 10+ REST APIs to connect frontend components with core backend services.',
              'Managed application state and built accessible, responsive UIs across web platforms.',
            ],
          ),
          const TimelineItem(
            role: 'Mobile App Developer Intern',
            company: 'Paramount Infosystem Pvt. Ltd.',
            period: 'July 2025 – Oct 2025',
            tags: ['KOTLIN', 'KMP'],
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
            tags: ['FLUTTER', 'DJANGO'],
            points: [
              'Developed mobile apps using Flutter and Django (backend).',
              'Managed end-to-end integration of RESTful APIs to connect frontend and backend services.',
              'Built responsive UI and backend services with Flutter.',
            ],
            isLast: true,
          ),
        ],
      ),
    );
  }
}
