import 'package:flutter/material.dart';
import '../widgets/code_editor_card.dart';
import '../core/utils/responsive.dart';

class HeroSection extends StatelessWidget {
  final double scrollOffset;

  const HeroSection({super.key, this.scrollOffset = 0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Parallax background glow blobs
        Positioned.fill(
          child: Transform.translate(
            offset: Offset(0, scrollOffset * -0.3),
            child: CustomPaint(painter: _GlowBlobPainter()),
          ),
        ),
        // Main content
        Container(
          padding: EdgeInsets.symmetric(
            vertical: Responsive.isMobile(context) ? 60 : 100,
            horizontal: 28,
          ),
          alignment: Alignment.center,
          child: const CodeEditorCard(),
        ),
      ],
    );
  }
}

class _GlowBlobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFF3B82F6).withOpacity(0.06)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);
    canvas.drawCircle(
        Offset(size.width * 0.15, size.height * 0.3), 200, paint1);

    final paint2 = Paint()
      ..color = const Color(0xFF6366F1).withOpacity(0.05)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
    canvas.drawCircle(
        Offset(size.width * 0.85, size.height * 0.6), 220, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
