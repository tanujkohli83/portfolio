import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_theme.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath; // kept for API compatibility, not used for display
  final List<String> techStack;
  final IconData icon;
  final String? accentColor;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.techStack,
    required this.icon,
    this.accentColor,
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
            color: _hovered ? const Color(0xFF0D1526) : AppColors.cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? AppColors.primary.withOpacity(0.6)
                  : AppColors.border,
              width: 1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.18),
                      blurRadius: 32,
                      spreadRadius: 4,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Title + Icon badges
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: AppTheme.monoStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _iconBadge(Icons.star_border, AppColors.codeNumber),
                    const SizedBox(width: 8),
                    _iconBadge(Icons.call_split, AppColors.textDim),
                  ],
                ),
                const SizedBox(height: 14),
                // Description
                Text(
                  widget.description,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.65,
                    fontSize: 13.5,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                // Tech Chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.techStack.map((tech) => _techChip(tech)).toList(),
                ),
                const Spacer(),
                const SizedBox(height: 20),
                // Footer
                Row(
                  children: [
                    _footerLink('Preview', Icons.open_in_new),
                    const SizedBox(width: 20),
                    _footerLink('Source', Icons.code),
                    const Spacer(),
                    _viewMoreButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconBadge(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.editorBg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(icon, size: 14, color: color),
    );
  }

  Widget _techChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: AppTheme.monoStyle.copyWith(
          fontSize: 12,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _footerLink(String label, IconData icon) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textDim),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTheme.monoStyle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textDim,
            ),
          ),
        ],
      ),
    );
  }

  Widget _viewMoreButton() {
    return _HoverOutlineButton(label: 'AFTER HOURS');
  }
}

class _HoverOutlineButton extends StatefulWidget {
  final String label;

  const _HoverOutlineButton({required this.label});

  @override
  State<_HoverOutlineButton> createState() => _HoverOutlineButtonState();
}

class _HoverOutlineButtonState extends State<_HoverOutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.primary.withOpacity(0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Text(
            widget.label,
            style: AppTheme.monoStyle.copyWith(
              color: _hovered ? AppColors.primary : AppColors.textDim,
              fontSize: 11,
              letterSpacing: 0.8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
