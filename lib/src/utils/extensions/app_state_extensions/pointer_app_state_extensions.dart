part of '../../../widgets/painter_animating_widget.dart';

extension on _PointerWidgetState {
  void _onDragPointer(DragUpdateDetails details, Offset endOffset) {
    widget.onTapDown(details.localPosition, endOffset);

    final startOffset = Offset(context.width / 2, context.height / 2);
    final isSelected =
        _isPointWithinBounds(startOffset, endOffset, details.localPosition);
    if (!isSelected) {
      return;
    }

    if (currentOffset == null) {
      currentOffset = details.localPosition;
      return;
    }

    animationController?.stop();

    if (details.localPosition.isGreaterThan(currentOffset!)) {
      animationController!.addValue();
      return;
    }
    animationController!.subtractValue();
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

  void _onFoundEndOffset(Offset offset) {
    endOffset = offset;
  }
}
