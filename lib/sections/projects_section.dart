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
        'title': 'Air Chat',
        'desc':
            'Chat Application built with Flutter and FireBase successfully managing chats of users in realtime.',
        'tech': ['FLUTTER', 'FIREBASE', 'CHAT_APP'],
        'icon': Icons.chat_bubble_outline,
        'imagePath': '',
        'tagText': '01_CHAT_APP',
        'badgeText': 'PROJECT',
        'color1': const Color(0xFF92B6FF),
        'color2': const Color(0xFFC7F000),
        'buttonLabel': 'Link',
        'buttonIcon': Icons.open_in_new,
        'buttonUrl': 'https://github.com/tanujkohli83/Air-Chat',
      },
      {
        'title': 'BGIR',
        'desc':
            'Built a tool to manage the task of the Employees by using Kotlin, Swift, Firebase and ASP.NET as Backend. Over many employees have used it so far, with 500+ Task being Created and Done',
        'tech': ['KOTLIN', 'SWIFT', 'FIREBASE', 'ASP.NET'],
        'icon': Icons.work_outline,
        'imagePath': '',
        'tagText': '02_TOOLING',
        'badgeText': 'PROJECT',
        'color1': const Color(0xFFC7F000),
        'color2': const Color(0xFF8FA1D0),
        'buttonLabel': '',
        'buttonIcon': Icons.lock_outline,
      },
      {
        'title': 'Soil Health App',
        'desc':
            'A Flutter Mobile Application that monitors soil health parameters like Temperature and moisture using Bluetooth Device (BLE). The data should be stored in Firebase Firestore and cached locally in shared preference and visualized with charts to observe trends.',
        'tech': ['FLUTTER', 'BLE', 'FIRESTORE', 'CHARTS'],
        'icon': Icons.sensors,
        'imagePath': '',
        'tagText': '03_IOT',
        'badgeText': 'PROJECT',
        'color1': const Color(0xFF00E5FF),
        'color2': const Color(0xFFF0B300),
        'buttonLabel': 'Link',
        'buttonIcon': Icons.open_in_new,
        'buttonUrl': 'https://github.com/tanujkohli83/Soil-Monitor-App',
      },
      {
        'title': 'Smart Clinic Appointment System (CRUD)',
        'desc':
            'A robust ASP.NET Core REST API for managing clinic appointments. This system enables patients to book appointments with doctors, manage appointment statuses, and handle scheduling conflicts.',
        'tech': ['ASP.NET_CORE', 'REST_API', 'CRUD', 'SQL'],
        'icon': Icons.medical_services_outlined,
        'imagePath': '',
        'tagText': '04_CLINIC',
        'badgeText': 'PROJECT',
        'color1': const Color(0xFF92B6FF),
        'color2': const Color(0xFF00E5FF),
        'buttonLabel': 'Link',
        'buttonIcon': Icons.open_in_new,
        'buttonUrl':
            'https://github.com/tanujkohli83/Smart-Clinic-Appointment-System-API',
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
              childAspectRatio: Responsive.isMobile(context) ? 1.05 : 1.55,
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
                buttonUrl: p['buttonUrl'] as String?,
              );
            },
          ),
        ],
      ),
    );
  }
}
