import 'package:flutter/material.dart';
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
          Text(
            'EXPERIENCE',
            style: AppTheme.monoStyle.copyWith(
              color: AppColors.textPrimary,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Container(height: 2, color: AppColors.textPrimary),
          const SizedBox(height: 28),
          const TimelineItem(
            role: 'Bright Infotech Pvt Ltd.',
            company: 'App Development Intern',
            period: 'Jan 2026 - March 2026',
            location: 'Remote',
            points: [
              'Worked on an LMS web project, integrating FastAPI-based backend services with Flutter frontend for seamless data communication.',
              'Built a mobile application featuring an offline AI model for on-device processing and enhanced performance.',
              'Contributed to the development of a networking-based mobile app that enables digital business card sharing, connection management, and automated follow-up messaging features.',
            ],
          ),
          const TimelineItem(
            role: 'Paramount Infosystem Pvt Ltd.',
            company: 'Mobile App Developer Intern',
            period: 'July 2025 - Oct 2025',
            location: 'New Delhi, IN',
            points: [
              'Built 2 mobile apps using Kotlin multiplatform and compose multiplatform with ASP.NET backend.',
              'Integrated 10+ REST APIs to connect frontend components with core backend services..',
              'Managed application state and built accessible, responsive UIs across mobile platforms.',
            ],
          ),
          const TimelineItem(
            role: 'Utopian Gateway.',
            company: 'Software Developer Intern',
            period: 'March 2025 - June 2025',
            location: 'Remote',
            points: [
              'Built 2 mobile apps using Kotlin multiplatform and compose multiplatform with ASP.NET backend.',
              'Integrated 10+ REST APIs to connect frontend components with core backend services..',
              'Managed application state and built accessible, responsive UIs across mobile platforms.',
            ],
            isLast: true,
          ),
        ],
      ),
    );
  }
}
