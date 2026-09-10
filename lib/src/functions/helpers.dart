/* open_ui
 * Copyright (c) 2022 YWT (Empathetech LLC). All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../open_ui.dart';

import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import 'helpers_io.dart' if (dart.library.html) 'helpers_web.dart';

//* Aliases *//

/// Wide check, true if granted, limited, or provisional
bool allowedPermCheck(PermissionStatus? status) => switch (status) {
      PermissionStatus.granted || PermissionStatus.limited || PermissionStatus.provisional => true,
      _ => false,
    };

/// Where to find saved files on the current [TargetPlatform]
String archivePath() => switch (EzCM.platform) {
      TargetPlatform.android =>
        'Root > Android > Data > ${EzCM.androidPackage ?? 'com.example.app'} > files',
      TargetPlatform.iOS => 'Files > Browse > ${EzCM.appName}',
      _ => 'Downloads',
    };

/// More readable than...
/// FocusScope.of(context).unfocus();
void closeKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

/// Wide check, true if denied, restricted, or permanently denied, or null
bool deniedPermCheck(PermissionStatus? status) => switch (status) {
      PermissionStatus.denied ||
      PermissionStatus.permanentlyDenied ||
      PermissionStatus.restricted ||
      null =>
        true,
      _ => false,
    };

/// Is there a required [Function] that you wish was optional?
/// Then [doNothing]!
void doNothing() {}

/// Get the current [TargetPlatform]; "slow" but reliable
/// Alias exists for [kIsWeb] support
TargetPlatform getBasePlatform() => getHostPlatform();

/// More readable than...
/// MediaQuery.of(context).size.height
double heightOf(BuildContext context) => MediaQuery.of(context).size.height;

