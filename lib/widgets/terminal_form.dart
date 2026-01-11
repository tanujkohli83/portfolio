import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_theme.dart';

class TerminalContactForm extends StatelessWidget {
  const TerminalContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '// Send me a message through the terminal',
            style: AppTheme.monoStyle.copyWith(color: AppColors.textDim),
          ),
          const SizedBox(height: 32),

          // JSON Structure
          _jsonLine('"name"', 'Enter your name'),
          const SizedBox(height: 16),
          _jsonLine('"email"', 'your@email.com'),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '  "message" : "',
                style: AppTheme.monoStyle.copyWith(color: AppColors.accent),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Large Message Field
          TextField(
            maxLines: 6,
            style: AppTheme.monoStyle.copyWith(color: AppColors.textSecondary),
            decoration: InputDecoration(
              hintText: 'Type your message here...',
              hintStyle: AppTheme.monoStyle.copyWith(
                color: AppColors.textDim,
                fontSize: 13,
              ),
              filled: true,
              fillColor: Colors.black.withOpacity(0.2),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.all(20),
            ),
          ),

          const SizedBox(height: 16),
          Text(
            '  "',
            style: AppTheme.monoStyle.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: 16),
          Text(
            '}"',
            style: AppTheme.monoStyle.copyWith(color: AppColors.secondary),
          ),

          const SizedBox(height: 32),

          // Execute Send Button
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send, size: 18),
              label: const Text('Execute Send'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 22,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: AppTheme.monoStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _jsonLine(String key, String hint) {
    return Row(
      children: [
        Text(
          '  $key : ',
          style: AppTheme.monoStyle.copyWith(color: AppColors.accent),
        ),
        Expanded(
          child: TextField(
            style: AppTheme.monoStyle.copyWith(color: AppColors.textSecondary),
            decoration: InputDecoration(
              hintText: "'$hint'",
              hintStyle: AppTheme.monoStyle.copyWith(color: AppColors.textDim),
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        ),
        Text(
          ' ,',
          style: AppTheme.monoStyle.copyWith(color: AppColors.textDim),
        ),
      ],
    );
  }
}
