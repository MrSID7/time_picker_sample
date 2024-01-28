import 'package:flutter/animation.dart';

extension AnimationControllerExtensions on AnimationController {
  void addValue() {
    if (value > 359) {
      value = 0;
      return;
    }
    value++;
  }

  void subtractValue() {
    if (value < 1) {
      value = 360;
      return;
    }
    value--;
  }
}
