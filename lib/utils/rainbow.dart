import 'dart:ui';

class Rainbow {
  final List<Color> colors;
  final double threshold;

  Rainbow({required this.colors, required this.threshold}) {
    assert(colors.isNotEmpty);
  }

  Color getColor(double value) {
    for (var i = 0; i < colors.length - 1; i++) {
      final left = i * threshold;
      final right = (i + 1) * threshold;

      if (value >= left && value <= right) {
        final newValue = (value - left) / (right - left);

        return Color.lerp(colors[i], colors[i + 1], newValue)!;
      }
    }

    return colors.last;
  }
}
