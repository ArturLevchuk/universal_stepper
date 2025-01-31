import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  final Color color;
  final double radius;
  final double spacing;

  const DottedLinePainter({
    this.color = Colors.black,
    this.radius = 2.0,
    this.spacing = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final centerY = size.height / 2;
    final step = 2 * radius + spacing;
    final count = ((size.width - 2 * radius) / step).floor() + 1;

    for (var i = 0; i < count; i++) {
      final x = radius + i * step;
      canvas.drawCircle(Offset(x, centerY), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
