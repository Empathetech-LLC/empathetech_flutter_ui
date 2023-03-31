library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// More readable than MediaQuery.of(context).size.width
double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// More readable than MediaQuery.of(context).size.height
double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// More readable than MediaQuery.of(context).size
Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

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

  return (((r * 0.299) + (g * 0.587) + (b * 0.114)) >= 150) ? Colors.black : Colors.white;
}

/// Do you have a void [Function] as a parameter that you want to be optional?
/// Then do nothing!
void doNothing() {}

/// More readable than Navigator.of(context).pop()
void popScreen(
  BuildContext context, {
  bool success = false,
}) {
  return Navigator.of(context).pop(success);
}

/// More readable than [Navigator] spelled out
void popUntilHome(
  BuildContext context, {
  bool success = false,
}) {
  return Navigator.of(context).popUntil(ModalRoute.withName(homeRoute));
}

/// More readable than [Navigator] spelled out
Future<bool> pushScreen(
  BuildContext context, {
  required Widget screen,
}) async {
  return await Navigator.of(context).push(
        platformPageRoute(
          context: context,
          builder: (context) => screen,
        ),
      ) ??
      false;
}

/// More readable than [Navigator] spelled out
Future<bool> popAndPushScreen(
  BuildContext context, {
  required Widget screen,
}) async {
  Navigator.of(context).pop();

  return await Navigator.of(context).push(
        platformPageRoute(
          context: context,
          builder: (context) => screen,
        ),
      ) ??
      false;
}

/// More readable than [Navigator] spelled out
Future<bool> replaceScreen(
  BuildContext context, {
  required Widget screen,
}) async {
  return await Navigator.of(context).pushReplacement(
        platformPageRoute(
          context: context,
          builder: (context) => screen,
        ),
      ) ??
      false;
}
