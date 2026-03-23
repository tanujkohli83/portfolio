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
      'main.java',
      'skills.json',
      'experience.log',
      'projects.cs',
      'contact.sh',
    ];

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.scaffoldBg,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Row(
        children: [
          // const SizedBox(width: 24),
          // // Logo
          // RichText(
          //   text: TextSpan(
          //     children: [
          //       TextSpan(
          //         text: 'ARCHITECT',
          //         style: AppTheme.monoStyle.copyWith(
          //           color: AppColors.textPrimary,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 14,
          //           letterSpacing: 1.5,
          //         ),
          //       ),
          //       TextSpan(
          //         text: '_OS',
          //         style: AppTheme.monoStyle.copyWith(
          //           color: AppColors.primary,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 14,
          //           letterSpacing: 1.5,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(width: 32),
          // Nav Tabs
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(tabs.length, (index) {
                  final isActive = activeIndex == index;
                  return _NavTab(
                    label: tabs[index],
                    isActive: isActive,
                    onTap: () => onTabSelected(index),
                  );
                }),
              ),
            ),
          ),
          // Right Actions
          // _NavButton(
          //   label: 'PREFERENCES',
          //   color: Colors.transparent,
          //   onTap: () {},
          // ),
          // const SizedBox(width: 8),
          // _NavButton(
          //   label: 'PARTNERS',
          //   color: Colors.transparent,
          //   onTap: () {},
          // ),
          // const SizedBox(width: 8),
          // _NavButton(
          //   label: 'CONTACT Y',
          //   color: Colors.transparent,
          //   onTap: () {},
          // ),
          // const SizedBox(width: 16),
          // _DeployButton(),
          // const SizedBox(width: 24),
        ],
      ),
    );
  }
}

class _NavTab extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavTab> createState() => _NavTabState();
}

class _NavTabState extends State<_NavTab> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          alignment: Alignment.center,
          height: 56,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.isActive
                    ? AppColors.primary
                    : (_hovered ? AppColors.primary.withOpacity(0.4) : Colors.transparent),
                width: 2,
              ),
            ),
          ),
          child: Text(
            widget.label,
            style: AppTheme.monoStyle.copyWith(
              color: widget.isActive
                  ? AppColors.textPrimary
                  : (_hovered ? AppColors.textSecondary : AppColors.textDim),
              fontWeight:
                  widget.isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _NavButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.label,
          style: AppTheme.monoStyle.copyWith(
            color: _hovered ? AppColors.textPrimary : AppColors.textDim,
            fontSize: 11,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}

class _DeployButton extends StatefulWidget {
  @override
  State<_DeployButton> createState() => _DeployButtonState();
}

class _DeployButtonState extends State<_DeployButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: _hovered
              ? const Color(0xFFB8FF57)
              : const Color(0xFFC8FF66),
          borderRadius: BorderRadius.circular(6),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: const Color(0xFFC8FF66).withOpacity(0.4),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Text(
          'DEPLOY ▶',
          style: AppTheme.monoStyle.copyWith(
            color: const Color(0xFF0A0A0A),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
