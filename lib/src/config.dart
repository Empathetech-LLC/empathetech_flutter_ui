/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../empathetech_flutter_ui.dart';

import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';

// There are few (if any) null checks in EzConfig
// EFUI won't work at all (immediate runtime failure) if EzConfig isn't properly initialized, so they're moot

//* Config constructor(s) *//

class EzConfig {
  /// [AssetImage] paths for the app
  final Set<String> _assetPaths;

  /// Default config
  final Map<String, dynamic> _defaults;

  /// Fallback [Locale] for unsupported [Locale]s
  /// [english] or [americanEnglish] is recommended
  final Locale _localeFallback;

  /// Fallback [EFUILang] for unsupported [Locale]s
  /// [EFUILang.delegate] load the [_localeFallback]
  /// Constructors cannot be async, so the load must be awaited externally/beforehand
  final EFUILang _l10nFallback;

  /// [SharedPreferencesAsync] instance
  final SharedPreferencesAsync _preferences;

  /// Live values in use
  final Map<String, dynamic> _prefs;

  /// [EzConfig] key : value runtime [Type] map
  final Map<String, Type> _typeMap;

  /// Allows for [EzConfigProvider.rebuildUI] and hosts caches for [ThemeMode] aware [EzConfig] values
  EzConfigProvider? _provider;

  /// Private instance
  static EzConfig? _instance;

  /// Private/internal constructor
  EzConfig._({
    // External (factory parameters)
    required Set<String> assetPaths,
    required Map<String, dynamic> defaults,
    required Locale localeFallback,
    required EFUILang l10nFallback,
    required SharedPreferencesAsync preferences,

    // Internal (built by factory)
    required Map<String, dynamic> prefs,
    required Map<String, Type> typeMap,
  })  : _assetPaths = assetPaths,
        _defaults = defaults,
        _localeFallback = localeFallback,
        _l10nFallback = l10nFallback,
        _preferences = preferences,
        _prefs = prefs,
        _typeMap = typeMap;

  /// [assetPaths] => provide the [AssetImage] paths for this app
  /// [defaults] => provide your brand colors, text styles, layout settings, etc.
  /// [localeFallback] => provide a fallback [Locale] for [Locale]s that [EFUILang] doesn't support (yet)
  /// [l10nFallback] => provide a fallback [EFUILang] for [Locale]s that [EFUILang] doesn't support (yet)
  /// [preferences] => provide a [SharedPreferencesWithCache] instance
  /// [provider] => Set by [EzConfigurableApp], recommended to leave null unless you are not using [EzConfigurableApp]
  factory EzConfig.init({
    required Set<String> assetPaths,
    required Map<String, dynamic> defaults,
    required Locale localeFallback,
    required EFUILang l10nFallback,
    required SharedPreferencesWithCache preferences,
    EzConfigProvider? provider,
  }) {
    if (_instance == null) {
      // Get the value type for each key //

      // Start with the known EzConfigverse
      final Map<String, Type> typeMap = Map<String, Type>.from(allEZConfigKeys);

      // Include defaults
      final Set<String> uniqueDefaults =
          defaults.keys.toSet().difference(typeMap.keys.toSet());

      for (final String key in uniqueDefaults) {
        typeMap[key] = defaults[key].runtimeType;
      }

      // Build this.prefs //

      // Start with the defaults
      final Map<String, dynamic> prefs = Map<String, dynamic>.from(defaults);

      // Find the keys that users have overwritten
      final Set<String> overwritten =
          preferences.keys.intersection(typeMap.keys.toSet());

      // Get the updated values
      for (final String key in overwritten) {
        final Type? valueType = typeMap[key];
        dynamic userPref;

        switch (valueType) {
          case const (bool):
            userPref = preferences.getBool(key);
            break;

          case const (int):
            userPref = preferences.getInt(key);
            break;

          case const (double):
            userPref = preferences.getDouble(key);
            break;

          case const (String):
            userPref = preferences.getString(key);
            break;

          case const (List<String>):
            userPref = preferences.getStringList(key);
            break;

          default:
            ezLog('''Key [$key] has unsupported Type [$valueType]
Must be one of [int, bool, double, String, List<String>]''');
            break;
        }

        if (userPref != null) prefs[key] = userPref;
      }

      // Build the EzConfig instance //

      _instance = EzConfig._(
        assetPaths: <String>{...assetPaths, ...efuiAssetPaths},
        defaults: defaults,
        localeFallback: localeFallback,
        l10nFallback: l10nFallback,
        preferences: SharedPreferencesAsync(),
        prefs: prefs,
        typeMap: typeMap,
      );
    }

    return _instance!;
  }