/// Alias for [MediaQuery] brightness check
bool isDarkTheme(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;

/// Alias exists for [kIsWeb] support
bool isMobile() => mobileCheck();

/// [SafeArea] top padding
double safeTop(BuildContext context) => MediaQuery.of(context).padding.top;

/// [SafeArea] bottom padding
double safeBottom(BuildContext context) => MediaQuery.of(context).padding.bottom;

/// Button combo for taking a screenshot on the current (desktop) [TargetPlatform]
/// Defaults to an empty string on mobile (and unknown) platforms
String screenshotHint() => switch (EzCM.platform) {
      TargetPlatform.linux ||
      TargetPlatform.fuchsia ||
      TargetPlatform.windows =>
        ' (Alt + Print Screen)',
      TargetPlatform.macOS => ' (Command + Shift + 5)',
      _ => '',
    };

/// Open/close a [MenuController]
void toggleMenu(MenuController c) => c.isOpen ? c.close() : c.open();

/// Wait for a desired number of [seconds]
Future<void> wait(int seconds) => Future<void>.delayed(Duration(seconds: seconds));

/// More readable than...
/// MediaQuery.of(context).size.width
double widthOf(BuildContext context) => MediaQuery.of(context).size.width;

//* Custom functions *//

Future<void> ezConfigLoader(
  EzCP config, {
  required BuildContext context,
  Future<void> Function()? extra,
}) async {
  final PlatformFile? result = await FilePicker.pickFile(
    type: FileType.custom,
    allowedExtensions: <String>['json'],
  );

  try {
    if (result != null && result.path != null) {
      if (kIsWeb) {
        final Uint8List fileBytes = await result.readAsBytes();

        final String fileContent = utf8.decode(fileBytes);
        await EzCM.loadConfig(config, toLoad: jsonDecode(fileContent));
      } else {
        final String filePath = result.path!;
        final String fileContent = await File(filePath).readAsString();

        await EzCM.loadConfig(config, toLoad: jsonDecode(fileContent));

        if (context.mounted) {
          String? darkPath;
          String? lightPath;

          final bool? save = await showDialog(
            context: context,
            builder: (BuildContext dCon) => StatefulBuilder(builder: (_, StateSetter setDialog) {
              return EzAlertDialog(
                config,
                title: Text(config.ezL10n.ssImageToo, textAlign: TextAlign.center),
                contents: <Widget>[
                  EzElevatedIconButton(
                    config,
                    label: config.ezL10n.gDarkTheme,
                    icon: EzIcon(config, darkPath == null ? Icons.question_mark : Icons.check),
                    onPressed: () async {
                      darkPath = await ezImagePicker(config,
                          context: context, source: ImageSource.gallery);
                      if (dCon.mounted) setDialog(() {});
                    },
                    onLongPress: () => setDialog(() => darkPath = null),
                  ),
                  config.spacer,
                  EzElevatedIconButton(
                    config,
                    label: config.ezL10n.gLightTheme,
                    icon: EzIcon(config, lightPath == null ? Icons.question_mark : Icons.check),
                    onPressed: () async {
                      lightPath = await ezImagePicker(config,
                          context: context, source: ImageSource.gallery);
                      if (dCon.mounted) setDialog(() {});
                    },
                    onLongPress: () => setDialog(() => lightPath = null),
                  ),
                ],
                actions: <EzAction>[
                  EzAction(
                    config,
                    text: config.ezL10n.gNo,
                    onPressed: Navigator.of(dCon).pop,
                  ),
                  EzAction(
                    config,
                    text: config.ezL10n.gSave,
                    onPressed: () => Navigator.of(dCon).pop(true),
                  ),
                ],
                needsClose: false,
              );
            }),
          );

          if (save == true) {
            if (darkPath != null) await EzCM.setString(darkBackgroundImageKey, darkPath!);
            if (lightPath != null) await EzCM.setString(lightBackgroundImageKey, lightPath!);
          }
        }
      }
    }
  } catch (e) {
    (context.mounted)
        ? await ezLogAlert(config, context: context, message: e.toString())
        : ezLog(e.toString());
    return;
  }

  await config.rebuildUI(changes: extra);
}

/// Close any open modals or dialogs
/// Automatically consumed by [EzCP.rebuildUI]
void ezCloseAll() {
  final NavigatorState? state = ezRootNav.currentState;
  if (state == null) return;

  if (state.canPop()) state.popUntil((Route<dynamic> route) => route is PageRoute<dynamic>);
}

/// Wraps a [ColorPicker] in an [EzAlertDialog]
Future<void> ezColorPicker(
  EzCP config, {
  required BuildContext context,
  String? title,
  required Color startColor,
  required void Function(Color chosenColor) onColorChange,
  String? confirmMsg,
  required void Function() onConfirm,
  String? denyMsg,
  required void Function() onDeny,
}) =>
    ezModal(
      config,
      enableDrag: false,
      isDismissible: false,
      showDragHandle: false,
      context: context,
      builder: (BuildContext mCon) => ezModalScroll(
        config,
        children: <Widget>[
          EzHeader(config),

          // The magic
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
            child: ColorPicker(
              color: startColor,
              columnSpacing: config.spacing,
              copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                pasteButton: true,
              ),
              enableOpacity: true,
              mainAxisSize: MainAxisSize.min,
              onColorChanged: onColorChange,
              onColorChangeEnd: onColorChange,
              opacityThumbRadius: max(12.0, min(config.padding, 30.0)),
              opacityTrackHeight: min(config.padding * 2, 50.0),
              padding: EdgeInsets.zero,
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.both: false,
                ColorPickerType.primary: false,
                ColorPickerType.accent: false,
                ColorPickerType.bw: false,
                ColorPickerType.custom: false,
                ColorPickerType.customSecondary: false,
                ColorPickerType.wheel: true,
              },
              runSpacing: config.spacing / 2,
              showColorCode: true,
              showRecentColors: true,
              spacing: config.spacing / 2,
              toolbarSpacing: config.spacing / 2,
            ),
          ),
          config.margin,

          // The choice(s)
          EzRow(
            config,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              EzTextIconButton(
                config,
                icon: EzIcon(config, Icons.cancel),
                label: denyMsg ?? config.ezL10n.gCancel,
                onPressed: () {
                  onDeny();
                  if (mCon.mounted) Navigator.of(mCon).pop();
                },
              ),
              config.rowSpacer,
              EzTextIconButton(
                config,
                icon: EzIcon(config, Icons.check),
                label: confirmMsg ?? config.ezL10n.gApply,
                onPressed: () {
                  onConfirm();
                  if (mCon.mounted) Navigator.of(mCon).pop();
                },
              ),
            ],
          ),
          EzKeyboardSpacer(config.spacing * 2),
        ],
      ),
    );

