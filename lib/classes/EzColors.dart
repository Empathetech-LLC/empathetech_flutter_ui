/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

part of empathetech_flutter_ui;

class EzInvertedColor extends Color {
  final Color toInvert;

  /// Returns the RGB invert of the passed color
  EzInvertedColor(this.toInvert)
      : super.fromARGB(
          (toInvert.opacity * 255).round(),
          255 - toInvert.red,
          255 - toInvert.green,
          255 - toInvert.blue,
        );
}

class EzContrastColor extends Color {
  final Color background;

  /// Returns the guesstimated most readable text color (black/white) for [background]
  /// Formula credit: https://stackoverflow.com/questions/3942878/how-to-decide-font-color-in-white-or-black-depending-on-background-color
  EzContrastColor(this.background)
      : super((((background.red * 0.299) +
                    (background.green * 0.587) +
                    (background.blue * 0.114)) >=
                150)
            ? blackHex
            : whiteHex);
}

class EzColorBlend extends Color {
  final Color color1;
  final Color color2;

  /// Returns the RGB invert of the passed color
  EzColorBlend(this.color1, this.color2)
      : super.fromARGB(
          ((color1.opacity + color2.opacity) / 2 * 255).round(),
          ((color1.red + color2.red) / 2).round(),
          ((color1.green + color2.green) / 2).round(),
          ((color1.blue + color2.blue) / 2).round(),
        );
}
