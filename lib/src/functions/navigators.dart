/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

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
      builder: (BuildContext context) => screen,
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
      builder: (BuildContext context) => screen,
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
      builder: (BuildContext context) => screen,
    ),
  );
}

/// More readable than [Navigator.popUntil] and [Navigator.push] spelled out
Future<dynamic> clearStackAndPush({
  required BuildContext context,
  required Widget screen,
}) {
  Navigator.of(context).popUntil((Route<dynamic> route) => false);

  return Navigator.of(context).push(
    platformPageRoute(
      context: context,
      builder: (BuildContext context) => screen,
    ),
  );
}