/// Returns an appropriate width for a [DropdownMenu]
double ezDropdownWidth(EzCP config, {required BuildContext context, required String entry}) =>
    2 * config.marginVal +
    ezTextSize(
      config,
      text: entry,
      style: config.bodyStyle,
      textScaler: MediaQuery.textScalerOf(context),
    ).width +
    config.padding +
    max(config.padding + config.iconSize, kMinInteractiveDimension);

/// [Duration] with milliseconds [base]
/// Provide [mod] to adjust the duration, relative to the base value
/// Sometimes [Duration.zero] breaks things, so use [nonZero] for a 1 millisecond [Duration]
Duration ezDuration(
  int base, {
  double mod = 1.0,
  bool nonZero = false,
}) =>
    Duration(milliseconds: max((base * mod).toInt(), nonZero ? 1 : 0));

Widget ezFlag(EzCP config, {required Locale locale, bool inDistress = false}) {
  // Fix language code != flag code
  switch (locale.languageCode) {
    case 'fil':
      locale = const Locale('tl'); // Filipino to Tagalog
      break;

    default:
      break;
  }

  final double flagPadding = config.iconSize + config.padding;
  final Widget flag = (locale.countryCode == null)
      ? CountryFlag.fromLanguageCode(
          locale.languageCode,
          theme: ImageTheme(shape: const Circle(), width: flagPadding),
        )
      : CountryFlag.fromCountryCode(
          locale.countryCode!,
          theme: ImageTheme(height: flagPadding, width: flagPadding, shape: const Circle()),
        );

  return inDistress ? Transform.rotate(angle: pi, child: flag) : flag;
}

/// Scale Widgets based on IconSize
/// For Widgets that don't do it automatically, like [Radio] and [Checkbox]
double ezIconRatio(EzCP config) => max(
      config.iconSize / EzCM.getDefault(config.isDark ? darkIconSizeKey : lightIconSizeKey),
      config.padding / EzCM.getDefault(config.isDark ? darkPaddingKey : lightPaddingKey),
    );

/// Recommended size for an image
/// Starts with 160.0, chosen by visual inspection
/// Then, applies [MediaQuery] and/or [ezIconRatio] based scaling
double ezImageSize(EzCP config, {required BuildContext context}) =>
    MediaQuery.textScalerOf(context).scale(160.0) * ezIconRatio(config);

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

/// Required if you want to use Haitian Creole (ht)
Set<LocalizationsDelegate<dynamic>> ezLocalizationsDelegates(
  List<LocalizationsDelegate<dynamic>> local,
) =>
    <LocalizationsDelegate<dynamic>>{
      const LocaleNamesLocalizationsDelegate(),
      CreoleMaterialLocalizations.delegate,
      CreoleCupertinoLocalizations.delegate,
      const CreoleWidgetsLocalizationsDelegate(),
      ...OUILang.localizationsDelegates,
      ...local,
    };

/// [ezLog] the passed message and display an [EzAlertDialog] to notify the user
Future<dynamic> ezLogAlert(
  EzCP config, {
  required BuildContext context,
  String? title,
  required String message,
  List<Widget>? customActions,
  bool needsClose = true,
}) {
  ezLog(message);

  return showDialog(
    context: context,
    builder: (_) => EzAlertDialog(
      config,
      title: Text(title ?? config.ezL10n.gAttention, textAlign: TextAlign.center),
      contents: <Widget>[Text(message, textAlign: TextAlign.center)],
      actions: customActions,
      needsClose: needsClose,
    ),
  );
}

