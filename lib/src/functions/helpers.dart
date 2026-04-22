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
import 'package:country_flags/country_flags.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

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

/// Wide check, true if granted, limited, or provisional
bool allowedPermCheck(PermissionStatus? status) {
  switch (status) {
    case PermissionStatus.granted:
    case PermissionStatus.limited:
    case PermissionStatus.provisional:
      return true;
    default:
      return false;
  }
}

/// More readable than...
/// FocusScope.of(context).unfocus();
void closeKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

/// Is there a required [Function] that you wish was optional?
/// Then [doNothing]!
void doNothing() {}

/// Wide check, true if denied, restricted, or permanently denied, or null
bool deniedPermCheck(PermissionStatus? status) {
  switch (status) {
    case null:
    case PermissionStatus.denied:
    case PermissionStatus.permanentlyDenied:
    case PermissionStatus.restricted:
      return true;
    default:
      return false;
  }
}

/// [EFUILang.gBothThemes], [EFUILang.gDarkTheme], or [EFUILang.gLightTheme]
/// Based on [EzConfig.updateBoth] && [EzConfig.isDark]
String ezThemeString(bool includeBoth) => ((includeBoth && EzConfig.updateBoth)
        ? (EzConfig.locale.languageCode == english.languageCode
            ? "${EzConfig.l10n.gBothThemes}'"
            : EzConfig.l10n.gBothThemes)
        : (EzConfig.isDark
            ? EzConfig.l10n.gDarkTheme
            : EzConfig.l10n.gLightTheme))
    .toLowerCase();

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
  final FilePickerResult? result = await FilePicker.pickFiles(
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
    (context.mounted)
        ? await ezLogAlert(context, message: e.toString())
        : ezLog(e.toString());
    return;
  }

  if (context.mounted) {
    ezSnackBar(
      context,
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

/// Wraps a [ColorPicker] in an [EzAlertDialog]
Future<dynamic> ezColorPicker(
  BuildContext context, {
  String? title,
  required Color startColor,
  required void Function(Color chosenColor) onColorChange,
  String? confirmMsg,
  required void Function() onConfirm,
  String? denyMsg,
  required void Function() onDeny,
}) =>
    ezModal(
      isDismissible: false,
      showDragHandle: false,
      enableDrag: false,
      context: context,
      builder: (BuildContext mCon) => EzScrollView(children: <Widget>[
        EzConfig.spacer,

        // The magic
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
          child: ColorPicker(
            color: startColor,
            mainAxisSize: MainAxisSize.min,
            padding: EdgeInsets.zero,
            spacing: EzConfig.spacing / 2,
            runSpacing: EzConfig.spacing / 2,
            columnSpacing: EzConfig.spacing,
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.both: false,
              ColorPickerType.primary: false,
              ColorPickerType.accent: false,
              ColorPickerType.bw: false,
              ColorPickerType.custom: false,
              ColorPickerType.customSecondary: false,
              ColorPickerType.wheel: true,
            },
            onColorChanged: onColorChange,
            showRecentColors: true,
            enableOpacity: true,
            opacityThumbRadius: min(EzConfig.padding, 25.0),
            opacityTrackHeight: min(EzConfig.padding * 2, 50.0),
            showColorCode: true,
          ),
        ),
        EzConfig.margin,

        // The choice(s)
        EzRow(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EzTextIconButton(
              icon: const Icon(Icons.cancel),
              label: denyMsg ?? EzConfig.l10n.gCancel,
              onPressed: () {
                onDeny();
                if (mCon.mounted) Navigator.of(mCon).pop();
              },
            ),
            EzConfig.rowSpacer,
            EzTextIconButton(
              icon: const Icon(Icons.check),
              label: confirmMsg ?? EzConfig.l10n.gApply,
              onPressed: () {
                onConfirm();
                if (mCon.mounted) Navigator.of(mCon).pop();
              },
            ),
          ],
        ),
        EzConfig.separator,
      ]),
    );

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

Widget ezFlag(Locale locale, {bool inDistress = false}) {
  // Fix language code != flag code
  switch (locale.languageCode) {
    case 'fil':
      locale = const Locale('tl'); // Filipino to Tagalog
      break;

    default:
      break;
  }

  final double flagPadding = EzConfig.iconSize + EzConfig.padding;
  final Widget flag = (locale.countryCode == null)
      ? CountryFlag.fromLanguageCode(
          locale.languageCode,
          theme: ImageTheme(
            shape: const Circle(),
            width: flagPadding,
          ),
        )
      : CountryFlag.fromCountryCode(
          locale.countryCode!,
          theme: ImageTheme(
            height: flagPadding,
            width: flagPadding,
            shape: const Circle(),
          ),
        );

  return inDistress ? Transform.rotate(angle: pi, child: flag) : flag;
}

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
/// Then, applies [MediaQuery] and/or [ezIconRatio] based scaling
double ezImageSize(BuildContext context) =>
    MediaQuery.textScalerOf(context).scale(160.0) * ezIconRatio();

