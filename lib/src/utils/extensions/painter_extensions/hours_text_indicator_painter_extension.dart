import 'dart:ui';

import '/src/painters/seconds_number_painter.dart';
import '/src/utils/constants/values.dart';
import '/src/utils/extensions/extensions.dart';

extension SecondsTextMarkerExtensions on SecondsAsTextMarkerPainter {
  ({Offset start, Offset end}) calculateOffset(
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
