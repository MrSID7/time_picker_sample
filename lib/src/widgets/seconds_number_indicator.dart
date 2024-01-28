import 'package:flutter/material.dart';

import '/src/painters/seconds_number_painter.dart';
import '/src/utils/constants/colors.dart';
import '/src/utils/constants/values.dart';
import '/src/utils/extensions/extensions.dart';

final class SecondsNumberIndicator extends StatelessWidget {
  const SecondsNumberIndicator({
    required this.textPainter,
    this.minuteMarkInterval = 10,
    this.shouldPaintSecondsAsText = true,
    this.textStyle = const TextStyle(color: kwhite, fontSize: 8),
    this.hourIndicator,
    super.key,
  });

  /// - [minuteMarkInterval]: The interval between minute marks on the clock face.
  ///   Default value is 10.
  final int minuteMarkInterval;

  ///

  /// - [textPainter]: The [TextPainter] used for painting the text on the clock face.
  ///   This is responsible for rendering the numeric values.
  final bool shouldPaintSecondsAsText;

  ///

  /// - [shouldPaintSecondsAsText]: A flag indicating whether to paint seconds as text.
  ///   Default value is true.
  final TextPainter textPainter;

  ///

  /// - [textStyle]: The style of the text being painted on the clock face.
  ///   Default value is TextStyle(color: kwhite, fontSize: 8).
  final TextStyle textStyle;

  ///

  /// - [hourIndicator]: A map indicating the hours and their corresponding values to be displayed on the clock face.
  ///   Default values are {12: '12', 3: '3', 6: '6', 9: '9'}.
  final Map<int, String>? hourIndicator;

  ///

  @override
  Widget build(BuildContext context) {
    if (!shouldPaintSecondsAsText) {
      return const SizedBox.shrink();
    }
    return TweenAnimationBuilder(
      duration: 1.sec,
      tween: Tween<double>(
        begin: 0,
        end: defSideSecIndicatorLength,
      ),
      builder: (ctx, value, _) {
        return CustomPaint(
          painter: SecondsAsTextMarkerPainter(
            textPainter: textPainter,
            textStyle: textStyle,
            minuteMarkInterval: minuteMarkInterval,
            length: value,
            hourIndicator: hourIndicator,
          ),
        );
      },
    );
  }
}
