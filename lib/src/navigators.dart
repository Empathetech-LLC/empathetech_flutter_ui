library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
