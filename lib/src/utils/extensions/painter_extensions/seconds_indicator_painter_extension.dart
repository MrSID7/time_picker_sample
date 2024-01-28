import 'dart:ui';

import '/src/utils/constants/values.dart';
import '/src/utils/extensions/extensions.dart';
import '../../../painters/seconds_line_marker_painter.dart';

extension SecondsMarkerPainterExtensions on SecondsLineMarkerPainter {
  void paintOnEachSecondsPosition(
    Offset start, {
    required void Function(Paint, ({Offset start, Offset end})) callback,
  }) {
    Paint currentPaint = defaultPaint;
    double angle = 0 + angleAdjustmentValue;
    double nextPoint = angle;

    for (var i = 0; i < 60; i++) {
      final result = _calculateOffset(start, angle);

      if (minuteMarkInterval != null &&
          currentPaint != minuteMarkerPaint &&
          angle == nextPoint) {
        currentPaint = minuteMarkerPaint;
        nextPoint =
            angle + (minuteMarkInterval! * secondsIndicatorAngleInterval);
      } else if (currentPaint != defaultPaint) {
        currentPaint = defaultPaint;
      }

      callback(currentPaint, result);

      angle += secondsIndicatorAngleInterval;
    }
  }

  ({Offset start, Offset end}) _calculateOffset(
    Offset start,
    double angle,
  ) {
    final point1 = start.nextOffset(
      angle,
      -defSecondsPointerLength,
    );

    final point2 = point1.nextOffset(
      angle,
      length,
    );

    return (start: point1, end: point2);
  }
}
