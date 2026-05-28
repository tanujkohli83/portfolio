import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/open_link.dart';

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
  final String? buttonUrl;

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
    this.buttonUrl,
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
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 1.025,
    ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeOut));
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
            color: _hovered ? const Color(0xFF1A1F2B) : const Color(0xFF1C2029),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _hovered
                  ? (widget.color1 ?? AppColors.primary).withOpacity(0.45)
                  : const Color(0xFF353A44),
              width: 1.2,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.22),
                      blurRadius: 24,
                      spreadRadius: 1,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.tagText ?? '01_PROJECT',
                        style: AppTheme.monoStyle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: widget.color1 ?? AppColors.primary,
                          letterSpacing: 1.3,
                        ),
                      ),
                    ),
                    if (widget.buttonUrl != null)
                      _ActionTile(
                        icon: widget.buttonIcon ?? Icons.open_in_new,
                        color: widget.color1 ?? AppColors.primary,
                        onTap: () => _openLink(widget.buttonUrl!),
                      )
                    else if (widget.buttonIcon != null)
                      _ActionTile(
                        icon: widget.buttonIcon!,
                        color: AppColors.textDim,
                        onTap: null,
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                // Title
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.05,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 18),
                // Description
                Text(
                  widget.description,
                  style: TextStyle(
                    color: const Color(0xFFD7D9DD),
                    height: 1.75,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                // Tech Chips
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: widget.techStack
                      .map((tech) => _techChip(tech))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openLink(String url) async {
    await openExternalLink(url);
  }

  Widget _techChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF20252F),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: (widget.color1 ?? AppColors.primary).withOpacity(0.22),
          width: 1,
        ),
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTheme.monoStyle.copyWith(
          fontSize: 12,
          color: widget.color1 ?? AppColors.primary,
          letterSpacing: 1,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ActionTile extends StatefulWidget {
  final IconData? icon;
  final Color color;
  final VoidCallback? onTap;

  const _ActionTile({
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  State<_ActionTile> createState() => _ActionTileState();
}

class _ActionTileState extends State<_ActionTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: widget.onTap != null
          ? (_) => setState(() => _hovered = true)
          : null,
      onExit: widget.onTap != null
          ? (_) => setState(() => _hovered = false)
          : null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _hovered ? const Color(0xFF343943) : const Color(0xFF3A3F49),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.onTap != null
                  ? widget.color.withOpacity(0.12)
                  : Colors.transparent,
            ),
          ),
          child: Center(
            child: Icon(
              widget.icon ?? Icons.open_in_new,
              color: widget.onTap != null ? widget.color : AppColors.textDim,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