  //* Config getters *//

  // Core //

  /// Default/fallback for unsupported [Locale]s
  static Locale get localeFallback => _instance!._localeFallback;

  /// Default/fallback localizations for [localeFallback]
  static EFUILang get l10nFallback => _instance!._l10nFallback;

  /// Get the [key]s default EzConfig (nullable) value
  static dynamic getDefault(String key) => _instance!._defaults[key];

  /// Get the [key]s current EzConfig value
  /// bool, int, double, String, String List, or null
  static dynamic get(String key) => _instance!._prefs[key] ?? getDefault(key);

  /// Alias for [EzConfig.get] => [isLeftyKey]
  static bool get isLefty => get(isLeftyKey);

  /// Get the [key]s EzConfig (nullable) [bool] value
  /// Uses the stored values from [SharedPreferencesAsync]
  static Future<bool?> getBool(String key) =>
      _instance!._preferences.getBool(key);

  /// Get the [key]s EzConfig (nullable) [int] value
  /// Uses the stored values from [SharedPreferencesAsync]
  static Future<int?> getInt(String key) => _instance!._preferences.getInt(key);

  /// Get the [key]s EzConfig (nullable) [double] value
  /// Uses the stored values from [SharedPreferencesAsync]
  static Future<double?> getDouble(String key) =>
      _instance!._preferences.getDouble(key);

  /// Get the [key]s EzConfig (nullable) [String] value
  /// Uses the stored values from [SharedPreferencesAsync]
  static Future<String?> getString(String key) =>
      _instance!._preferences.getString(key);

  /// Get the [key]s EzConfig (nullable) [List] value
  /// Uses the stored values from [SharedPreferencesAsync]
  static Future<List<String>?> getStringList(String key) =>
      _instance!._preferences.getStringList(key);

  /// Wether the [path] leads to an [AssetImage]
  static bool isPathAsset(String path) => _instance!._assetPaths.contains(path);

  /// Wether the [key] points to an [AssetImage] path
  static bool isKeyAsset(String key) =>
      _instance!._assetPaths.contains(_instance!._prefs[key]);

  //* Setters *//

  static bool initProvider(EzConfigProvider configProvider) {
    if (_instance == null) return false;

    if (_instance!._provider == null) _instance!._provider = configProvider;
    return true;
  }

