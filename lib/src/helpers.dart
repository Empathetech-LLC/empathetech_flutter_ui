library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Do you have a void [Function] as a parameter that you want to be optional?
/// Then do nothing!
void doNothing() {}

/// More readable than EzConfig.focus.primaryFocus?.unfocus()
void closeFocus() {
  EzConfig.focus.primaryFocus?.unfocus();
}

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

/// Returns the ARGB blend of the two passed [Color]s
Color blendColors(Color color1, Color color2) {
  int r = ((color1.red + color2.red) / 2).round();
  int g = ((color1.green + color2.green) / 2).round();
  int b = ((color1.blue + color2.blue) / 2).round();
  int a = ((color1.opacity + color2.opacity) / 2 * 255).round();

  return Color.fromARGB(a, r, g, b);
}

/// Returns black or white based on which should be more readable
/// for text with the passed background color
Color getContrastColor(Color background) {
  final r = background.red;
  final g = background.green;
  final b = background.blue;

  return (((r * 0.299) + (g * 0.587) + (b * 0.114)) >= 150) ? Colors.black : Colors.white;
}

/// No need to import [launchUrl] if you've already imported EFUI
Future<bool> openLink(
  Uri url, {
  LaunchMode mode = LaunchMode.platformDefault,
  WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
  String? webOnlyWindowName,
}) {
  return launchUrl(
    url,
    mode: mode,
    webViewConfiguration: webViewConfiguration,
    webOnlyWindowName: webOnlyWindowName,
  );
}

/// More readable than [Navigator] spelled out
Future<dynamic> pushScreen({
  required BuildContext context,
  required Widget screen,
}) {
  return Navigator.of(context).push(
    platformPageRoute(
      context: context,
      builder: (context) => screen,
    ),
  );
}

/// More readable than Navigator.of(context).pop()
void popScreen({
  required BuildContext context,
  dynamic pass,
}) {
  return Navigator.of(context).pop(pass);
}

/// More readable than [Navigator] spelled out
Future<dynamic> popAndPushScreen({
  required BuildContext context,
  required Widget screen,
}) {
  Navigator.of(context).pop();

  return Navigator.of(context).push(
    platformPageRoute(
      context: context,
      builder: (context) => screen,
    ),
  );
}

/// More readable than [Navigator] spelled out
Future<dynamic> replaceScreen({
  required BuildContext context,
  required Widget screen,
}) {
  return Navigator.of(context).pushReplacement(
    platformPageRoute(
      context: context,
      builder: (context) => screen,
    ),
  );
}

/// More readable than [Navigator] spelled out
void popUntilHome(BuildContext context) {
  return Navigator.of(context).popUntil(ModalRoute.withName('/'));
}
