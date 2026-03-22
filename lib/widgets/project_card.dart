import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_theme.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath; // kept for API compatibility, not used for display
  final List<String> techStack;
  final IconData icon;
  final Color? color1;
  final Color? color2;
  final String? tagText;
  final String? badgeText;
  final String? buttonLabel;
  final IconData? buttonIcon;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.techStack,
    required this.icon,
    this.color1,
    this.color2,
    this.tagText,
    this.badgeText,
    this.buttonLabel,
    this.buttonIcon,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.025).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _scaleController.forward();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _scaleController.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnim,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: _hovered ? const Color(0xFF131A2A) : AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? (widget.color1 ?? const Color(0xFFCCFF00)).withOpacity(0.3)
                  : AppColors.border,
              width: 1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: (widget.color1 ?? const Color(0xFFCCFF00)).withOpacity(0.05),
                      blurRadius: 32,
                      spreadRadius: 4,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Label + LIVE badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.tagText ?? '01_DEPLOYMENT',
                      style: AppTheme.monoStyle.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: widget.color1 ?? const Color(0xFFCCFF00),
                        letterSpacing: 1.5,
                      ),
                    ),
                    if (widget.badgeText != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: widget.color1 ?? const Color(0xFFCCFF00),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.badgeText!,
                          style: AppTheme.monoStyle.copyWith(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                // Title
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 20),
                // Description
                Text(
                  widget.description,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.6,
                    fontSize: 14,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 24),
                // Tech Chips
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: widget.techStack.map((tech) => _techChip(tech)).toList(),
                ),
                const Spacer(),
                const SizedBox(height: 24),
                // Footer Buttons
                Row(
                  children: [
                    Expanded(
                      child: _HoverSolidButton(
                        label: widget.buttonLabel ?? 'PREVIEW BUILD',
                        colorText: widget.color2 ?? const Color(0xFF8FA1D0),
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    _HoverSolidIconButton(
                      icon: widget.buttonIcon,
                      colorIcon: widget.color1 ?? const Color(0xFFCCFF00),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _techChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTheme.monoStyle.copyWith(
          fontSize: 11,
          color: widget.color2 ?? const Color(0xFF8FA1D0),
          letterSpacing: 0.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HoverSolidButton extends StatefulWidget {
  final String label;
  final Color colorText;
  final VoidCallback onTap;

  const _HoverSolidButton({required this.label, required this.colorText, required this.onTap});

  @override
  State<_HoverSolidButton> createState() => _HoverSolidButtonState();
}

class _HoverSolidButtonState extends State<_HoverSolidButton> {
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
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _hovered ? const Color(0xFF2C3954) : const Color(0xFF222B40),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered ? widget.colorText : Colors.transparent,
            ),
          ),
          child: Text(
            widget.label,
            style: AppTheme.monoStyle.copyWith(
              color: widget.colorText,
              fontSize: 12,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _HoverSolidIconButton extends StatefulWidget {
  final IconData? icon;
  final Color colorIcon;
  final VoidCallback onTap;

  const _HoverSolidIconButton({required this.icon, required this.colorIcon, required this.onTap});

  @override
  State<_HoverSolidIconButton> createState() => _HoverSolidIconButtonState();
}

class _HoverSolidIconButtonState extends State<_HoverSolidIconButton> {
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
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: _hovered ? const Color(0xFF2C3954) : const Color(0xFF222B40),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered ? widget.colorIcon : Colors.transparent,
            ),
          ),
          child: widget.icon != null 
              ? Icon(
                  widget.icon,
                  color: widget.colorIcon,
                  size: 20,
                )
              : Text(
                  '< >',
                  style: AppTheme.monoStyle.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
