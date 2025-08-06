/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'helpers_io.dart' if (dart.library.html) 'helpers_web.dart';

//* Aliases *//

// Platform checks //

/// Alias exists for [kIsWeb] support
bool isApple() => cupertinoCheck();

/// Alias exists for [kIsWeb] support
bool isMobile() => mobileCheck();

/// Alias exists for [kIsWeb] support
/// [isMobile] is preferred; technically more efficient
bool isDesktop() => desktopCheck();

/// Get the current [TargetPlatform]; "slow" but reliable
/// Alias exists for [kIsWeb] support
TargetPlatform getBasePlatform() => getHostPlatform();

/// First checks [PlatformTheme] then falls back to [MediaQuery]
bool isDarkTheme(BuildContext context) =>
    PlatformTheme.of(context)?.isDark ??
    (MediaQuery.of(context).platformBrightness == Brightness.dark);

/// Button combo for taking a screenshot on the current (desktop) [TargetPlatform]
/// Defaults to an empty string on mobile (and unknown) platforms
String screenshotHint() {
  final TargetPlatform platform = getBasePlatform();

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

// Readability //

/// Is there a required [Function] that you wish was optional?
/// Then [doNothing]!
void doNothing() {}

/// More readable than...
/// MediaQuery.of(context).size.width
double widthOf(BuildContext context) => MediaQuery.of(context).size.width;

/// More readable than...
/// MediaQuery.of(context).size.height
double heightOf(BuildContext context) => MediaQuery.of(context).size.height;

/// More readable than...
/// FocusScope.of(context).unfocus();
void closeKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

/// More readable than...
/// EFUILang.of(context) ?? EzConfig.l10nFallback
EFUILang ezL10n(BuildContext context) =>
    EFUILang.of(context) ?? EzConfig.l10nFallback;

// Custom //

/// Relaxed reading time for a US tween: 100 words per minute
Duration ezReadingTime(String passage) {
  final int words = passage.split(' ').length;
  return Duration(milliseconds: ((words / 100) * 60 * 1000).ceil());
}

/// Recommended size for an image
/// Starts with 160.0; chosen by visual inspection
/// Then, applies [MediaQuery] text scaling and [EzConfig] icon scaling
double ezImageSize(BuildContext context) =>
    MediaQuery.textScalerOf(context).scale(160.0) *
    ((EzConfig.get(iconSizeKey) ?? defaultIconSize) / defaultIconSize);

/// Calculate a recommended [AppBar.toolbarHeight]
/// max([ezTextSize] + 2 * [EzConfig.get]marginKey, [kMinInteractiveDimension])
double ezToolbarHeight({
  required BuildContext context,
  required String title,
  bool includeIconButton = true,
  TextStyle? style,
}) {
  late final double margin = EzConfig.get(marginKey);
  late final double padding = EzConfig.get(paddingKey);
  late final double iconSize = EzConfig.get(iconSizeKey) ?? defaultIconSize;

  return max(
        ezTextSize(
          title,
          context: context,
          style: style ?? Theme.of(context).appBarTheme.titleTextStyle,
        ).height,
        includeIconButton
            ? max(iconSize + padding, kMinInteractiveDimension)
            : kMinInteractiveDimension,
      ) +
      margin;
}
