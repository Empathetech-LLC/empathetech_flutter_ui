library ez_ui;

import 'package:ez_ui/src/text.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

// Get screen width
double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

// Get screen height
double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

// Get the opposite of the passed color
Color invertColor(Color toInvert) {
  final r = 255 - toInvert.red;
  final g = 255 - toInvert.green;
  final b = 255 - toInvert.blue;

  return Color.fromARGB((toInvert.opacity * 255).round(), r, g, b);
}

// Returns whether text with a background of the passed color should be black or white
Color getContrastPlatformText(Color background) {
  final r = background.red;
  final g = background.green;
  final b = background.blue;

  return (((r * 0.299) + (g * 0.587) + (b * 0.114)) >= 150) ? Colors.black : Colors.white;
}

// Log the passed message and display a snack bar/pop up for the user
void popNLog(BuildContext context, String message, [int seconds = 3]) {
  TextStyle style = getTextStyle(dialogContentStyleKey);

  log(message);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: seconds),
      content: PlatformText(message, style: style, textAlign: TextAlign.center),
    ),
  );
}
