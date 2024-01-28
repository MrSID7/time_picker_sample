import 'package:flutter/material.dart';

import '/src/painters/seconds_line_marker_painter.dart';
import '/src/utils/constants/values.dart';
import '/src/utils/extensions/extensions.dart';

class SecondsLineIndicatorWidget extends StatelessWidget {
  const SecondsLineIndicatorWidget(
    this._secondsPointerPaint,
    this._minuteMarkerPaint, {
    this.minuteMarkInterval = 5,
    this.shouldPaintTextasSeconds = true,
    super.key,
  });

  final Paint _secondsPointerPaint;
  final Paint _minuteMarkerPaint;
  final int? minuteMarkInterval;
  final bool shouldPaintTextasSeconds;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: 1.sec,
      tween: Tween<double>(
        begin: 0,
        end: defSideSecIndicatorLength,
      ),
      builder: (ctx, value, _) {
        return CustomPaint(
          painter: SecondsLineMarkerPainter(
            _secondsPointerPaint,
            _minuteMarkerPaint,
            minuteMarkInterval: minuteMarkInterval,
            length: value,
          ),
        );
      },
    );
  }
}
