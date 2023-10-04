/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
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

/// Alias for Navigator.of(context).pop()
void popScreen({
  required BuildContext context,
  dynamic pass,
}) {
  return Navigator.of(context).pop(pass);
}

/// More readable than [Navigator] function spelled out
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

/// More readable than [Navigator] function spelled out
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

/// More readable than [Navigator] function spelled out
/// Runs pop until '/' route
void popUntilHome(BuildContext context) {
  return Navigator.of(context).popUntil(ModalRoute.withName(homeRoute));
}
