import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_theme.dart';

class SkillChip extends StatefulWidget {
  final String label;
  final IconData icon;

  const SkillChip({super.key, required this.label, required this.icon});

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _liftController;
  late Animation<double> _liftAnim;

  @override
  void initState() {
    super.initState();
    _liftController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _liftAnim = Tween<double>(begin: 0, end: -6).animate(
      CurvedAnimation(parent: _liftController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _liftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _liftController.forward();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _liftController.reverse();
      },
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _liftAnim,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _liftAnim.value),
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.primary.withOpacity(0.1)
                : AppColors.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered ? AppColors.primary : AppColors.border,
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: _hovered ? AppColors.primary : AppColors.textSecondary,
              ),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: AppTheme.monoStyle.copyWith(
                  color: _hovered
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontWeight:
                      _hovered ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
