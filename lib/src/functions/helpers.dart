/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:math';
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

/// Approximate time it takes the average reader to complete the passage
/// (reading silently to oneself)
/// Min 1 second
Duration readingTime(String passage) {
  final int words = passage.split(' ').length;
  final int milliseconds = ((words / 250) * 60 * 100).ceil();
  return Duration(milliseconds: max(milliseconds, 1000));
}
