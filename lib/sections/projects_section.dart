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
        'title': 'Oragtre',
        'desc':
            'A revolutionary e-commerce platform focused on organic products. Built with Flutter, featuring real-time inventory tracking and a custom recommendation engine. This application optimizes the supply chain for local organic producers.',
        'tech': ['FLUTTER', 'FIREBASE', 'STRIPE_API', 'RIVERPOD'],
        'icon': Icons.inventory,
        'imagePath': '',
        'tagText': '01_DEPLOYMENT',
        'badgeText': 'LIVE',
        'color1': const Color(0xFFC7F000), // Yellow-green
        'color2': const Color(0xFF8FA1D0), // Blue-grey
        'buttonLabel': 'PREVIEW BUILD',
        'buttonIcon': null,
      },
      {
        'title': 'BGIR',
        'desc':
            'An internal resource management system for corporate deployment. Streamlined workflow automation and multi-layered authentication for data security, built to handle massive concurrent operations.',
        'tech': ['KOTLIN', 'SPRING_BOOT', 'SQL_LITE', 'DOCKER'],
        'icon': Icons.task_alt,
        'imagePath': '',
        'tagText': '02_DEPLOYMENT',
        'badgeText': 'BETA',
        'color1': const Color(0xFF92B6FF), // Light blue
        'color2': const Color(0xFFC7F000), // Yellow-green
        'buttonLabel': 'ACCESS SOURCE',
        'buttonIcon': Icons.visibility,
      },
      {
        'title': 'Soil Health App',
        'desc':
            'A Flutter Mobile Application that monitors soil health parameters like Temperature and moisture using Bluetooth Device (BLE). Data stored in Firebase and cached locally with visualization.',
        'tech': ['FLUTTER', 'FIREBASE', 'BLE'],
        'icon': Icons.bluetooth_audio_rounded,
        'imagePath': '',
        'tagText': '03_PROTOTYPE',
        'badgeText': 'ALPHA',
        'color1': const Color(0xFFF0B300), // Orange
        'color2': const Color(0xFFF0B300), 
        'buttonLabel': 'VIEW DETAILS',
        'buttonIcon': null,
      },
      {
        'title': 'Movie API',
        'desc':
            'Made a Movie API using Go Lang where it can perform CRUD operations on the movies. Clean RESTful architecture with proper error handling.',
        'tech': ['GO LANG', 'HTTP', 'REST'],
        'icon': Icons.movie,
        'imagePath': '',
        'tagText': '04_SERVICE',
        'badgeText': 'LIVE',
        'color1': const Color(0xFF00E5FF), // Cyan
        'color2': const Color(0xFF00E5FF),
        'buttonLabel': 'API DOCS',
        'buttonIcon': Icons.api,
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
              childAspectRatio: Responsive.isMobile(context) ? 0.9 : 1.35,
            ),
            itemBuilder: (context, index) {
              final p = projects[index];
              return ProjectCard(
                title: p['title'] as String,
                description: p['desc'] as String,
                imagePath: p['imagePath'] as String,
                techStack: p['tech'] as List<String>,
                icon: p['icon'] as IconData,
                color1: p['color1'] as Color?,
                color2: p['color2'] as Color?,
                tagText: p['tagText'] as String?,
                badgeText: p['badgeText'] as String?,
                buttonLabel: p['buttonLabel'] as String?,
                buttonIcon: p['buttonIcon'] as IconData?,
              );
            },
          ),
        ],
      ),
    );
  }
}
