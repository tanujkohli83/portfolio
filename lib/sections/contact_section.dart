import 'package:flutter/material.dart';
import '../widgets/terminal_form.dart';
import '../core/constants/app_colors.dart';
import '../core/theme/app_theme.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 80, 28, 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '// POST /Hire /Build /Collaborate',
                    style: AppTheme.monoStyle.copyWith(
                      color: AppColors.textDim,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Initialize Contact',
                    style: AppTheme.monoStyle.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Underline accent
                  Container(
                    width: 64,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 60),

          // Full-width Terminal Form
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 900),
              child: const TerminalContactForm(),
            ),
          ),
          const SizedBox(height: 60),

          // Social Link Cards
          _buildSocialRow(context),
        ],
      ),
    );
  }

  Widget _buildSocialRow(BuildContext context) {
    final socials = [
      {'title': 'GITHUB', 'handle': '@tanujkohli83', 'icon': Icons.code},
      {'title': 'LINKEDIN', 'handle': '/in/tanujkohli83', 'icon': Icons.work},
      {
        'title': 'TWITTER',
        'handle': '@tanujkohli83',
        'icon': Icons.alternate_email
      },
      {
        'title': 'EMAIL',
        'handle': 'tanujkohli83@gmail.com',
        'icon': Icons.mail_outline
      },
    ];

    return Center(
      child: Wrap(
        spacing: 20,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: socials
            .map((s) => _SocialCard(
                  title: s['title'] as String,
                  handle: s['handle'] as String,
                  icon: s['icon'] as IconData,
                ))
            .toList(),
      ),
    );
  }
}

class _SocialCard extends StatefulWidget {
  final String title;
  final String handle;
  final IconData icon;

  const _SocialCard({
    required this.title,
    required this.handle,
    required this.icon,
  });

  @override
  State<_SocialCard> createState() => _SocialCardState();
}

class _SocialCardState extends State<_SocialCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    double cardWidth;
    final w = MediaQuery.of(context).size.width;
    if (w < 400) {
      cardWidth = w - 56;
    } else if (w < 768) {
      cardWidth = (w - 68) / 2;
    } else {
      cardWidth = 220;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: cardWidth,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: _hovered ? const Color(0xFF0D1526) : AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered ? AppColors.primary.withOpacity(0.5) : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.12),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Icon(
              widget.icon,
              size: 20,
              color: _hovered ? AppColors.primary : AppColors.textDim,
            ),
            const SizedBox(height: 8),
            Text(
              widget.title,
              style: AppTheme.monoStyle.copyWith(
                color: AppColors.textDim,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.handle,
              style: AppTheme.monoStyle.copyWith(
                color: _hovered ? AppColors.textPrimary : AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Constraints helper widget
class ContactConstraints extends StatelessWidget {
  final double maxWidth;
  final Widget child;
  const ContactConstraints(
      {super.key, required this.maxWidth, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    );
  }
}
