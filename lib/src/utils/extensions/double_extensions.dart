extension DoubleExtensions on double {
  int get toHour {
    return normalizeValue(
      this,
      0,
      360,
      0,
      12,
      valueInsteadOf0: 12,
    );
  }

  int normalizeValue(
    double originalValue,
    double originalMin,
    double originalMax,
    double newMin,
    double newMax, {
    double adjustmentValue = 90,
    int valueInsteadOf0 = 0,
  }) {
    originalValue = (originalValue + adjustmentValue) - 180;
    double normalizedValue =
        (originalValue - originalMin) / (originalMax - originalMin);

    double mappedValue = normalizedValue * (newMax - newMin) + newMin;
    final result = ((mappedValue - adjustmentValue) % newMax).toInt();

    return result < 1 ? valueInsteadOf0 : result;
  }
}