/// Disable screen interaction while [changes] are taking place
Future<void> ezNoTouch(Future<dynamic> Function() changes) async {
  unawaited(
    ezRootNav.currentState!.push(
      // Open progress layer
      PageRouteBuilder<Widget>(
        opaque: false,
        transitionsBuilder: (_, __, ___, Widget child) => child,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => const Center(child: CircularProgressIndicator()),
      ),
    ),
  );

  await changes();
  ezRootNav.currentState!.pop();
}

/// A [Page] animator based on [EzCP]
Page<dynamic> ezPageBuilder(
  EzCP config,
  BuildContext context,
  GoRouterState state,
  Widget child, {
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)? transitionsBuilder,
}) =>
    CustomTransitionPage<dynamic>(
      key: state.pageKey,
      transitionsBuilder: transitionsBuilder ??
          (BuildContext c, Animation<double> a, Animation<double> aa, Widget w) =>
              ezTransitionsBuilder(config, c, a, aa, w),
      transitionDuration: ezDuration(config.animDur),
      reverseTransitionDuration: ezDuration(config.animDur),
      child: switch (EzCM.platform) {
        TargetPlatform.iOS || TargetPlatform.macOS => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity != null &&
                  details.primaryVelocity! > (ezSwipeV * 1.5) &&
                  (ezRootNav.currentState?.canPop() ?? false)) {
                ezRootNav.currentState!.pop();
              }
            },
            child: child,
          ),
        _ => child,
      },
    );

/// Returns the app's current [Locale] and it's corresponding [OUILang]
Future<(Locale, OUILang)> ezStoredL10n() async {
  final List<String>? localeData = EzCM.get(appLocaleKey);
  if (localeData == null || localeData.isEmpty) {
    return (EzCM.localeFallback, EzCM.l10nFallback);
  }

  final String languageCode = localeData[0];
  final String? countryCode = (localeData.length > 1) ? localeData[1] : null;
  final Locale locale =
      (countryCode != null) ? Locale(languageCode, countryCode) : Locale(languageCode);

  late final OUILang el10n;
  try {
    el10n = await OUILang.delegate.load(locale);
  } catch (_) {
    el10n = EzCM.l10nFallback;
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

/// [OUILang.gBothThemes], [OUILang.gDarkTheme], or [OUILang.gLightTheme]
/// Based on [EzCM.updateBoth] && [EzCP.isDark]
String ezThemeString(EzCP config, {required bool bothable}) => ((bothable && EzCM.updateBoth)
        ? (config.locale.languageCode == english.languageCode
            ? "${config.ezL10n.gBothThemes}'"
            : config.ezL10n.gBothThemes)
        : (config.isDark ? config.ezL10n.gDarkTheme : config.ezL10n.gLightTheme))
    .toLowerCase();

/// Calculate a recommended [AppBar.toolbarHeight]
/// max([ezTextSize] + 2 * [EzCM.get]marginKey, [kMinInteractiveDimension])
double ezToolbarHeight(
  EzCP config, {
  required BuildContext context,
  required String title,
  bool includeIconButton = true,
  TextStyle? style,
}) =>
    max(
      ezTextSize(
        config,
        text: title,
        style: style ?? config.theme.appBarTheme.titleTextStyle,
        textScaler: MediaQuery.textScalerOf(context),
      ).height,
      includeIconButton
          ? max(config.iconSize + config.padding, kMinInteractiveDimension)
          : kMinInteractiveDimension,
    ) +
    config.marginVal;

/// [Page] animator based on [EzCP]
Widget ezTransitionsBuilder(
  EzCP config,
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child, {
  EzTransitionType? forceType,
  bool? forceFade,
  bool reverse = false,
}) =>
    ezTransitionBuilder(
      config,
      animation,
      child,
      forceType: forceType,
      forceFade: forceFade,
      reverse: reverse,
    );

/// Animator based on [EzCP]
Widget ezTransitionBuilder(
  EzCP config,
  Animation<double> animation,
  Widget child, {
  EzTransitionType? forceType,
  bool? forceFade,
  bool reverse = false,
}) {
  // Check for no animation
  if (config.animDur < 1) return child;

  Widget smartFade(Widget child) => (forceFade ?? config.fadedTransition)
      ? FadeTransition(opacity: animation, child: child)
      : child;
  final double mod = reverse ? -1.0 : 1.0;

  switch (forceType ?? config.transitionType) {
    // System
    case EzTransitionType.system:
      switch (EzCM.platform) {
        // Android -> Zoom
        case TargetPlatform.android:
          return ScaleTransition(
            scale: Tween<double>(
              begin: reverse ? 2.0 : 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(parent: animation, curve: config.animCurve)),
            child: smartFade(child),
          );

        // Other (web is auto-none) -> Horizontal slide
        default:
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset((config.isLTR ? 1.0 : -1.0) * mod, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: config.animCurve)),
            child: smartFade(child),
          );
      }

    // Horizontal turn
    case EzTransitionType.turnX:
      return AnimatedBuilder(
        animation: animation,
        builder: (_, __) => config.isLTR
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
    case EzTransitionType.turnY:
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
    case EzTransitionType.rotate:
      return RotationTransition(
        turns: Tween<double>(
          begin: 0.0,
          end: mod,
        ).animate(CurvedAnimation(parent: animation, curve: config.animCurve)),
        child: smartFade(child),
      );

    // Horizontal slide
    case EzTransitionType.slideX:
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset((config.isLTR ? 1.0 : -1.0) * mod, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: config.animCurve)),
        child: smartFade(child),
      );

    // Vertical slide
    case EzTransitionType.slideY:
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0.0, mod),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: config.animCurve)),
        child: smartFade(child),
      );

    // Zoom
    case EzTransitionType.zoom:
      return ScaleTransition(
        scale: Tween<double>(
          begin: reverse ? 2.0 : 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: config.animCurve)),
        child: smartFade(child),
      );

    // None
    case EzTransitionType.none:
      return smartFade(child);
  }
}

