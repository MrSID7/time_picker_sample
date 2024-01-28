part of '../../../clock_page.dart';

extension on _ClockPageState {
  List<PointerWidget> get pointerWidgets => [
        PointerWidget.hour(
          _hoursPointerPaint,
          onDrage,
        ),
        PointerWidget.minute(
          _minutesPointerPaint,
          onDrage,
        ),
        PointerWidget.second(
          _secondsPointerPaint,
          onDrage,
        ),
      ];

  void onDrage(Offset selectedPoint, Offset endOffset) {
    
    log('dragging');
  }

  bool _isPointWithinBounds(
    Offset offset1,
    Offset offset2,
    Offset tappedPosition, [
    double adjustmentValue = 0,
  ]) {
    double minX = math.min(offset1.dx, offset2.dx) - adjustmentValue;
    double maxX = math.max(offset1.dx, offset2.dx) - adjustmentValue;
    double minY = math.min(offset1.dy, offset2.dy) - adjustmentValue;
    double maxY = math.max(offset1.dy, offset2.dy) - adjustmentValue;

    return tappedPosition.dx >= minX &&
        tappedPosition.dx <= maxX &&
        tappedPosition.dy >= minY &&
        tappedPosition.dy <= maxY;
  }
}
