/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Returns the RGB invert of the passed color
Color invertColor(Color toInvert) {
  return Color.fromARGB(
    (toInvert.opacity * 255).round(),
    255 - toInvert.red,
    255 - toInvert.green,
    255 - toInvert.blue,
  );
}

/// Returns the guesstimated most readable text color (black/white) for [background]
Color getTextColor(Color background) {
  // Formula credit: https://stackoverflow.com/questions/3942878/how-to-decide-font-color-in-white-or-black-depending-on-background-color
  return Color((((background.red * 0.299) +
              (background.green * 0.587) +
              (background.blue * 0.114)) >=
          150)
      ? blackHex
      : whiteHex);
}

/// Returns the mathematical average of [color1] and [color2]
Color blendColors(Color color1, Color color2) {
  return Color.fromARGB(
    ((color1.opacity + color2.opacity) / 2 * 255).round(),
    ((color1.red + color2.red) / 2).round(),
    ((color1.green + color2.green) / 2).round(),
    ((color1.blue + color2.blue) / 2).round(),
  );
}
