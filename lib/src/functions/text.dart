/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Returns the soon-to-be rendered size of text via a [TextPainter]
/// [scalar] should be the value from MediaQuery.of(context).textScaleFactor
Size measureText({
  required String text,
  required double scalar,
  required TextStyle? style,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textScaleFactor: scalar,
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.size;
}

/// For web apps, set the tab's title
void setPageTitle({
  required BuildContext context,
  required String title,
}) {
  SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(label: title));
}
