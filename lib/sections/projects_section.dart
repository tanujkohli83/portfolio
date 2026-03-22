import 'package:flutter/material.dart';
import '../widgets/section_title.dart';
import '../widgets/project_card.dart';
import '../core/utils/responsive.dart';
import '../core/constants/app_colors.dart';
import '../core/theme/app_theme.dart';

class ProjectsSection extends StatelessWidget {
  final double scrollOffset;

  const ProjectsSection({super.key, this.scrollOffset = 0});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        'title': 'Oragtre.',
        'desc':
            'Enterprise stock management solution built with Flutter and ASP.NET, successfully managing thousands of stocks across multiple Retailers and Distributors.',
        'tech': ['Flutter', 'Dart', 'Riverpod'],
        'icon': Icons.inventory,
        'imagePath': '',
      },
      {
        'title': 'BGIR.',
        'desc':
            'Built a tool to manage tasks of Employees using Kotlin, Swift, Firebase and ASP.NET as Backend. Over many employees have used it so far, with 500+ Tasks being Created and Done.',
        'tech': ['Kotlin', 'Swift', 'Firebase'],
        'icon': Icons.task_alt,
        'imagePath': '',
      },
      {
        'title': 'Soil Health App.',
        'desc':
            'A Flutter Mobile Application that monitors soil health parameters like Temperature and moisture using Bluetooth Device (BLE). Data stored in Firebase and cached locally with visualization.',
        'tech': ['Flutter', 'Firebase', 'BLE'],
        'icon': Icons.bluetooth_audio_rounded,
        'imagePath': '',
      },
      {
        'title': 'Movie API (CRUD).',
        'desc':
            'Made a Movie API using Go Lang where it can perform CRUD operations on the movies. Clean RESTful architecture with proper error handling.',
        'tech': ['Go Lang', 'HTTP', 'REST'],
        'icon': Icons.movie,
        'imagePath': '',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ACTIVE_BUILDS',
                    style: AppTheme.monoStyle.copyWith(
                      color: AppColors.primary,
                      fontSize: 11,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const SectionTitle(title: 'Featured_Projects'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
              crossAxisSpacing: 28,
              mainAxisSpacing: 28,
              childAspectRatio: Responsive.isMobile(context) ? 0.85 : 1.05,
            ),
            itemBuilder: (context, index) {
              final p = projects[index];
              return ProjectCard(
                title: p['title'] as String,
                description: p['desc'] as String,
                imagePath: p['imagePath'] as String,
                techStack: p['tech'] as List<String>,
                icon: p['icon'] as IconData,
              );
            },
          ),
        ],
      ),
    );
  }
}
