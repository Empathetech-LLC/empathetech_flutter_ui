library empathetech_flutter_ui;

import 'package:flutter/material.dart';

/// Return whether the current theme is under a "Light" config
bool isLightTheme(BuildContext context) {
  Brightness? brightness = MediaQuery.maybeOf(context)?.platformBrightness;
  return (brightness == null) ? true : brightness == Brightness.light;
}

/// More readable than MediaQuery.of(context).size.width
double widthOf(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// More readable than MediaQuery.of(context).size.height
double heightOf(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// More readable than MediaQuery.of(context).size
Size sizeOf(BuildContext context) {
  return MediaQuery.of(context).size;
}
