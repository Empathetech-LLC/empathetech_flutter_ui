/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Alias for [Navigator.pop]
void popScreen({
  required BuildContext context,
  dynamic result,
}) {
  return Navigator.of(context).pop(result);
}

/// More readable than [Navigator.push] spelled out
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

/// More readable than [Navigator.pop] && [Navigator.push] spelled out
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

/// More readable than [Navigator.pushReplacement] spelled out
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
/// Runs [Navigator.popUntil] the [ModalRoute] named [homeRoute]
void popUntilHome(BuildContext context) {
  return Navigator.of(context).popUntil(ModalRoute.withName(homeRoute));
}
