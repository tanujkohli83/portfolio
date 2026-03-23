import 'package:flutter/material.dart';
import '../widgets/section_title.dart';
import '../widgets/skill_chip.dart';
import '../core/constants/app_colors.dart';
import '../core/theme/app_theme.dart';

class SkillsSection extends StatelessWidget {
  final double scrollOffset;

  const SkillsSection({super.key, this.scrollOffset = 0});

  @override
  Widget build(BuildContext context) {
    final skills = [
      {'name': 'Java', 'icon': Icons.coffee},
      {'name': 'Spring Boot', 'icon': Icons.computer_rounded},
      {'name': 'C#', 'icon': Icons.code},
      {'name': 'ASP.NET Core', 'icon': Icons.web},
      {'name': 'AngularJS', 'icon': Icons.web_asset},
      {'name': 'REST APIs', 'icon': Icons.api},
      {'name': 'MongoDB', 'icon': Icons.storage},
      {'name': 'SQL', 'icon': Icons.table_chart},
      {'name': 'PostgreSQL', 'icon': Icons.dns},
      {'name': 'Git / GitHub', 'icon': Icons.terminal},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Two-column section header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CURRENTLY_ACTIVE',
                    style: AppTheme.monoStyle.copyWith(
                      color: AppColors.primary,
                      fontSize: 11,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const SectionTitle(title: 'System_Dependencies'),
                ],
              ),
              const Spacer(),
              Flexible(
                flex: 2,
                child: Text(
                  'Backend-focused stack for building secure and maintainable APIs, integrating databases, and supporting web applications as a fresher developer.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: skills
                .map(
                  (s) => SkillChip(
                    label: s['name'] as String,
                    icon: s['icon'] as IconData,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