  /// Set the EzConfig [key] to [value] with type [bool]
  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<bool> setBool(
    String key,
    bool value, {
    bool storageOnly = false,
  }) async {
    try {
      await _instance!._preferences.setBool(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;
      return true;
    } catch (e) {
      ezLog('Error setting bool [$key]...\n$e');
      return false;
    }
  }

  /// Set the EzConfig [key] to [value] with type [int]
  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<bool> setInt(
    String key,
    int value, {
    bool storageOnly = false,
  }) async {
    try {
      await _instance!._preferences.setInt(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;
      return true;
    } catch (e) {
      ezLog('Error setting int [$key]...\n$e');
      return false;
    }
  }

  /// Set the EzConfig [key] to [value] with type [double]
  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<bool> setDouble(
    String key,
    double value, {
    bool storageOnly = false,
  }) async {
    try {
      await _instance!._preferences.setDouble(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;
      return true;
    } catch (e) {
      ezLog('Error setting double [$key]...\n$e');
      return false;
    }
  }

  /// Set the EzConfig [key] to [value] with type [String]
  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<bool> setString(
    String key,
    String value, {
    bool storageOnly = false,
  }) async {
    try {
      await _instance!._preferences.setString(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;
      return true;
    } catch (e) {
      ezLog('Error setting String [$key]...\n$e');
      return false;
    }
  }

  /// Set the EzConfig [key] to [value] with type [List]
  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<bool> setStringList(
    String key,
    List<String> value, {
    bool storageOnly = false,
  }) async {
    try {
      await _instance!._preferences.setStringList(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;
      return true;
    } catch (e) {
      ezLog('Error setting String List [$key]...\n$e');
      return false;
    }
  }

  /// Save the current [EzConfig] to local storage
  static Future<void> saveConfig(
    BuildContext context, {
    required String appName,
    String? androidPackage,
    Set<String>? skip,
  }) async {
    final Map<String, dynamic> config =
        Map<String, dynamic>.from(_instance!._prefs);
    if (skip != null) {
      for (final String key in skip) {
        config.remove(key);
      }
    }

    try {
      await FileSaver.instance.saveFile(
        name: '${ezTitleToSnake(appName)}_settings.json',
        bytes: utf8.encode(jsonEncode(config)),
        mimeType: MimeType.json,
      );
    } catch (e) {
      if (context.mounted) await ezLogAlert(context, message: e.toString());
      return;
    }

    if (context.mounted) {
      ezSnackBar(
        context: context,
        message: EzConfig.l10n.ssConfigSaved(
          archivePath(appName: appName, androidPackage: androidPackage),
        ),
      );
    }
  }

  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<void> loadConfig(
    Map<String, dynamic> config, {
    Set<String>? filter,
    bool storageOnly = false,
  }) async {
    final Set<MapEntry<String, dynamic>> entries = config.entries.toSet();
    if (filter != null) entries.removeAll(filter);

    for (final MapEntry<String, dynamic> entry in entries) {
      // Check type
      final dynamic expectedType = _instance!._typeMap[entry.key];
      if (expectedType == null) {
        ezLog('Skipping unknown key [${entry.key}]');
        continue;
      }
      if (expectedType != entry.value.runtimeType) {
        ezLog(
          'Skipping key [${entry.key}], mismatched types: [$expectedType != ${entry.value.runtimeType}]',
        );
        continue;
      }

      // Load value
      switch (entry.value.runtimeType) {
        case const (bool):
          await setBool(
            entry.key,
            entry.value,
            storageOnly: storageOnly,
          );
          break;
        case const (int):
          await setInt(
            entry.key,
            entry.value,
            storageOnly: storageOnly,
          );
        case const (double):
          await setDouble(
            entry.key,
            entry.value,
            storageOnly: storageOnly,
          );
        case const (String):
          await setString(
            entry.key,
            entry.value,
            storageOnly: storageOnly,
          );
          break;
        case const (List<String>):
          await setStringList(
            entry.key,
            entry.value,
            storageOnly: storageOnly,
          );
          break;
      }
    }
  }

  /// Create a pseudo-random config that follows the default vibe
  /// i.e. a triadic [ColorScheme] that should be legible
  static Future<void> randomize() async {
    final Random random = Random();

    double getScalar() => (random.nextDouble() * 1.5) + 0.5;

    // Update global settings //

    // Lefty
    await setBool(isLeftyKey, random.nextBool());

    // Leave ThemeMode as-is, don't wanna light blast peeps at night
    // Locale too, don't want them to get lost

    // Define (shared) seed ColorScheme //

    // Define random seed
    final Color primary = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
    final Color onPrimary = getTextColor(primary);

    // Build a triadic combo from the seed
    final HSVColor primaryHSV = HSVColor.fromColor(primary);
    final double secondaryHue = (primaryHSV.hue + 120) % 360;
    final double tertiaryHue = (primaryHSV.hue + 240) % 360;

    final Color secondary = HSVColor.fromAHSV(
      1.0,
      secondaryHue,
      primaryHSV.saturation,
      primaryHSV.value,
    ).toColor();
    final Color onSecondary = getTextColor(secondary);

    final Color tertiary = HSVColor.fromAHSV(
      1.0,
      tertiaryHue,
      primaryHSV.saturation,
      primaryHSV.value,
    ).toColor();
    final Color onTertiary = getTextColor(tertiary);

    if (isDark) {
      // Update color settings //

      await loadColorScheme(
        ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: primary,
          primary: primary,
          primaryContainer:
              primary.withValues(alpha: defaultButtonOutlineOpacity),
          onPrimary: onPrimary,
          onPrimaryContainer: onPrimary,
          secondary: secondary,
          secondaryContainer:
              secondary.withValues(alpha: defaultButtonOutlineOpacity),
          onSecondary: onSecondary,
          onSecondaryContainer: onSecondary,
          tertiary: tertiary,
          tertiaryContainer:
              tertiary.withValues(alpha: defaultButtonOutlineOpacity),
          onTertiary: onTertiary,
          onTertiaryContainer: onTertiary,
          onSurface: Colors.white,
          surfaceTint: Colors.transparent,
        ),
        Brightness.dark,
      );

      // Update design settings //

      await setInt(darkAnimationDurationKey, random.nextInt(1000));
      await setString(
          darkTransitionTypeKey,
          EzPageTransition
              .values[random.nextInt(EzPageTransition.values.length)].value);
      await setBool(darkTransitionFadeKey, random.nextBool());

      await setDouble(darkButtonOpacityKey, random.nextDouble());
      await setDouble(darkButtonOutlineOpacityKey, random.nextDouble());

      // Update layout settings //

      await setDouble(darkMarginKey, defaultMargin * getScalar());
      await setDouble(
        darkPaddingKey,
        (onMobile ? defaultMobilePadding : defaultDesktopPadding) * getScalar(),
      );
      await setDouble(
        darkSpacingKey,
        (onMobile ? defaultMobileSpacing : defaultDesktopSpacing) * getScalar(),
      );

      await setBool(darkHideScrollKey, random.nextBool());

      // Update text settings //

      final List<String> styleOptions = googleStyles.keys.toList();

      final String attentionStyle =
          styleOptions[random.nextInt(styleOptions.length)];
      final double attentionScale = getScalar();

      final String descriptionStyle =
          styleOptions[random.nextInt(styleOptions.length)];
      final double descriptionScale = getScalar();

      await setString(darkDisplayFontFamilyKey, attentionStyle);
      await setDouble(
        darkDisplayFontSizeKey,
        defaultDisplaySize * attentionScale,
      );
      await setBool(darkDisplayBoldedKey, false);
      await setBool(darkDisplayItalicizedKey, false);
      await setBool(darkDisplayUnderlinedKey, random.nextBool());
      await setDouble(darkDisplayFontHeightKey, defaultFontHeight);
      await setDouble(darkDisplayLetterSpacingKey, defaultLetterSpacing);
      await setDouble(darkDisplayWordSpacingKey, defaultWordSpacing);

      await setString(darkHeadlineFontFamilyKey, attentionStyle);
      await setDouble(
        darkHeadlineFontSizeKey,
        defaultHeadlineSize * attentionScale,
      );
      await setBool(darkHeadlineBoldedKey, false);
      await setBool(darkHeadlineItalicizedKey, false);
      await setBool(darkHeadlineUnderlinedKey, false);
      await setDouble(darkHeadlineFontHeightKey, defaultFontHeight);
      await setDouble(darkHeadlineLetterSpacingKey, defaultLetterSpacing);
      await setDouble(darkHeadlineWordSpacingKey, defaultWordSpacing);

      await setString(
        darkTitleFontFamilyKey,
        styleOptions[random.nextInt(styleOptions.length)],
      );
      await setDouble(darkTitleFontSizeKey, defaultTitleSize * attentionScale);
      await setBool(darkTitleBoldedKey, false);
      await setBool(darkTitleItalicizedKey, false);
      await setBool(darkTitleUnderlinedKey, random.nextBool());
      await setDouble(darkTitleFontHeightKey, defaultFontHeight);
      await setDouble(darkTitleLetterSpacingKey, defaultLetterSpacing);
      await setDouble(darkTitleWordSpacingKey, defaultWordSpacing);

      await setString(darkBodyFontFamilyKey, descriptionStyle);
      await setDouble(darkBodyFontSizeKey, defaultBodySize * descriptionScale);
      await setBool(darkBodyBoldedKey, false);
      await setBool(darkBodyItalicizedKey, false);
      await setBool(darkBodyUnderlinedKey, false);
      await setDouble(darkBodyFontHeightKey, defaultFontHeight);
      await setDouble(darkBodyLetterSpacingKey, defaultLetterSpacing);
      await setDouble(darkBodyWordSpacingKey, defaultWordSpacing);

      await setString(darkLabelFontFamilyKey, descriptionStyle);
      await setDouble(
        darkLabelFontSizeKey,
        defaultLabelSize * descriptionScale,
      );
      await setBool(darkLabelBoldedKey, false);
      await setBool(darkLabelItalicizedKey, false);
      await setBool(darkLabelUnderlinedKey, false);
      await setDouble(darkLabelFontHeightKey, defaultFontHeight);
      await setDouble(darkLabelLetterSpacingKey, defaultLetterSpacing);
      await setDouble(darkLabelWordSpacingKey, defaultWordSpacing);

      // Leave text background opacity as-is

      await setDouble(darkIconSizeKey, defaultIconSize * getScalar());
    } else {
      // Update color settings //

      await loadColorScheme(
        ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: primary,
          primary: primary,
          primaryContainer:
              primary.withValues(alpha: defaultButtonOutlineOpacity),
          onPrimary: onPrimary,
          onPrimaryContainer: onPrimary,
          secondary: secondary,
          secondaryContainer:
              secondary.withValues(alpha: defaultButtonOutlineOpacity),
          onSecondary: onSecondary,
          onSecondaryContainer: onSecondary,
          tertiary: tertiary,
          tertiaryContainer:
              tertiary.withValues(alpha: defaultButtonOutlineOpacity),
          onTertiary: onTertiary,
          onTertiaryContainer: onTertiary,
          onSurface: Colors.black,
          surfaceTint: Colors.transparent,
        ),
        Brightness.light,
      );

      // Update design settings //

      await setInt(lightAnimationDurationKey, random.nextInt(1000));
      await setString(
          lightTransitionTypeKey,
          EzPageTransition
              .values[random.nextInt(EzPageTransition.values.length)].value);
      await setBool(lightTransitionFadeKey, random.nextBool());

      await setDouble(lightButtonOpacityKey, random.nextDouble());
      await setDouble(lightButtonOutlineOpacityKey, random.nextDouble());

      // Update layout settings //

      await setDouble(lightMarginKey, defaultMargin * getScalar());
      await setDouble(
        lightPaddingKey,
        (onMobile ? defaultMobilePadding : defaultDesktopPadding) * getScalar(),
      );
      await setDouble(
        lightSpacingKey,
        (onMobile ? defaultMobileSpacing : defaultDesktopSpacing) * getScalar(),
      );

      await setBool(lightHideScrollKey, random.nextBool());

      // Update text settings //

      final List<String> styleOptions = googleStyles.keys.toList();

      final String attentionStyle =
          styleOptions[random.nextInt(styleOptions.length)];
      final double attentionScale = getScalar();

      final String descriptionStyle =
          styleOptions[random.nextInt(styleOptions.length)];
      final double descriptionScale = getScalar();

      await setString(lightDisplayFontFamilyKey, attentionStyle);
      await setDouble(
        lightDisplayFontSizeKey,
        defaultDisplaySize * attentionScale,
      );
      await setBool(lightDisplayBoldedKey, false);
      await setBool(lightDisplayItalicizedKey, false);
      await setBool(lightDisplayUnderlinedKey, random.nextBool());
      await setDouble(lightDisplayFontHeightKey, defaultFontHeight);
      await setDouble(lightDisplayLetterSpacingKey, defaultLetterSpacing);
      await setDouble(lightDisplayWordSpacingKey, defaultWordSpacing);

      await setString(lightHeadlineFontFamilyKey, attentionStyle);
      await setDouble(
        lightHeadlineFontSizeKey,
        defaultHeadlineSize * attentionScale,
      );
      await setBool(lightHeadlineBoldedKey, false);
      await setBool(lightHeadlineItalicizedKey, false);
      await setBool(lightHeadlineUnderlinedKey, false);
      await setDouble(lightHeadlineFontHeightKey, defaultFontHeight);
      await setDouble(lightHeadlineLetterSpacingKey, defaultLetterSpacing);
      await setDouble(lightHeadlineWordSpacingKey, defaultWordSpacing);

      await setString(
        lightTitleFontFamilyKey,
        styleOptions[random.nextInt(styleOptions.length)],
      );
      await setDouble(lightTitleFontSizeKey, defaultTitleSize * attentionScale);
      await setBool(lightTitleBoldedKey, false);
      await setBool(lightTitleItalicizedKey, false);
      await setBool(lightTitleUnderlinedKey, random.nextBool());
      await setDouble(lightTitleFontHeightKey, defaultFontHeight);
      await setDouble(lightTitleLetterSpacingKey, defaultLetterSpacing);
      await setDouble(lightTitleWordSpacingKey, defaultWordSpacing);

      await setString(lightBodyFontFamilyKey, descriptionStyle);
      await setDouble(lightBodyFontSizeKey, defaultBodySize * descriptionScale);
      await setBool(lightBodyBoldedKey, false);
      await setBool(lightBodyItalicizedKey, false);
      await setBool(lightBodyUnderlinedKey, false);
      await setDouble(lightBodyFontHeightKey, defaultFontHeight);
      await setDouble(lightBodyLetterSpacingKey, defaultLetterSpacing);
      await setDouble(lightBodyWordSpacingKey, defaultWordSpacing);

      await setString(lightLabelFontFamilyKey, descriptionStyle);
      await setDouble(
        lightLabelFontSizeKey,
        defaultLabelSize * descriptionScale,
      );
      await setBool(lightLabelBoldedKey, false);
      await setBool(lightLabelItalicizedKey, false);
      await setBool(lightLabelUnderlinedKey, false);
      await setDouble(lightLabelFontHeightKey, defaultFontHeight);
      await setDouble(lightLabelLetterSpacingKey, defaultLetterSpacing);
      await setDouble(lightLabelWordSpacingKey, defaultWordSpacing);

      // Leave text background opacity as-is

      await setDouble(lightIconSizeKey, defaultIconSize * getScalar());
    }
  }

  //* Removers *//

  /// Remove the custom value for [key]
  /// When [reset] is true, the default value is restored (if present)
  /// By default, both the live and [SharedPreferencesAsync] values are modified
  /// Setting [storageOnly] to true will make [reset] moot

  static Future<bool> remove(
    String key, {
    bool reset = true,
    bool storageOnly = false,
  }) async {
    try {
      await _instance!._preferences.remove(key);
      if (!storageOnly) {
        (reset && _instance!._defaults.containsKey(key))
            ? _instance!._prefs[key] = _instance!._defaults[key]
            : _instance!._prefs.remove(key);
      }

      return true;
    } catch (e) {
      ezLog('Error removing key [$key]...\n$e');
      return false;
    }
  }

  /// Remove the [keys] custom values
  /// When [reset] is true, the default value is restored (if present)
  /// By default, both the live and [SharedPreferencesAsync] values are modified
  /// Setting [storageOnly] to true will make [reset] moot
  /// Returns false if any keys fail to be removed, but all keys will be attempted
  static Future<bool> removeKeys(
    Set<String> keys, {
    bool reset = true,
    bool storageOnly = false,
  }) async {
    bool success = true;
    for (final String key in keys) {
      success &= await remove(
        key,
        reset: reset,
        storageOnly: storageOnly,
      );
    }

    return success;
  }

  /// [removeKeys], all (except those in [skip])
  /// [skip] defaults to [appLocaleKey]
  static Future<bool> reset(
    bool bothThemes, {
    Set<String>? skip = const <String>{appLocaleKey},
    bool reset = true,
    bool storageOnly = false,
  }) async {
    final Set<String> keys = Set<String>.from(_instance!._prefs.keys);
    if (skip != null) keys.removeAll(skip);

    if (!bothThemes) {
      EzConfig.isDark
          ? keys.removeWhere((String key) => key.startsWith('light'))
          : keys.removeWhere((String key) => key.startsWith('dark'));
    }

    bool success = true;
    for (final String key in keys) {
      success &= await remove(
        key,
        reset: reset,
        storageOnly: storageOnly,
      );
    }
    return success;
  }

  //* Provider aliases *//
  // Getters //

  /// Active [EzConfigProvider]
  /// "Internal" use only; easier to have all pointers in one place
  static EzConfigProvider get _provPoint => _instance!._provider!;

  /// Current [TargetPlatform]
  static TargetPlatform get platform => _provPoint.platform;

  /// Whether the app is running on a mobile device
  static bool get onMobile => _provPoint.onMobile;

  /// Tracks major changes to the config
  static int get seed => _provPoint.seed;

  /// Active [Locale]
  static Locale get locale => _provPoint.locale;

  /// EFUI localizations
  static EFUILang get l10n => _provPoint.l10n;

  /// Whether the active [Locale] is a left-to-right language
  static bool get isLTR => _provPoint.isLTR;

  /// Active [ThemeMode]
  static ThemeMode get themeMode => _provPoint.themeMode;

  /// Whether the active [ThemeMode] is [Brightness.dark]
  static bool get isDark => _provPoint.isDark;

  /// Current, [ThemeMode] aware, [ColorScheme]
  static ColorScheme get colorScheme => _provPoint.theme.colorScheme;

  /// Current, [ThemeMode] aware, [ColorScheme]
  /// [colorScheme] alias
  static ColorScheme get colors => _provPoint.theme.colorScheme;

  /// Current, [ThemeMode] aware, [TextTheme]
  static TextTheme get textTheme => _provPoint.theme.textTheme;

  /// Current, [ThemeMode] aware, [TextTheme]
  /// [textTheme] alias
  static TextTheme get styles => _provPoint.theme.textTheme;

  /// Theme aware alias
  static int get animDur => _provPoint.design.animDur;

  /// Theme aware alias
  static double get marginVal => _provPoint.layout.marginVal;

  /// Theme aware alias
  static double get padding => _provPoint.layout.padding;

  /// Theme aware alias
  static double get spacing => _provPoint.layout.spacing;

  /// Theme aware alias
  static EzMargin get margin => _provPoint.layout.margin;

  /// Theme aware alias
  static EzMargin get rowMargin => _provPoint.layout.rowMargin;

  /// Theme aware alias
  static EzSpacer get spacer => _provPoint.layout.spacer;

  /// Theme aware alias
  static EzSpacer get rowSpacer => _provPoint.layout.rowSpacer;

  /// Theme aware alias
  static EzSeparator get separator => _provPoint.layout.separator;

  /// Theme aware alias
  static EzDivider get divider => _provPoint.layout.divider;

  /// Theme aware alias
  static bool get hideScroll => _provPoint.layout.hideScroll;

  /// Theme aware alias
  static double get iconSize => _provPoint.text.iconSize;

  /// Theme aware alias
  static EzNewLine get startLine => _provPoint.text.startLine;

  /// Theme aware alias
  static EzNewLine get centerLine => _provPoint.text.centerLine;

  /// Theme aware alias
  static EzNewLine get endLine => _provPoint.text.endLine;

  static EzAppCache? get appCache => _provPoint.appCache;

  // Setters //

  /// Set the apps [Locale] from storage and load corresponding localizations
  /// If unsure, we recommend [onComplete] to be setState((){})
  /// Or [doNothing] for [StatelessWidget]s
  static Future<void> rebuildLocale(void Function() onComplete) =>
      _provPoint.rebuildLocale(onComplete);

  /// Reconfigure [ThemeMode] et al. from storage and [redrawUI] with [onComplete]
  /// If unsure, we recommend [onComplete] to be setState((){})
  /// Or [doNothing] for [StatelessWidget]s
  static Future<void> rebuildThemeMode(void Function() onComplete) =>
      _provPoint.rebuildThemeMode(onComplete);

  /// Rebuilds the apps [ThemeMode], [ThemeData], and updates the config caches
  /// Then calls [redrawUI] with [onComplete]
  /// If unsure, we recommend [onComplete] to be setState((){})
  /// Or [doNothing] for [StatelessWidget]s
  static Future<void> rebuildUI(void Function() onComplete) =>
      _provPoint.rebuildUI(onComplete);

  /// Randomizes the [seed] and notifies listeners
  /// Optionally calls [onComplete] after notifying
  /// If unsure, we recommend [onComplete] to be setState((){})
  /// Or [doNothing] for [StatelessWidget]s
  static Future<void> redrawUI(void Function() onComplete) =>
      _provPoint.redrawUI(onComplete);

  /// Trigger [redrawUI] if/when the [ThemeMode] brightness changes
  /// Used in [EzConfigurableApp], not normally called manually
  /// For that reason, there is no passthrough for [redrawUI]
  static Future<void> redrawTheme() => _provPoint.redrawTheme();
}
