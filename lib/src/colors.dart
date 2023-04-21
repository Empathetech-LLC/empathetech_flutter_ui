library empathetech_flutter_ui;

import 'package:flutter/material.dart';

/// Returns the RGB invert of the passed color
Color invertColor(Color toInvert) {
  final r = 255 - toInvert.red;
  final g = 255 - toInvert.green;
  final b = 255 - toInvert.blue;

  return Color.fromARGB((toInvert.opacity * 255).round(), r, g, b);
}

/// Returns black or white based on which should be more readable
/// for text with the passed background color
Color getContrastColor(Color background) {
  final r = background.red;
  final g = background.green;
  final b = background.blue;

  return (((r * 0.299) + (g * 0.587) + (b * 0.114)) >= 150)
      ? Colors.black
      : Colors.white;
}

/// Returns the ARGB blend of the two passed [Color]s
Color blendColors(Color color1, Color color2) {
  int r = ((color1.red + color2.red) / 2).round();
  int g = ((color1.green + color2.green) / 2).round();
  int b = ((color1.blue + color2.blue) / 2).round();
  int a = ((color1.opacity + color2.opacity) / 2 * 255).round();

  return Color.fromARGB(a, r, g, b);
}
