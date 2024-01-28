import 'dart:math' as math;

import 'package:flutter/material.dart';

import '/src/painters/time_pointer_painter.dart';
import '/src/utils/constants/values.dart';
import '/src/utils/enum.dart';
import '/src/utils/extensions/animation_controller_extension.dart';
import '/src/utils/extensions/extensions.dart';

part '../utils/extensions/app_state_extensions/pointer_app_state_extensions.dart';

final class PointerWidget extends StatefulWidget {
  const PointerWidget._(
    this._paint, {
    required this.pointerType,
    required this.lineLength,
    required this.onTapDown,
  });

  factory PointerWidget.hour(
    Paint paint,
    final void Function(Offset, Offset) onTapDown,
  ) {
    return PointerWidget._(
      paint,
      pointerType: PointerType.hrs,
      lineLength: defHoursPointerLength,
      onTapDown: onTapDown,
    );
  }

  factory PointerWidget.minute(
    Paint paint,
    final void Function(Offset, Offset) onTapDown,
  ) {
    return PointerWidget._(
      paint,
      pointerType: PointerType.min,
      lineLength: defMinutesPointerLength,
      onTapDown: onTapDown,
    );
  }

  factory PointerWidget.second(
    Paint paint,
    final void Function(Offset, Offset) onTapDown,
  ) {
    return PointerWidget._(
      paint,
      pointerType: PointerType.sec,
      lineLength: defSecondsPointerLength,
      onTapDown: onTapDown,
    );
  }

  final PointerType pointerType;
  final double lineLength;
  final Paint _paint;
  final void Function(Offset, Offset) onTapDown;

  @override
  State<PointerWidget> createState() => _PointerWidgetState();
}

final class _PointerWidgetState extends State<PointerWidget>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Offset? currentOffset;
  Offset endOffset = Offset.zero;

  @override
  void initState() {
    initAnimationController();

    animationController
      ?..forward(from: _angle)
      ..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: 600.mil,
      curve: Curves.easeInOut,
      tween: Tween<double>(begin: 0, end: widget.lineLength),
      builder: (ctx, length, _) {
        return AnimatedBuilder(
          animation: animationController!,
          builder: (context, child) {
            return GestureDetector(
              onPanUpdate: (details) => _onDragPointer(details, endOffset),
              child: CustomPaint(
                size: Size(
                  context.width,
                  context.height,
                ),
                painter: TimePointerPainter(
                  widget._paint,
                  onFoundEndOffset: _onFoundEndOffset,
                  angle: animationController!.value,
                  lineLength: length,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void initAnimationController() {
    animationController = AnimationController(
      vsync: this,
      duration: _duration,
      animationBehavior: AnimationBehavior.preserve,
      upperBound: defDeg,
    );
  }

  DateTime get _time => DateTime.now();

  Duration get _duration {
    switch (widget.pointerType) {
      case PointerType.sec:
        return secsInAMins.sec;
      case PointerType.min:
        return minsInAHrs.min;
      case PointerType.hrs:
        return (hrsInADay ~/ 2).hrs;
    }
  }

  double get _angle {
    switch (widget.pointerType) {
      case PointerType.sec:
        return _time.secondsToAngle;
      case PointerType.min:
        return _time.minutesToAngle;
      case PointerType.hrs:
        return _time.hoursToAngle;
    }
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }
}
