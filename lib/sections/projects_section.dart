import 'package:flutter/material.dart';
import '../widgets/section_title.dart';
import '../widgets/project_card.dart';
import '../core/utils/responsive.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {
        'title': 'Oragtre.',
        'desc':
            'Enterprise stock management solution built with Flutter and ASP.NET, successfully managing thousands of stocks across multiple Retailers, Distributors.',
        'tech': ['Flutter', 'Dart', 'Riverpod'],
        'icon': Icons.inventory,
        'imagePath': '',
      },
      {
        'title': 'BGIR.',
        'desc':
            'Built a tool to manage the task of the Employees by using Kotlin, Swift, Firebase and ASP.NET as Backend.\nOver many employees have used it so far, with 500+ Task being Created and Done',
        'tech': ['Kotlin', 'Swift', 'Firebase'],
        'icon': Icons.task,
        'imagePath': '',
      },
      {
        'title': 'Soil Health App.',
        'desc':
            'A Flutter Mobile Application that monitors soil health parameter like Temperature and moisture using Bluetooth Device (BLE), The data should Store in Firebase Firestore and cached locally in shared preference and visualized with charts to observe trends.',
        'tech': ['Flutter', 'Dart', 'Riverpod', 'Firebase', 'Bluetooth'],
        'icon': Icons.bluetooth_audio_rounded,
        'imagePath': '',
      },
      {
        'title': 'Movie API (CURD).',
        'desc':
            'Made a Movie API using Go Lang where it can perform CURD operations on the movies.',
        'tech': ['Go Lang', 'HTTP'],
        'icon': Icons.movie,
        'imagePath': '',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Active_Projects'),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
              crossAxisSpacing: 32,
              mainAxisSpacing: 32,
              childAspectRatio: Responsive.isMobile(context) ? 0.75 : 0.95,
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
