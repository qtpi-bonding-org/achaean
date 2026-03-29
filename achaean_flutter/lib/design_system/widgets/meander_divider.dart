import 'package:flutter/material.dart';
import '../primitives/app_sizes.dart';
import '../theme/app_theme.dart';

/// Greek key (meander) pattern divider — the decorative content separator.
///
/// Renders a repeating meander pattern between two horizontal rules.
/// Use for major section breaks. Use [StoneDivider] for minor separators.
class MeanderDivider extends StatelessWidget {
  final double? verticalPadding;
  final double? indent;

  const MeanderDivider({super.key, this.verticalPadding, this.indent});

  @override
  Widget build(BuildContext context) {
    final vPad = verticalPadding ?? AppSizes.space;
    final hIndent = indent ?? 0.0;
    final color = context.ornamentColor;
    final ruleWidth = AppSizes.borderWidth;
    final patternHeight = AppSizes.space * 1.2;
    final gap = AppSizes.space * 0.25;
    final totalHeight = ruleWidth + gap + patternHeight + gap + ruleWidth;

    return ExcludeSemantics(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: vPad, horizontal: hIndent),
        child: SizedBox(
          height: totalHeight,
          width: double.infinity,
          child: CustomPaint(
            painter: _MeanderPainter(
              color: color,
              ruleWidth: ruleWidth,
              patternHeight: patternHeight,
              gap: gap,
            ),
          ),
        ),
      ),
    );
  }
}

class _MeanderPainter extends CustomPainter {
  final Color color;
  final double ruleWidth;
  final double patternHeight;
  final double gap;

  const _MeanderPainter({
    required this.color,
    required this.ruleWidth,
    required this.patternHeight,
    required this.gap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rulePaint = Paint()
      ..color = color
      ..strokeWidth = ruleWidth
      ..style = PaintingStyle.stroke;

    // Top rule
    final topY = ruleWidth / 2;
    canvas.drawLine(Offset(0, topY), Offset(size.width, topY), rulePaint);

    // Bottom rule
    final bottomY = ruleWidth + gap + patternHeight + gap + ruleWidth / 2;
    canvas.drawLine(Offset(0, bottomY), Offset(size.width, bottomY), rulePaint);

    // Meander pattern between rules
    final patternPaint = Paint()
      ..color = color
      ..strokeWidth = ruleWidth * 0.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final pTop = ruleWidth + gap;
    final pH = patternHeight;
    final unitW = pH * 2;
    final steps = (size.width / unitW).ceil() + 1;

    final path = Path();
    for (var i = 0; i < steps; i++) {
      final x = i * unitW;
      // Greek key unit
      path.moveTo(x, pTop + pH);
      path.lineTo(x, pTop);
      path.lineTo(x + unitW * 0.5, pTop);
      path.lineTo(x + unitW * 0.5, pTop + pH * 0.5);
      path.lineTo(x + unitW * 0.25, pTop + pH * 0.5);
      path.lineTo(x + unitW * 0.25, pTop + pH);
      path.lineTo(x + unitW, pTop + pH);
    }

    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, pTop, size.width, pH));
    canvas.drawPath(path, patternPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_MeanderPainter oldDelegate) =>
      color != oldDelegate.color ||
      ruleWidth != oldDelegate.ruleWidth ||
      patternHeight != oldDelegate.patternHeight ||
      gap != oldDelegate.gap;
}
