library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Return whether the current theme is under a "Light" config
bool isLightTheme() {
  var brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;
  return brightness == Brightness.light;
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
