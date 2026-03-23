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
        _showSuccessDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send message. Please try again later.'),
          ),
        );
      }
    }
  }

  void _showSuccessDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.55),
      builder: (context) => const _SuccessSentDialog(),
    );
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
              icon: const Icon(Icons.send, size: 18),
              label: Text(
                _isSending ? 'Message is on the way...' : 'Execute Send',
              ),
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

class _SuccessSentDialog extends StatefulWidget {
  const _SuccessSentDialog();

  @override
  State<_SuccessSentDialog> createState() => _SuccessSentDialogState();
}

class _SuccessSentDialogState extends State<_SuccessSentDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _gradientController;

  @override
  void initState() {
    super.initState();
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    Future<void>.delayed(const Duration(milliseconds: 2500), () {
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 520 ? screenWidth * 0.84 : 380.0;
    final dialogHeight = screenWidth < 520 ? 108.0 : 114.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
        child: SizedBox(
          width: dialogWidth,
          height: dialogHeight,
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _gradientController,
                  builder: (context, child) {
                    final t = _gradientController.value;
                    final shift = -1.0 + (t * 2.0);

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          begin: Alignment(-1.0 + shift, -1.0),
                          end: Alignment(1.0 + shift, 1.0),
                          colors: const [
                            AppColors.primary,
                            AppColors.secondary,
                            AppColors.accent,
                            AppColors.primary,
                          ],
                          stops: const [0.0, 0.35, 0.7, 1.0],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(2.4),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          size: 28,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Message sent successfully!',
                          textAlign: TextAlign.center,
                          style: AppTheme.monoStyle.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
