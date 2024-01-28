import 'dart:math' as math;

import 'package:flutter/material.dart';

import '/src/utils/constants/values.dart';

//------------------//
extension OffsetExtensions on Offset {
  Offset nextOffset(double angleDegrees, double distance) {
    double angleRadians = (angleDegrees) * (math.pi / 180.0);

    double offsetX = distance * math.cos(angleRadians);
    double offsetY = distance * math.sin(angleRadians);

    return Offset(offsetX + dx, offsetY + dy);
  }

  Offset subtract(double value) {
    return Offset(dx - value, dy - value);
  }

  Offset add(double value) {
    return Offset(dx + value, dy + value);
  }

  bool isGreaterThan(Offset other) {
    return (dx * other.dy - dy * other.dx) < 0;
  }
}
//------------------//

//------------------//
extension DateTimeExtension on DateTime {
  int get _hourIn12HrsFormat => hour % 12;

  double get secondsToAngle =>
      _mapValueToRange(second, 0, secsInAMins, 0, defDeg);

  double get minutesToAngle {
    return _mapValueToRange(minute, 0, minsInAHrs, 0, defDeg) + second / 10;
  }

  double get hoursToAngle =>
      _mapValueToRange(_hourIn12HrsFormat, 0, hrsInADay ~/ 2, 0, defDeg) +
      (minute ~/ 10 * secondsIndicatorAngleInterval);

  double _mapValueToRange(
    int value,
    int inputMin,
    int inputMax,
    double outputMin,
    double outputMax, [
    double adjustment = angleAdjustmentValue,
  ]) {
    int clampedValue = value.clamp(inputMin, inputMax);

    final angle = (outputMin +
            (outputMax - outputMin) *
                (clampedValue - inputMin) /
                (inputMax - inputMin)) -
        adjustment;

    return angle % defDeg;
  }
}
//------------------//

//------------------//
extension BuildContextExtensions on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get width => screenSize.width;
  double get height => screenSize.height;
}
//------------------//

//------------------//
extension DurationExtensions on int {
  Duration get sec => Duration(seconds: this);
  Duration get min => Duration(minutes: this);
  Duration get hrs => Duration(hours: this);
  Duration get mil => Duration(milliseconds: this);
}
//------------------//
