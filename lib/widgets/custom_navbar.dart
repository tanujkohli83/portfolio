import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_theme.dart';

class CustomNavbar extends StatelessWidget {
  final int activeIndex;
  final Function(int) onTabSelected;

  const CustomNavbar({
    super.key,
    required this.activeIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [
      'main.kt',
      'skills.json',
      'experience.log',
      'projects.dart',
      'contact.sh',
    ];

    return Container(
      height: 60,
      color: AppColors.scaffoldBg,
      child: Row(
        children: [
          // const SizedBox(width: 16),
          // Logo or Title
          // const Text(
          //   'me.dev',
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 18,
          //     color: AppColors.textPrimary,
          //   ),
          // ),
          const SizedBox(width: 32),
          // Desktop Tabs
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                final isActive = activeIndex == index;
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => onTabSelected(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isActive
                                ? AppColors.primary
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        tabs[index],
                        style: AppTheme.monoStyle.copyWith(
                          color: isActive
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                          fontWeight: isActive
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Actions
          // ElevatedButton(
          //   onPressed: () {},
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: AppColors.primary,
          //     foregroundColor: Colors.white,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   child: const Text('DEPLOY'),
          // ),
          // const SizedBox(width: 16),
          // const CircleAvatar(
          //   backgroundColor: AppColors.cardBg,
          //   child: Icon(Icons.person, color: AppColors.textSecondary),
          // ),
          // const SizedBox(width: 16),
        ],
      ),
    );
  }
}
