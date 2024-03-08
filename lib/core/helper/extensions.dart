extension DoubleExtension on double {
  String toPercentText() {
    return "${(this * 100).toInt()}%";
  }
}
