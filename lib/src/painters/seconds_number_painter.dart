import 'dart:collection';

import 'package:flutter/widgets.dart';

import '/src/utils/constants/values.dart';
import '/src/utils/extensions/double_extensions.dart';
import '/src/utils/extensions/extensions.dart';

final class SecondsAsTextMarkerPainter extends CustomPainter {
  const SecondsAsTextMarkerPainter({
    required this.length,
    required this.textPainter,
    required this.minuteMarkInterval,
    required this.textStyle,
    this.hourIndicator,
    this.width = 30,
  });

  final double length;
  final int? minuteMarkInterval;
  final TextStyle textStyle;
  final TextPainter textPainter;
  final Map<int, String>? hourIndicator;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(
      size.width / 2,
      size.height / 2,
    );

    final sorted = SplayTreeMap<int, String>.from(
        hourIndicator ?? defaultHourIndicatorReference, (a, b) {
      return a.compareTo(b);
    });

    for (double angle = 0; angle < 360; angle += 30) {
      final hr = (angle - 180).toHour;

      final value = sorted[hr];

      if (value == null) {
        continue;
      }

      final span = TextSpan(
        style: textStyle,
        text: value,
      );

      textPainter.text = span;

      final offset = start.nextOffset(
        angle,
        -defSecondsPointerLength + width,
      );

      textPainter.layout();
      textPainter.paint(canvas, offset.subtract(4));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
