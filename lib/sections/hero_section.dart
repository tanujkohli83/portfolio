import 'package:flutter/material.dart';
import '../widgets/code_editor_card.dart';
import '../core/utils/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.isMobile(context) ? 40 : 80,
        horizontal: 24,
      ),
      alignment: Alignment.center,
      child: const CodeEditorCard(),
    );
  }
}
