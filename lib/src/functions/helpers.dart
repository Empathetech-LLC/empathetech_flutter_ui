/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Do you have a void [Function] as a parameter that you want to be optional?
/// Then do nothing!
void doNothing() {}

/// First checks [PlatformTheme] then falls back to [MediaQuery]
bool isDarkTheme(BuildContext context) {
  return PlatformTheme.of(context)?.isDark ??
      (MediaQuery.of(context).platformBrightness == Brightness.dark);
}

/// More readable than FocusScope.of(context).unfocus();
void closeKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

/// More readable than MediaQuery.of(context).size.width
double widthOf(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// More readable than MediaQuery.of(context).size.height
double heightOf(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// Reading time for a US tween: 125 words per minute
Duration readingTime(String passage) {
  final int words = passage.split(' ').length;
  debugPrint('Reading time: $words words');
  return Duration(milliseconds: ((words / 125) * 60 * 1000).ceil());
}

/// Calculates [SnackBar.width] based on [message] and [context]
/// [style] defaults to [SnackBarThemeData.contentTextStyle]
double snackWidth({
  required BuildContext context,
  required String message,
  TextStyle? style,
}) {
  final TextStyle? snackStyle =
      style ?? Theme.of(context).snackBarTheme.contentTextStyle;

  final double iconRadius =
      measureIcon(Icons.circle, context: context, style: snackStyle).width;

  return measureText(message, context: context, style: snackStyle).width +
      iconRadius * 2 +
      3 * EzConfig.get(marginKey);
}
