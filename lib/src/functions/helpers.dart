/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:file_saver/file_saver.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'helpers_io.dart' if (dart.library.html) 'helpers_web.dart';

//* Aliases *//

// Platform checks //

/// Get the current [TargetPlatform]; "slow" but reliable
/// Alias exists for [kIsWeb] support
TargetPlatform getBasePlatform() => getHostPlatform();

/// Alias exists for [kIsWeb] support
bool isMobile() => mobileCheck();

/// Alias exists for [kIsWeb] support
/// [isMobile] is preferred; technically more efficient
bool isDesktop() => desktopCheck();

/// Alias exists for [kIsWeb] support
bool isApple() => cupertinoCheck();

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

/// First checks [PlatformTheme] then falls back to [MediaQuery]
bool isDarkTheme(BuildContext context) =>
    PlatformTheme.of(context)?.isDark ??
    (MediaQuery.of(context).platformBrightness == Brightness.dark);

/// Gets any stored [Locale] from [EzConfig]
Locale getStoredLocale() {
  final List<String>? localeData = EzConfig.get(appLocaleKey);
  if (localeData == null || localeData.isEmpty) {
    return EzConfig.localeFallback;
  }

  final String languageCode = localeData[0];
  final String? countryCode = (localeData.length > 1) ? localeData[1] : null;

  return (countryCode != null)
      ? Locale(languageCode, countryCode)
      : Locale(languageCode);
}

// Readability //

/// Is there a required [Function] that you wish was optional?
/// Then [doNothing]!
void doNothing() {}

/// More readable than...
/// MediaQuery.of(context).size.height
double heightOf(BuildContext context) => MediaQuery.of(context).size.height;

/// More readable than...
/// MediaQuery.of(context).size.width
double widthOf(BuildContext context) => MediaQuery.of(context).size.width;

/// More readable than...
/// FocusScope.of(context).unfocus();
void closeKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

//* Custom functions *//

/// Returns the [Directionality] of the current [BuildContext]
/// Falls back to [rtlLanguageCodes] on context errors
bool ltrCheck(BuildContext context) {
  try {
    return Directionality.of(context) == TextDirection.ltr;
  } catch (_) {
    final Locale locale = WidgetsBinding.instance.platformDispatcher.locale;
    return !rtlLanguageCodes.contains(locale.languageCode);
  }
}

/// Returns whether an app was installed from the Google Play Store
/// Theoretically works on all platforms, but only relevant for Android
Future<bool> isGPlayInstall() async {
  final PackageInfo info = await PackageInfo.fromPlatform();
  return info.installerStore == 'com.android.vending';
}

/// Relaxed reading time for a US tween: 100 words per minute
Duration ezReadingTime(String passage) {
  final int words = passage.split(' ').length;
  return Duration(milliseconds: ((words / 100) * 60 * 1000).ceil());
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
    EzConfig.margin;

/// Recommended size for an image
/// Starts with 160.0; chosen by visual inspection
/// Then, applies [MediaQuery] text scaling and [EzConfig] icon scaling
double ezImageSize(BuildContext context) =>
    MediaQuery.textScalerOf(context).scale(160.0) *
    (EzConfig.iconSize / EzConfig.getDefault(iconSizeKey));

/// [TargetPlatform] aware helper that will request/exit a fullscreen window
Future<void> ezFullscreenToggle(TargetPlatform platform, bool isFull) =>
    toggleFullscreen(platform, isFull);

/// Save the current [EzConfig.prefs] to local storage
Future<void> ezConfigSaver(
  BuildContext context, {
  List<String>? extraKeys,
  required String appName,
  String? androidPackage,
}) async {
  final List<String> keys = <String>[
    ...allEZConfigKeys.keys,
    if (extraKeys != null) ...extraKeys,
  ];

  final Map<String, dynamic> config = Map<String, dynamic>.fromEntries(keys.map(
    (String key) => MapEntry<String, dynamic>(
      key,
      EzConfig.get(key),
    ),
  ));

  try {
    await FileSaver.instance.saveFile(
      name: '${ezTitleToSnake(appName)}_settings.json',
      bytes: utf8.encode(jsonEncode(config)),
      mimeType: MimeType.json,
    );
  } catch (e) {
    if (context.mounted) ezLogAlert(context, message: e.toString());
    return;
  }

  if (context.mounted) {
    ezSnackBar(
      context: context,
      message: EzConfig.l10n.ssConfigSaved(archivePath(
        appName: appName,
        androidPackage: androidPackage,
      )),
    );
  }
}

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
    if (context.mounted) ezLogAlert(context, message: e.toString());
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
