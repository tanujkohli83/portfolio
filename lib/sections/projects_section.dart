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
        'title': 'Employee Directory API',
        'desc':
            'Built a REST API with Spring Boot for employee records. Implemented CRUD endpoints, input validation, and PostgreSQL integration.',
        'tech': ['SPRING_BOOT', 'JAVA', 'POSTGRESQL', 'REST_API'],
        'icon': Icons.badge,
        'imagePath': '',
        'tagText': '01_BACKEND',
        'badgeText': 'PROJECT',
        'color1': const Color(0xFFC7F000), // Yellow-green
        'color2': const Color(0xFF8FA1D0), // Blue-grey
        'buttonLabel': 'VIEW DETAILS',
        'buttonIcon': Icons.api,
      },
      {
        'title': 'Task Tracker Service',
        'desc':
            'Created a backend service in ASP.NET Core to manage tasks, status updates, and basic authentication for a team workflow app.',
        'tech': ['ASP.NET_CORE', 'C#', 'SQL', 'JWT'],
        'icon': Icons.task_alt,
        'imagePath': '',
        'tagText': '02_BACKEND',
        'badgeText': 'PROJECT',
        'color1': const Color(0xFF92B6FF), // Light blue
        'color2': const Color(0xFFC7F000), // Yellow-green
        'buttonLabel': 'VIEW DETAILS',
        'buttonIcon': Icons.visibility,
      },
      {
        'title': 'Inventory Service',
        'desc':
            'Developed a Spring Boot microservice for inventory updates with MongoDB storage and basic role-based endpoint protection.',
        'tech': ['SPRING_BOOT', 'MONGODB', 'JAVA', 'DOCKER'],
        'icon': Icons.inventory_2,
        'imagePath': '',
        'tagText': '03_SERVICE',
        'badgeText': 'PROJECT',
        'color1': const Color(0xFFF0B300), // Orange
        'color2': const Color(0xFFF0B300),
        'buttonLabel': 'VIEW DETAILS',
        'buttonIcon': Icons.storage,
      },
      {
        'title': 'Admin Dashboard Integration',
        'desc':
            'Connected an AngularJS frontend with ASP.NET APIs for user and report management, including pagination and filtering support.',
        'tech': ['ANGULARJS', 'ASP.NET_CORE', 'POSTGRESQL', 'SQL'],
        'icon': Icons.dashboard_customize,
        'imagePath': '',
        'tagText': '04_INTEGRATION',
        'badgeText': 'PROJECT',
        'color1': const Color(0xFF00E5FF), // Cyan
        'color2': const Color(0xFF00E5FF),
        'buttonLabel': 'VIEW DETAILS',
        'buttonIcon': Icons.web,
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
