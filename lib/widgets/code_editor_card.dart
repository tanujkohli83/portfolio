import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/downloadResume.dart';

class CodeEditorCard extends StatelessWidget {
  const CodeEditorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Window Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: AppColors.editorBg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  _dot(Colors.red),
                  const SizedBox(width: 8),
                  _dot(Colors.orange),
                  const SizedBox(width: 8),
                  _dot(Colors.green),
                  const Spacer(),
                  Text(
                    'EDITOR - KOTLIN',
                    style: AppTheme.monoStyle.copyWith(
                      fontSize: 10,
                      color: AppColors.textDim,
                    ),
                  ),
                ],
              ),
            ),
            // Code Block
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SelectableText.rich(
                  TextSpan(
                    children: [
                      _codeLine('1', [
                        _span('import ', AppColors.codeKeyword),
                        _span('com.portfolio.MobileDev', AppColors.textPrimary),
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
                        _span('"Tanuj Kohli"', AppColors.codeString),
                      ]),
                      _codeLine('5', [
                        _span('  val ', AppColors.codeKeyword),
                        _span('roles = ', AppColors.textPrimary),
                        _span('listOf', AppColors.accent),
                        _span('(', AppColors.textPrimary),
                        _span('"Flutter Expert"', AppColors.codeString),
                        _span(', ', AppColors.textPrimary),
                        _span('"Android Dev"', AppColors.codeString),
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
                      _codeLine('7', [_span('}', AppColors.textPrimary)]),
                    ],
                  ),
                ),
              ),
            ),
            // Footer Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _btn(
                    'Execute_Build.sh',
                    AppColors.primary,
                    Icons.play_arrow,
                    () {
                      // Action for build button
                    },
                  ),
                  _btn(
                    'Resume.pdf',
                    AppColors.editorBg,
                    Icons.description_outlined,
                    () {
                      downloadResume();
                    },
                  ),
                ],
              ),
            ),
          ],
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
    style: AppTheme.monoStyle.copyWith(color: color),
  );

  TextSpan _codeLine(String num, List<TextSpan> content) {
    return TextSpan(
      children: [
        TextSpan(
          text: '${num.padRight(4)}',
          style: AppTheme.monoStyle.copyWith(color: AppColors.textDim),
        ),
        ...content,
        const TextSpan(text: '\n'),
      ],
    );
  }

  TextSpan _emptyLine(String num) => TextSpan(
    text: '${num.padRight(4)}\n',
    style: AppTheme.monoStyle.copyWith(color: AppColors.textDim),
  );

  Widget _btn(
    String label,
    Color color,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label, style: AppTheme.monoStyle),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
