import 'package:flutter/material.dart';

import '/src/utils/extensions/extensions.dart';

final class TimePointerPainter extends CustomPainter {
  TimePointerPainter(
    this._paint, {
    required this.angle,
    required this.lineLength,
    required this.onFoundEndOffset,
  });

  final Paint _paint;
  final double angle;
  final double lineLength;
  final void Function(Offset) onFoundEndOffset;

  @override
  void paint(Canvas canvas, Size size) {
    final path1 = Offset(
      size.width / 2,
      size.height / 2,
    );

    final path2 = path1.nextOffset(
      angle,
      lineLength,
    );
    onFoundEndOffset(path2);

    canvas.drawLine(
      path1,
      path2,
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
