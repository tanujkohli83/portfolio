import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_theme.dart';

class TimelineItem extends StatefulWidget {
  final String role;
  final String company;
  final String period;
  final List<String> points;
  final List<String> tags;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.role,
    required this.company,
    required this.period,
    required this.points,
    this.tags = const [],
    this.isLast = false,
  });

  @override
  State<TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<TimelineItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: _hovered ? AppColors.primary : AppColors.cardBg,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: _hovered ? 2 : 2.5,
                  ),
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.6),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 6,
                          ),
                        ],
                ),
              ),
              if (!widget.isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.border,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 24),
          // Content Card
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _hovered = true),
              onExit: (_) => setState(() => _hovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.only(bottom: 32),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _hovered
                      ? const Color(0xFF111827)
                      : AppColors.cardBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _hovered
                        ? AppColors.primary.withOpacity(0.5)
                        : AppColors.border,
                    width: 1,
                  ),
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.12),
                            blurRadius: 24,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.role,
                                style: AppTheme.monoStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.company,
                                style: TextStyle(
                                  color: AppColors.codeKeyword,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.period,
                              style: AppTheme.monoStyle.copyWith(
                                color: AppColors.textDim,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Tech tags
                            if (widget.tags.isNotEmpty)
                              Row(
                                children: widget.tags
                                    .map((tag) => _tag(tag))
                                    .toList(),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...widget.points.map(
                      (p) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                p,
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  height: 1.6,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String label) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.editorBg,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: AppTheme.monoStyle.copyWith(
          color: AppColors.textDim,
          fontSize: 10,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
