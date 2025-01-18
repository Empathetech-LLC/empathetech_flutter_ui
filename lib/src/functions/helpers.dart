/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'helpers_io.dart' if (dart.library.html) 'helpers_web.dart';

// Aliases //

/// Is there a required [Function] that you wish was optional?
/// Then [doNothing]!
void doNothing() {}

/// First checks [PlatformTheme] then falls back to [MediaQuery]
bool isDarkTheme(BuildContext context) =>
    PlatformTheme.of(context)?.isDark ??
    (MediaQuery.of(context).platformBrightness == Brightness.dark);

/// More readable than FocusScope.of(context).unfocus();
void closeKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

/// More readable than MediaQuery.of(context).size.width
double widthOf(BuildContext context) => MediaQuery.of(context).size.width;

/// More readable than MediaQuery.of(context).size.height
double heightOf(BuildContext context) => MediaQuery.of(context).size.height;

/// Get the current [TargetPlatform]
/// Even when [kIsWeb]
TargetPlatform getBasePlatform(BuildContext context) =>
    getHostPlatform(context);

/// Button combo for taking a screenshot on the current (desktop) [TargetPlatform]
/// Defaults to an empty string on mobile (and unknown) platforms
String screenshotHint(BuildContext context) {
  final TargetPlatform platform = getBasePlatform(context);

  switch (platform) {
    case TargetPlatform.linux:
    case TargetPlatform.fuchsia:
    case TargetPlatform.windows:
      return ' (Alt + Print Screen)';
    case TargetPlatform.macOS:
      return ' (Command + Shift + 5)';
    default:
      return '';
  }
}

// Custom //

/// Relaxed reading time for a US tween: 100 words per minute
Duration ezReadingTime(String passage) {
  final int words = passage.split(' ').length;
  return Duration(milliseconds: ((words / 100) * 60 * 1000).ceil());
}
