extension DoubleUtils on double {
  String get asString => toStringAsFixed(truncateToDouble() == this ? 0 : 2);
}
