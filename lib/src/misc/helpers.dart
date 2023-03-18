library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
Color getContrastColor(Color background) {
  final r = background.red;
  final g = background.green;
  final b = background.blue;

  return (((r * 0.299) + (g * 0.587) + (b * 0.114)) >= 150) ? Colors.black : Colors.white;
}

/// Log the passed message and display an alert dialog for the user
void popNLog(BuildContext context, String message) {
  log(message);
  ezDialog(context, 'Attention:', paddedText(message));
}
