import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../services/contact_service.dart';

import '../../core/utils/responsive.dart';

class TerminalContactForm extends StatefulWidget {
  const TerminalContactForm({super.key});

  @override
  State<TerminalContactForm> createState() => _TerminalContactFormState();
}

class _TerminalContactFormState extends State<TerminalContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    setState(() => _isSending = true);

    final success = await ContactService.submitContactForm(
      name: name,
      email: email,
      message: message,
    );

    if (mounted) {
      setState(() => _isSending = false);
      if (success) {
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message sent successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send message. Please try again later.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 24 : 40),
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
          _jsonLine('"name"', 'Enter your name', _nameController),
          const SizedBox(height: 16),
          _jsonLine('"email"', 'your@email.com', _emailController),
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
            controller: _messageController,
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
              onPressed: _isSending ? null : _handleSend,
              icon: _isSending
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.send, size: 18),
              label: Text(_isSending ? 'Sending...' : 'Execute Send'),
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

  Widget _jsonLine(String key, String hint, TextEditingController controller) {
    return Row(
      children: [
        Text(
          '  $key : ',
          style: AppTheme.monoStyle.copyWith(color: AppColors.accent),
        ),
        Expanded(
          child: TextField(
            controller: controller,
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
