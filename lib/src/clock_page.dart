import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '/src/utils/extensions/extensions.dart';
import 'utils/constants/colors.dart';
import 'widgets/painter_animating_widget.dart';
import 'widgets/seconds_line_indicator_widget.dart';
import 'widgets/seconds_number_indicator.dart';

part 'utils/extensions/app_state_extensions/clock_page_state_extensions.dart';

final class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

final class _ClockPageState extends State<ClockPage> {
  final _secondsIndicatorPaint = Paint()..color = kGrey;
  final _secondsPointerPaint = Paint()
    ..color = kwhite
    ..strokeWidth = 3
    ..strokeCap = StrokeCap.round;
  final _minutesPointerPaint = Paint()
    ..color = kGrey
    ..strokeWidth = 3
    ..strokeCap = StrokeCap.round;
  final _hoursPointerPaint = Paint()
    ..color = kRed
    ..strokeWidth = 3
    ..strokeCap = StrokeCap.round;
  final _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  final _minuteMarkerPaint = Paint()
    ..color = kwhite
    ..strokeWidth = 1.2;

  List<PointerWidget> pointerPainters = [];

  @override
  void initState() {
    pointerPainters = pointerWidgets;
    super.initState();
  }

  @override
  void dispose() {
    pointerPainters.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kBlack,
        body: SizedBox(
          height: context.height,
          width: context.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SecondsLineIndicatorWidget(
                _secondsIndicatorPaint,
                _minuteMarkerPaint,
              ),
              SecondsNumberIndicator(
                textPainter: _textPainter,
              ),
              ...pointerPainters
            ],
          ),
        ),
      ),
    );
  }
}
