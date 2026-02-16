/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'helpers_io.dart' if (dart.library.html) 'helpers_web.dart';

//* Aliases *//

// Platform checks //

/// Where to find saved files on the current [TargetPlatform]
String archivePath({required String? androidPackage, required String appName}) {
  switch (EzConfig.platform) {
    case TargetPlatform.android:
      return 'Root > Android > Data > ${androidPackage ?? 'com.example.app'} > files';
    case TargetPlatform.iOS:
      return 'Files > Browse > $appName';
    default:
      return 'Downloads';
  }
}

/// Get the current [TargetPlatform]; "slow" but reliable
/// Alias exists for [kIsWeb] support
TargetPlatform getBasePlatform() => getHostPlatform();

/// Alias for [MediaQuery] brightness check
bool isDarkTheme(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;

/// Alias exists for [kIsWeb] support
bool isMobile() => mobileCheck();

/// [SafeArea] top padding
double safeTop(BuildContext context) => MediaQuery.of(context).padding.top;

/// [SafeArea] bottom padding
double safeBottom(BuildContext context) =>
    MediaQuery.of(context).padding.bottom;

/// Button combo for taking a screenshot on the current (desktop) [TargetPlatform]
/// Defaults to an empty string on mobile (and unknown) platforms
String screenshotHint() {
  switch (EzConfig.platform) {
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

/// More readable than...
/// FocusScope.of(context).unfocus();
void closeKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

/// Is there a required [Function] that you wish was optional?
/// Then [doNothing]!
void doNothing() {}

/// More readable than...
/// MediaQuery.of(context).size.height
double heightOf(BuildContext context) => MediaQuery.of(context).size.height;

/// More readable than...
/// MediaQuery.of(context).size.width
double widthOf(BuildContext context) => MediaQuery.of(context).size.width;

//* Custom functions *//

/// [Duration] with milliseconds set to [EzConfig.animDur]
/// Provide [mod] to adjust the duration, relative to the base value
Duration ezAnimDuration({double mod = 1.0}) =>
    Duration(milliseconds: (EzConfig.animDur * mod).toInt());

Future<void> ezConfigLoader(BuildContext context) async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: <String>['json'],
  );

  try {
    if (result != null && result.files.single.path != null) {
      if (kIsWeb) {
        final Uint8List? fileBytes = result.files.first.bytes;
        if (fileBytes == null) throw 'null file';

        final String fileContent = utf8.decode(fileBytes);
        await EzConfig.loadConfig(jsonDecode(fileContent));
      } else {
        final String filePath = result.files.single.path!;
        final String fileContent = await File(filePath).readAsString();

        await EzConfig.loadConfig(jsonDecode(fileContent));
      }
    }
  } catch (e) {
    if (context.mounted) await ezLogAlert(context, message: e.toString());
    return;
  }

  if (context.mounted) {
    ezSnackBar(
      context: context,
      message: kIsWeb
          ? EzConfig.l10n.ssRestartReminderWeb
          : EzConfig.l10n.ssRestartReminder,
    );
  }
}

/// Close any open modals or dialogs
/// Automatically consumed by [EzConfig.redrawUI]
void ezCloseAll() {
  final NavigatorState? state = ezRootNav.currentState;
  if (state == null) return;

  if (state.canPop()) {
    state.popUntil((Route<dynamic> route) => route is PageRoute<dynamic>);
  }
}

/// Returns an appropriate width for a [DropdownMenu]
double ezDropdownWidth({
  required BuildContext context,
  required List<String> entries,
}) =>
    2 * EzConfig.marginVal +
    ezTextSize(
      getLongest(entries),
      context: context,
      style: EzConfig.styles.bodyLarge,
    ).width +
    EzConfig.padding +
    max(EzConfig.padding + EzConfig.iconSize, kMinInteractiveDimension);

/// [TargetPlatform] aware helper that will request/exit a fullscreen window
/// Alias exists for [kIsWeb] support
Future<void> ezFullscreenToggle(bool isFull) => toggleFullscreen(isFull);

/// Scale Widgets based on IconSize
/// For Widgets that don't do it automatically, like [Radio] and [Checkbox]
double ezIconRatio() => max(
    EzConfig.iconSize /
        EzConfig.getDefault(
            EzConfig.isDark ? darkIconSizeKey : lightIconSizeKey),
    EzConfig.padding /
        EzConfig.getDefault(
            EzConfig.isDark ? darkPaddingKey : lightPaddingKey));

/// Recommended size for an image
/// Starts with 160.0, chosen by visual inspection
/// Then, applies [MediaQuery] text scaling and [EzConfig] icon scaling
double ezImageSize(BuildContext context) =>
    MediaQuery.textScalerOf(context).scale(160.0) *
    (EzConfig.iconSize /
        EzConfig.getDefault(
            EzConfig.isDark ? darkIconSizeKey : lightIconSizeKey));

/// A [Page] animator based on [EzConfig]
Page<dynamic> ezPageBuilder(
  BuildContext context,
  GoRouterState state,
  Widget child, {
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
      transitionsBuilder,
}) =>
    CustomTransitionPage<dynamic>(
      key: state.pageKey,
      transitionsBuilder: transitionsBuilder ?? ezTransitionsBuilder,
      transitionDuration: ezAnimDuration(),
      reverseTransitionDuration: ezAnimDuration(),
      child: child,
    );

/// Returns the app's current [Locale] and it's corresponding [EFUILang]
Future<(Locale, EFUILang)> ezStoredL10n() async {
  final List<String>? localeData = EzConfig.get(appLocaleKey);
  if (localeData == null || localeData.isEmpty) {
    return (EzConfig.localeFallback, EzConfig.l10nFallback);
  }

  final String languageCode = localeData[0];
  final String? countryCode = (localeData.length > 1) ? localeData[1] : null;
  final Locale locale = (countryCode != null)
      ? Locale(languageCode, countryCode)
      : Locale(languageCode);

  late final EFUILang el10n;
  try {
    el10n = await EFUILang.delegate.load(locale);
  } catch (_) {
    el10n = EzConfig.l10nFallback;
  }

  return (locale, el10n);
}

/// threeQs = [widthOf] context * 0.75
/// min: threeQs, max: min(threeQs, [ScreenSize.small])
BoxConstraints ezTextFieldConstraints(BuildContext context) {
  final double threeQs = widthOf(context) * 0.75;

  return BoxConstraints(
    minWidth: min(threeQs, ScreenSize.small.size),
    maxWidth: min(threeQs, ScreenSize.small.size),
  );
}

/// Calculate a recommended [AppBar.toolbarHeight]
/// max([ezTextSize] + 2 * [EzConfig.get]marginKey, [kMinInteractiveDimension])
double ezToolbarHeight({
  required BuildContext context,
  required String title,
  bool includeIconButton = true,
  TextStyle? style,
}) =>
    max(
      ezTextSize(
        title,
        context: context,
        style: style ?? Theme.of(context).appBarTheme.titleTextStyle,
      ).height,
      includeIconButton
          ? max(EzConfig.iconSize + EzConfig.padding, kMinInteractiveDimension)
          : kMinInteractiveDimension,
    ) +
    EzConfig.marginVal;

/// A [Page] animator based on [EzConfig]
Widget ezTransitionsBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  // Check for no animation
  if (EzConfig.animDur < 1) return child;

  // Gather the transition details
  final EzPageTransition transitionType = EzPageTransitionConfig.lookup(
      EzConfig.get(
          EzConfig.isDark ? darkTransitionTypeKey : lightTransitionTypeKey));

  Widget smartFade(Widget child) => (EzConfig.get(EzConfig.isDark
              ? darkTransitionFadeKey
              : lightTransitionFadeKey) ==
          true)
      ? FadeTransition(opacity: animation, child: child)
      : child;

  if (transitionType == EzPageTransition.system) {
    switch (EzConfig.platform) {
      // Android
      case TargetPlatform.android:
        return ScaleTransition(
          scale: CurveTween(curve: Curves.easeInOut).animate(animation),
          alignment: Alignment.center,
          child: child,
        );

      // Apple
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: FadeTransition(opacity: animation, child: child),
        );

      // Other
      default:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
    }
  }

  switch (transitionType) {
    // Flip
    case EzPageTransition.flip:
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? bChild) => Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY((1.0 - animation.value) * (pi / 2)),
          alignment: Alignment.center,
          child: bChild,
        ),
        child: smartFade(child),
      );

    // Rotate
    case EzPageTransition.rotate:
      return RotationTransition(
        turns: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: smartFade(child),
      );

    // Scale
    case EzPageTransition.scale:
      return ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
        alignment: Alignment.center,
        child: smartFade(child),
      );

    // Slide left
    case EzPageTransition.slideLeft:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        )),
        child: smartFade(child),
      );

    // Slide right
    case EzPageTransition.slideRight:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        )),
        child: smartFade(child),
      );

    // Slide up
    case EzPageTransition.slideUp:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        )),
        child: smartFade(child),
      );

    // Slide down
    case EzPageTransition.slideDown:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, -1.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        )),
        child: smartFade(child),
      );

    // Zoom
    case EzPageTransition.zoom:
      return ScaleTransition(
        scale: CurveTween(curve: Curves.easeInOut).animate(animation),
        alignment: Alignment.center,
        child: smartFade(child),
      );

    // None
    default:
      return child;
  }
}

/// Relaxed reading time for a US tween: 100 words per minute
Duration ezReadingTime(String passage) {
  final int words = passage.split(' ').length;
  return Duration(milliseconds: ((words / 100) * 60 * 1000).ceil());
}

/// Returns the longest [String] in [list]
String getLongest(List<String> list) =>
    list.reduce((String a, String b) => a.length > b.length ? a : b);

/// Returns whether an app was installed from the Google Play Store
/// Theoretically works on all platforms, but only relevant for Android
Future<bool> isGPlayInstall() async {
  final PackageInfo info = await PackageInfo.fromPlatform();
  return info.installerStore == 'com.android.vending';
}
