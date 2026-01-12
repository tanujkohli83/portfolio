import 'package:flutter/material.dart';
import '../widgets/terminal_form.dart';
import '../core/constants/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/responsive.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'POST /contact',
                style: AppTheme.monoStyle.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(width: 80, height: 3, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: 60),

          // Full-width JSON Form
          const Center(
            child: Constraints(maxWidth: 900, child: TerminalContactForm()),
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
      {'title': 'GITHUB', 'handle': '@tanujkohli83'},
      {'title': 'LINKEDIN', 'handle': '/in/tanujkohli83'},
      {'title': 'TWITTER', 'handle': '@tanujkohli83'},
      {'title': 'EMAIL', 'handle': 'tanujkohli83@gmail.com'},
    ];

    return Center(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: socials
            .map((s) => _socialCard(s['title']!, s['handle']!, context))
            .toList(),
      ),
    );
  }

  Widget _socialCard(String title, String handle, BuildContext context) {
    double cardWidth = Responsive.isMobile(context)
        ? (MediaQuery.of(context).size.width - 68) / 2
        : 220;
    if (Responsive.isMobile(context) &&
        MediaQuery.of(context).size.width < 400) {
      cardWidth = MediaQuery.of(context).size.width - 48;
    }

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: AppTheme.monoStyle.copyWith(
              color: AppColors.textDim,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            handle,
            style: AppTheme.monoStyle.copyWith(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class Constraints extends StatelessWidget {
  final double maxWidth;
  final Widget child;
  const Constraints({super.key, required this.maxWidth, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    );
  }
}