/// Get the human readable name for [locale]
String ezLocaleName(Locale locale, BuildContext context) {
  final String? attempt = LocaleNames.of(context)?.nameOf(locale.languageCode);
  if (attempt != null) return attempt;

  switch (locale) {
    case filipino:
      return 'Filipino';
    case creole:
      return 'Creole';
    default:
      return 'Language';
  }
}

/// [ezLog] the passed message and display an [EzAlertDialog] to notify the user
Future<dynamic> ezLogAlert(
  BuildContext context, {
  String? title,
  required String message,
  List<Widget>? customActions,
  bool needsClose = true,
}) {
  ezLog(message);

  return showDialog(
    context: context,
    builder: (_) => EzAlertDialog(
      title: Text(
        title ?? EzConfig.l10n.gAttention,
        textAlign: TextAlign.center,
      ),
      contents: <Widget>[Text(message, textAlign: TextAlign.center)],
      actions: customActions,
      needsClose: needsClose,
    ),
  );
}

/// A [Page] animator based on [EzConfig]
Page<dynamic> ezPageBuilder(
  BuildContext context,
  GoRouterState state,
  Widget child, {
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
      transitionsBuilder,
}) {
  Widget swipeBackWrap(Widget child) {
    switch (EzConfig.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity != null &&
                details.primaryVelocity! > 250 &&
                ezRootNav.currentState!.canPop()) {
              ezRootNav.currentState!.pop();
            }
          },
          child: child,
        );
      default:
        return child;
    }
  }

  return CustomTransitionPage<dynamic>(
    key: state.pageKey,
    transitionsBuilder: transitionsBuilder ?? ezTransitionsBuilder,
    transitionDuration: ezAnimDuration(),
    reverseTransitionDuration: ezAnimDuration(),
    child: swipeBackWrap(child),
  );
}

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
BoxConstraints ezTextFieldConstraints(BuildContext bc, {double prop = 0.75}) {
  final double chunk = widthOf(bc) * prop;

  return BoxConstraints(
    minWidth: min(chunk, ScreenSize.small.size),
    maxWidth: min(chunk, ScreenSize.small.size),
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

/// [Page] animator based on [EzConfig]
Widget ezTransitionsBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child, {
  EzPageTransition? force,
}) =>
    ezTransitionBuilder(context, animation, child, force: force);

/// Animator based on [EzConfig]
Widget ezTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Widget child, {
  EzPageTransition? force,
  bool reverse = false,
}) {
  // Check for no animation
  if (EzConfig.animDur < 1) return child;

  Widget smartFade(Widget child) => (EzConfig.fadedTransition)
      ? FadeTransition(opacity: animation, child: child)
      : child;
  final double mod = reverse ? -1.0 : 1.0;

  switch (force ?? EzConfig.pageTransition) {
    // System
    case EzPageTransition.system:
      switch (EzConfig.platform) {
        // Android -> Zoom
        case TargetPlatform.android:
          return ScaleTransition(
            scale: Tween<double>(
              begin: reverse ? 2.0 : 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            alignment: Alignment.center,
            child: smartFade(child),
          );

        // Other (web is auto-none) -> Horizontal slide
        default:
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset((EzConfig.isLTR ? 1.0 : -1.0) * mod, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: smartFade(child),
          );
      }

    // Horizontal turn
    case EzPageTransition.turnX:
      return AnimatedBuilder(
        animation: animation,
        builder: (_, __) => EzConfig.isLTR
            ? Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0001)
                  ..rotateY((1 - animation.value) * (pi / 2) * mod),
                alignment: Alignment.centerLeft,
                child: smartFade(child),
              )
            : Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0001)
                  ..rotateY((1 - animation.value) * -(pi / 2) * mod),
                alignment: Alignment.centerRight,
                child: smartFade(child),
              ),
        child: child,
      );

    // Vertical turn
    case EzPageTransition.turnY:
      return AnimatedBuilder(
        animation: animation,
        builder: (_, __) => Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0001)
            ..rotateX((1 - animation.value) * -(pi / 2) * mod),
          alignment: Alignment.topCenter,
          child: smartFade(child),
        ),
        child: child,
      );

    // Rotate
    case EzPageTransition.rotate:
      return RotationTransition(
        turns: Tween<double>(
          begin: mod,
          end: 0.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        )),
        child: smartFade(child),
      );

    // Horizontal slide
    case EzPageTransition.slideX:
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset((EzConfig.isLTR ? 1.0 : -1.0) * mod, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        )),
        child: smartFade(child),
      );

    // Vertical slide
    case EzPageTransition.slideY:
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0.0, mod),
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
        scale: Tween<double>(
          begin: reverse ? 2.0 : 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        )),
        alignment: Alignment.center,
        child: smartFade(child),
      );

    // None
    case EzPageTransition.none:
      return smartFade(child);
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
