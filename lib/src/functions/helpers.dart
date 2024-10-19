/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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

/// Get the current [TargetPlatform]
/// Including the base platform when [kIsWeb]
TargetPlatform getBasePlatform(BuildContext context) {
  if (!kIsWeb) return Theme.of(context).platform;

  final String userAgent = html.window.navigator.userAgent;

  if (userAgent.contains('Android')) {
    return TargetPlatform.android;
  } else if (userAgent.contains('iPhone') || userAgent.contains('iPad')) {
    return TargetPlatform.iOS;
  } else if (userAgent.contains('Mac OS')) {
    return TargetPlatform.macOS;
  } else if (userAgent.contains('Windows')) {
    return TargetPlatform.windows;
  } else {
    return TargetPlatform.linux;
  }
}

/// Button combo(s) for taking a screenshot on the current [TargetPlatform]
/// Empty for mobile
String screenshotHint(BuildContext context) {
  final TargetPlatform platform = getBasePlatform(context);

  switch (platform) {
    case TargetPlatform.linux:
    case TargetPlatform.fuchsia:
    case TargetPlatform.windows:
      return '(Alt + Print Screen)';
    case TargetPlatform.macOS:
      return '(Command + Shift + 4)';
    default:
      return '';
  }
}
