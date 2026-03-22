import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/downloadResume.dart';

class CodeEditorCard extends StatefulWidget {
  const CodeEditorCard({super.key});

  @override
  State<CodeEditorCard> createState() => _CodeEditorCardState();
}

class _CodeEditorCardState extends State<CodeEditorCard>
    with SingleTickerProviderStateMixin {
  double _rotateX = 0;
  double _rotateY = 0;
  late AnimationController _smoothController;
  late Animation<double> _rotateXAnim;
  late Animation<double> _rotateYAnim;
  double _targetX = 0;
  double _targetY = 0;

  @override
  void initState() {
    super.initState();
    _smoothController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _rotateXAnim = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _smoothController, curve: Curves.easeOut),
    );
    _rotateYAnim = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _smoothController, curve: Curves.easeOut),
    );
    _rotateXAnim.addListener(() => setState(() {
          _rotateX = _rotateXAnim.value;
          _rotateY = _rotateYAnim.value;
        }));
  }

  @override
  void dispose() {
    _smoothController.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent event) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final size = box.size;

    final dx = event.localPosition.dx;
    final dy = event.localPosition.dy;
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final normalizedX = centerX == 0 ? 0.0 : (dx - centerX) / centerX;
    final normalizedY = centerY == 0 ? 0.0 : (dy - centerY) / centerY;

    _targetX = normalizedY * -8 * (math.pi / 180); // rotateX
    _targetY = normalizedX * 8 * (math.pi / 180); // rotateY

    // Animate smoothly using tween
    _rotateXAnim = Tween<double>(begin: _rotateX, end: _targetX).animate(
      CurvedAnimation(parent: _smoothController, curve: Curves.easeOut),
    );
    _rotateYAnim = Tween<double>(begin: _rotateY, end: _targetY).animate(
      CurvedAnimation(parent: _smoothController, curve: Curves.easeOut),
    );
    _rotateXAnim.addListener(() => setState(() {
          _rotateX = _rotateXAnim.value;
          _rotateY = _rotateYAnim.value;
        }));

    _smoothController.forward(from: 0);
  }

  void _onExit(PointerEvent event) {
    _targetX = 0;
    _targetY = 0;
    _rotateXAnim = Tween<double>(begin: _rotateX, end: 0).animate(
      CurvedAnimation(parent: _smoothController, curve: Curves.easeOut),
    );
    _rotateYAnim = Tween<double>(begin: _rotateY, end: 0).animate(
      CurvedAnimation(parent: _smoothController, curve: Curves.easeOut),
    );
    _rotateXAnim.addListener(() => setState(() {
          _rotateX = _rotateXAnim.value;
          _rotateY = _rotateYAnim.value;
        }));
    _smoothController.forward(from: 0);
  }

  Widget build(BuildContext context) {
    return FadeInUp(
      child: Listener(
        onPointerMove: _onHover,
        onPointerHover: _onHover,
        child: MouseRegion(
          onExit: _onExit,
          child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(_rotateX)
                  ..rotateY(_rotateY),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 820),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.08),
                        blurRadius: 40,
                        offset: const Offset(0, 10),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Window Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: const BoxDecoration(
                          color: AppColors.editorBg,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(14)),
                        ),
                        child: Row(
                          children: [
                            _dot(const Color(0xFFFF5F57)),
                            const SizedBox(width: 8),
                            _dot(const Color(0xFFFFBE2E)),
                            const SizedBox(width: 8),
                            _dot(const Color(0xFF28CA41)),
                            const SizedBox(width: 16),
                            Text(
                              'developer.kt',
                              style: AppTheme.monoStyle.copyWith(
                                fontSize: 11,
                                color: AppColors.textDim,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'EDITOR — KOTLIN',
                              style: AppTheme.monoStyle.copyWith(
                                fontSize: 10,
                                color: AppColors.textDim,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Name + Tagline Hero (above code)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '// ARCHITECT_OS v2.1',
                              style: AppTheme.monoStyle.copyWith(
                                color: AppColors.textDim,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '// role: Mobile Developer',
                              style: AppTheme.monoStyle.copyWith(
                                color: AppColors.textDim,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Tanuj Kohli',
                              style: AppTheme.monoStyle.copyWith(
                                color: AppColors.textPrimary,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Crafting fluid mobile & digital experiences through Flutter and Android development. Architecting scalable solutions with precision and focus.',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      // Code Block
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(28, 8, 28, 8),
                          child: SelectableText.rich(
                            TextSpan(
                              children: [
                                _codeLine('1', [
                                  _span('import ', AppColors.codeKeyword),
                                  _span('com.portfolio.MobileDev',
                                      AppColors.textPrimary),
                                ]),
                                _emptyLine('2'),
                                _codeLine('3', [
                                  _span('class ', AppColors.codeKeyword),
                                  _span('Developer ', AppColors.primary),
                                  _span('{', AppColors.textPrimary),
                                ]),
                                _codeLine('4', [
                                  _span('  val ', AppColors.codeKeyword),
                                  _span('name = ', AppColors.textPrimary),
                                  _span(
                                      '"Tanuj Kohli"', AppColors.codeString),
                                ]),
                                _codeLine('5', [
                                  _span('  val ', AppColors.codeKeyword),
                                  _span('roles = ', AppColors.textPrimary),
                                  _span('listOf', AppColors.accent),
                                  _span('(', AppColors.textPrimary),
                                  _span('"Flutter Dev"', AppColors.codeString),
                                  _span(', ', AppColors.textPrimary),
                                  _span(
                                      '"Android Dev"', AppColors.codeString),
                                  _span(')', AppColors.textPrimary),
                                ]),
                                _codeLine('6', [
                                  _span('  val ', AppColors.codeKeyword),
                                  _span('mission = ', AppColors.textPrimary),
                                  _span(
                                    '"Building seamless mobile experiences with clean code."',
                                    AppColors.codeString,
                                  ),
                                ]),
                                _codeLine(
                                    '7', [_span('}', AppColors.textPrimary)]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Divider
                      Container(height: 1, color: AppColors.border),
                      // Footer Buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              Wrap(
                                spacing: 16,
                                runSpacing: 16,
                                children: [
                                  _btn(
                                    'Execute_Build.sh',
                                    AppColors.primary,
                                    Icons.play_arrow,
                                    () {},
                                  ),
                                  _btn(
                                    'Resume.pdf',
                                    AppColors.editorBg,
                                    Icons.description_outlined,
                                    () => downloadResume(),
                                  ),
                                ],
                              ),
                              // Part / Language label
                              Text(
                                '● FLUTTER ● ANDROID',
                                style: AppTheme.monoStyle.copyWith(
                                  color: AppColors.textDim,
                                  fontSize: 11,
                                  letterSpacing: 1,
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
          ),
        );
  }

  Widget _dot(Color color) => Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );

  TextSpan _span(String text, Color color) => TextSpan(
        text: text,
        style: AppTheme.monoStyle.copyWith(color: color, fontSize: 13),
      );

  TextSpan _codeLine(String num, List<TextSpan> content) {
    return TextSpan(
      children: [
        TextSpan(
          text: '${num.padRight(4)}',
          style: AppTheme.monoStyle.copyWith(
              color: AppColors.textDim, fontSize: 13),
        ),
        ...content,
        const TextSpan(text: '\n'),
      ],
    );
  }

  TextSpan _emptyLine(String num) => TextSpan(
        text: '${num.padRight(4)}\n',
        style: AppTheme.monoStyle.copyWith(
            color: AppColors.textDim, fontSize: 13),
      );

  Widget _btn(String label, Color color, IconData icon, VoidCallback onPressed) {
    return _HoverButton(
      label: label,
      color: color,
      icon: icon,
      onPressed: onPressed,
    );
  }
}

class _HoverButton extends StatefulWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const _HoverButton({
    required this.label,
    required this.color,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: widget.color == AppColors.primary
                          ? AppColors.primary.withOpacity(0.4)
                          : Colors.white.withOpacity(0.05),
                      blurRadius: 16,
                    )
                  ]
                : [],
            border: Border.all(
              color: _hovered && widget.color != AppColors.primary
                  ? AppColors.border.withOpacity(1.0)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 16, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: AppTheme.monoStyle.copyWith(
                  color: Colors.white,
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
