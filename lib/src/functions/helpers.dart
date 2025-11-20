/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
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

/// Where to find saved files on the current [TargetPlatform]
String archivePath({required String? androidPackage, required String appName}) {
  final TargetPlatform platform = getBasePlatform();

  switch (platform) {
    case TargetPlatform.android:
      return 'Root > Android > Data > ${androidPackage ?? 'com.example.app'} > files';
    case TargetPlatform.iOS:
      return 'Files > Browse > $appName';
    default:
      return 'Downloads';
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

/// Returns the [Directionality] of the current [BuildContext]
/// Falls back to [rtlLanguageCodes] on context errors
bool isLTR(BuildContext context) {
  try {
    return Directionality.of(context) == TextDirection.ltr;
  } catch (_) {
    final Locale locale = WidgetsBinding.instance.platformDispatcher.locale;
    return !rtlLanguageCodes.contains(locale.languageCode);
  }
}

/// [Duration] with milliseconds set to [EzConfig]s [animationDurationKey]
/// Provide [mod] to adjust the duration, relative to the base value
Duration ezAnimDuration({double mod = 1.0}) => Duration(
    milliseconds: ((EzConfig.get(animationDurationKey) as int) * mod).toInt());

/// A [GoTransition] based on the current platform and [EzConfig] setup
Page<dynamic> ezGoTransition(
  BuildContext context,
  GoRouterState state,
  int animDuration,
  TargetPlatform platform,
) {
  if (animDuration < 1) return GoTransitions.none(context, state);

  switch (platform) {
    case TargetPlatform.android:
      return GoTransitions.zoom(context, state);
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return GoTransitions.cupertino(context, state);
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return GoTransitions.slide.withFade(context, state);
  }
}

/// [TargetPlatform] aware helper that will request/exit a fullscreen window
Future<void> ezFullscreenToggle(TargetPlatform platform, bool isFull) =>
    toggleFullscreen(platform, isFull);

/// Recommended size for an image
/// Starts with 160.0; chosen by visual inspection
/// Then, applies [MediaQuery] text scaling and [EzConfig] icon scaling
double ezImageSize(BuildContext context) =>
    MediaQuery.textScalerOf(context).scale(160.0) *
    (EzConfig.get(iconSizeKey) / EzConfig.getDefault(iconSizeKey));

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
  late final double iconSize = EzConfig.get(iconSizeKey);

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
