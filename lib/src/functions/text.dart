/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Returns whether the passed [text] follows a URL pattern
bool isUrl(String text) {
  return Uri.parse(text).host.isNotEmpty;
}

/// Returns the soon-to-be rendered size of text via a [TextPainter]
/// [scaler] should be the value from MediaQuery.textScalerOf(context)
Size measureText(
  text, {
  required TextScaler scaler,
  required TextStyle? style,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textScaler: scaler,
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.size;
}

/// For web apps, set the tab's title
void setPageTitle(
  BuildContext context,
  String title,
) {
  SystemChrome.setApplicationSwitcherDescription(
    ApplicationSwitcherDescription(label: title),
  );
}
