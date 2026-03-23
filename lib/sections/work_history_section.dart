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
            role: 'Junior Software Developer',
            company: 'Jogaz Info Private Limited',
            period: 'Mar 2026 — PRESENT',
            tags: ['ASP.NET', 'Angular JS'],
            points: [
              'Contributing to day-to-day development tasks across assigned modules.',
              'Supporting implementation, testing, and bug-fix workflows with the team.',
              'Working in an on-site role from Green Park, New Delhi.',
            ],
          ),
          const TimelineItem(
            role: 'Software Developer Intern',
            company: 'Bright InfoTech Pvt. Ltd.',
            period: 'Jan 2026 — March 2026',
            tags: ['SPRING_BOOT', 'SQL'],
            points: [
              'Implemented and tested REST endpoints for internal admin modules.',
              'Worked on SQL queries, schema updates, and API response optimization.',
              'Collaborated with frontend team for API contracts and error handling.',
            ],
          ),
          const TimelineItem(
            role: 'Mobile App Developer',
            company: 'Paramount Infosystem Pvt. Ltd.',
            period: 'July 2025 – Oct 2025',
            tags: ['ASP.NET', 'POSTGRESQL'],
            points: [
              'Built basic CRUD modules in ASP.NET Core for business workflows.',
              'Integrated PostgreSQL queries and added server-side validations.',
              'Fixed backend bugs and improved API documentation for team usage.',
            ],
            isLast: true,
          ),
        ],
      ),
    );
  }
}
