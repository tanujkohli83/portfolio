import 'package:flutter/material.dart';
import '../widgets/section_title.dart';
import '../widgets/skill_chip.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = [
      {'name': 'Flutter', 'icon': Icons.flutter_dash},
      {'name': 'Dart', 'icon': Icons.code},
      {'name': 'Provider', 'icon': Icons.cookie_outlined},
      {'name': 'Kotlin', 'icon': Icons.android},
      {'name': 'Java', 'icon': Icons.coffee},
      {'name': 'Spring Boot', 'icon': Icons.computer_rounded},
      {'name': 'Restfull APIs', 'icon': Icons.api},
      {'name': 'Firebase', 'icon': Icons.local_fire_department},
      {'name': 'Git / GitHub', 'icon': Icons.terminal},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Skills_and_Tools'),
          const SizedBox(height: 40),
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