/// Relaxed reading time (in ms) for a US tween...
/// 100 words per minute
Duration ezReadingTime(EzCP config, String passage) {
  if (passage.trim().isEmpty) return Duration.zero;

  final int words = picLanguageCodes.contains(config.locale.languageCode)
      ? passage.replaceAll(RegExp(r'\s+'), '').length
      : passage.split(RegExp(r'\s+')).where((String w) => w.isNotEmpty).length;

  return Duration(milliseconds: ((words / 100) * 60 * 1000).ceil());
}

/// CAW! Must call/check [ezRootIsMounted] first!
BuildContext get ezRootContext => ezRootNav.currentContext!;

/// Checks that [ezRootNav]s BuildContext is both not null and mounted
bool get ezRootIsMounted => (ezRootNav.currentContext != null) && ezRootNav.currentContext!.mounted;

/// [ezRootNav]s [NavigatorState]s overlay
OverlayState? get ezRootOverlay => ezRootNav.currentState?.overlay;

/// 'Smart' keyboard arrow
IconData ezVisIcon(EzCP config, bool show) => show
    ? Icons.keyboard_arrow_down
    : config.isLefty
        ? Icons.keyboard_arrow_right
        : Icons.keyboard_arrow_left;

/// Location of the owner of [context]
Offset ezWya(BuildContext context) =>
    (context.findRenderObject() as RenderBox).localToGlobal(Offset.zero);

/// Returns the longest [String] in [list]
String getLongest(List<String> list) =>
    list.reduce((String a, String b) => a.length > b.length ? a : b);

/// Returns whether an app was installed from the Google Play Store
/// Theoretically works on all platforms, but only relevant for Android
Future<bool> isGPlayInstall() async {
  final PackageInfo info = await PackageInfo.fromPlatform();
  return info.installerStore == 'com.android.vending';
}
