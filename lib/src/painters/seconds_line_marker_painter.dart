import 'package:flutter/material.dart';

import '/src/utils/extensions/painter_extensions/seconds_indicator_painter_extension.dart';

final class SecondsLineMarkerPainter extends CustomPainter {
  const SecondsLineMarkerPainter(
    this.defaultPaint,
    this.minuteMarkerPaint, {
    required this.length,
    required this.minuteMarkInterval,
  });

  final Paint defaultPaint;
  final double length;
  final Paint minuteMarkerPaint;
  final int? minuteMarkInterval;

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(
      size.width / 2,
      size.height / 2,
    );

    paintOnEachSecondsPosition(
      start,
      callback: (paint, offset) {
        canvas.drawLine(
          offset.start,
          offset.end,
          paint,
        );
      },
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
