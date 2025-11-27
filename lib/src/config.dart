/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EzConfig {
  /// [SharedPreferences] instance
  final SharedPreferences preferences;

  /// Default config
  final Map<String, dynamic> defaults;

  /// Fallback [EFUILang] for unsupported [Locale]s
  /// [english] is recommended
  final EFUILang fallbackLang;

  /// [AssetImage] paths for the app
  final Set<String> assetPaths;

  /// Live values in use
  /// [defaults] merged with user [preferences]
  final Map<String, dynamic> prefs;

  /// [EzConfig] key : value runtime [Type] map
  final Map<String, Type> typeMap;

  /// Private instance
  static EzConfig? _instance;

  /// Private/internal constructor
  const EzConfig._({
    // External
    required this.preferences,
    required this.defaults,
    required this.fallbackLang,
    required this.assetPaths,

    // Internal
    required this.prefs,
    required this.typeMap,
  });

  /// [preferences] => provide a [SharedPreferences] instance
  /// [defaults] => provide your brand colors, text styles, layout settings, etc.
  /// [fallbackLang] => provide a fallback [EFUILang] for [Locale]s that [EFUILang] doesn't support (yet)
  /// [assetPaths] => provide the [AssetImage] paths for this app
  factory EzConfig.init({
    required SharedPreferences preferences,
    required Map<String, dynamic> defaults,
    required EFUILang fallbackLang,
    required Set<String> assetPaths,
  }) {
    if (_instance == null) {
      // Get the value type for each key //

      // Start with the known EzConfigverse
      final Map<String, Type> typeMap = Map<String, Type>.from(ezConfigKeys);

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
          preferences.getKeys().intersection(typeMap.keys.toSet());

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
        assetPaths: assetPaths,
        defaults: defaults,
        fallbackLang: fallbackLang,
        preferences: preferences,
        prefs: prefs,
        typeMap: typeMap,
      );
    }

    return _instance!;
  }

  // No null checks below, for expediency
  // EFUI won't work at all if EzConfig isn't initialized, so they're moot

  // Getters //

  static EFUILang get l10nFallback => _instance!.fallbackLang;

  /// Get the [key]s EzConfig (nullable) value
  /// Uses the live values from [prefs], falling back to [defaults]
  static dynamic get(String key) {
    return _instance!.prefs[key] ?? _instance!.defaults[key];
  }

  /// Get the [key]s default EzConfig (nullable) value
  static dynamic getDefault(String key) {
    return _instance!.defaults[key];
  }

  /// Return the user's selected [Locale], if any
  /// null otherwise
  static Locale? getLocale() {
    final List<String>? localeData = _instance!.prefs[appLocaleKey];

    if (localeData == null) {
      return null;
    } else {
      return Locale(
        localeData[0],
        (localeData.length > 1) ? localeData[1] : null,
      );
    }
  }

  /// Return the user's selected [ThemeMode]
  static ThemeMode getThemeMode() {
    final bool? isDarkTheme = _instance!.prefs[isDarkThemeKey];

    if (isDarkTheme == null) {
      return ThemeMode.system;
    } else {
      return isDarkTheme ? ThemeMode.dark : ThemeMode.light;
    }
  }

  /// Get the [key]s EzConfig (nullable) [bool] value
  /// Uses the stored values from [EzConfig.preferences]
  static bool? getBool(String key) {
    return _instance!.preferences.getBool(key);
  }

  /// Get the [key]s EzConfig (nullable) [int] value
  /// Uses the stored values from [EzConfig.preferences]
  static int? getInt(String key) {
    return _instance!.preferences.getInt(key);
  }

  /// Get the [key]s EzConfig (nullable) [double] value
  /// Uses the stored values from [EzConfig.preferences]
  static double? getDouble(String key) {
    return _instance!.preferences.getDouble(key);
  }

  /// Get the [key]s EzConfig (nullable) [String] value
  /// Uses the stored values from [EzConfig.preferences]
  static String? getString(String key) {
    return _instance!.preferences.getString(key);
  }

  /// Get the [key]s EzConfig (nullable) [List] value
  /// Uses the stored values from [EzConfig.preferences]
  static List<String>? getStringList(String key) {
    return _instance!.preferences.getStringList(key);
  }

  /// Wether the [key] points to an [AssetImage] path
  /// via [assetPaths]
  static bool isKeyAsset(String key) {
    return _instance!.assetPaths.contains(_instance!.prefs[key]);
  }

  /// Wether the [path] leads to an [AssetImage]
  /// via [assetPaths]
  static bool isPathAsset(String path) {
    return _instance!.assetPaths.contains(path);
  }

  // Setters //

  /// Set the EzConfig [key] to [value] with type [bool]
  /// Defaults to both the live [EzConfig.prefs] and stored [EzConfig.preferences]
  /// Optionally set [storageOnly] to true to only update [EzConfig.preferences]
  static Future<bool> setBool(
    String key,
    bool value, {
    bool storageOnly = false,
  }) async {
    final bool result = await _instance!.preferences.setBool(key, value);
    if (result && !storageOnly) _instance!.prefs[key] = value;
    return result;
  }

  /// Set the EzConfig [key] to [value] with type [int]
  /// Defaults to both the live [EzConfig.prefs] and stored [EzConfig.preferences]
  /// Optionally set [storageOnly] to true to only update [EzConfig.preferences]
  static Future<bool> setInt(
    String key,
    int value, {
    bool storageOnly = false,
  }) async {
    final bool result = await _instance!.preferences.setInt(key, value);
    if (result && !storageOnly) _instance!.prefs[key] = value;
    return result;
  }

  /// Set the EzConfig [key] to [value] with type [double]
  /// Defaults to both the live [EzConfig.prefs] and stored [EzConfig.preferences]
  /// Optionally set [storageOnly] to true to only update [EzConfig.preferences]
  static Future<bool> setDouble(
    String key,
    double value, {
    bool storageOnly = false,
  }) async {
    final bool result = await _instance!.preferences.setDouble(key, value);
    if (result && !storageOnly) _instance!.prefs[key] = value;
    return result;
  }

  /// Set the EzConfig [key] to [value] with type [String]
  /// Defaults to both the live [EzConfig.prefs] and stored [EzConfig.preferences]
  /// Optionally set [storageOnly] to true to only update [EzConfig.preferences]
  static Future<bool> setString(
    String key,
    String value, {
    bool storageOnly = false,
  }) async {
    final bool result = await _instance!.preferences.setString(key, value);
    if (result && !storageOnly) _instance!.prefs[key] = value;
    return result;
  }

  /// Set the EzConfig [key] to [value] with type [List]
  /// Defaults to both the live [EzConfig.prefs] and stored [EzConfig.preferences]
  /// Optionally set [storageOnly] to true to only update [EzConfig.preferences]
  static Future<bool> setStringList(
    String key,
    List<String> value, {
    bool storageOnly = false,
  }) async {
    final bool result = await _instance!.preferences.setStringList(key, value);
    if (result && !storageOnly) _instance!.prefs[key] = value;
    return result;
  }

  /// Load values to [prefs]/[preferences]
  static Future<void> loadConfig(
    Map<String, dynamic> config, {
    Set<String>? filter,
  }) async {
    for (final MapEntry<String, dynamic> entry in config.entries) {
      // Check filter
      if (filter != null && filter.contains(entry.key)) {
        ezLog('Filtering [${entry.key}]');
        continue;
      }

      // Check type
      final dynamic expectedType = _instance!.typeMap[entry.key];
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
          await setBool(entry.key, entry.value);
          break;
        case const (int):
          await setInt(entry.key, entry.value);
        case const (double):
          await setDouble(entry.key, entry.value);
        case const (String):
          await setString(entry.key, entry.value);
          break;
        case const (List<String>):
          await setStringList(entry.key, entry.value);
          break;
      }
    }
  }

  /// Create a pseudo-random config that follows the default vibe
  /// i.e. a triadic [ColorScheme] that should be highly legible
  /// Doubles are limited to half and/or twice their default values'
  /// There is an optional [shiny] chance (1 in 4096) to change the [Locale]
  static Future<void> randomize(bool isDark, {bool shiny = true}) async {
    // Define data //

    final Random random = Random();
    final bool onMobile = isMobile();

    double getScalar() => (random.nextDouble() * 1.5) + 0.5;

    // Update global settings //

    // Lefty
    await setBool(isLeftyKey, random.nextBool());

    // Leave theme as-is, don't wanna light blast peeps at night

    // Locale
    if (shiny && random.nextInt(4096) == 376) {
      final List<Locale> trimmedLocales =
          List<Locale>.from(EFUILang.supportedLocales);
      trimmedLocales.remove(getLocale());

      final Locale randomLocale =
          trimmedLocales.elementAt(random.nextInt(trimmedLocales.length));

      final List<String> localeData = <String>[randomLocale.languageCode];
      if (randomLocale.countryCode != null) {
        localeData.add(randomLocale.countryCode!);
      }

      await setStringList(appLocaleKey, localeData);
    }

    // Update color settings //

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

    // Create a pseudo-random ColorScheme that follows the default vibe
    await storeColorScheme(
      colorScheme: isDark
          ? ColorScheme.fromSeed(
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
            )
          : ColorScheme.fromSeed(
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
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    // Update design settings //

    await setInt(animationDurationKey, random.nextInt(500) + 250);

    await setDouble(
      isDark ? darkButtonOpacityKey : lightButtonOpacityKey,
      random.nextDouble(),
    );
    await setDouble(
      isDark ? darkButtonOutlineOpacityKey : lightButtonOutlineOpacityKey,
      random.nextDouble(),
    );

    // Update layout settings //

    await setDouble(marginKey, defaultMargin * getScalar());
    await setDouble(
      paddingKey,
      (onMobile ? defaultMobilePadding : defaultDesktopPadding) * getScalar(),
    );
    await setDouble(
      spacingKey,
      (onMobile ? defaultMobileSpacing : defaultDesktopSpacing) * getScalar(),
    );

    await setBool(hideScrollKey, random.nextBool());

    // Update text settings //

    final List<String> styleOptions = googleStyles.keys.toList();

    final String attentionStyle =
        styleOptions[random.nextInt(styleOptions.length)];
    final double attentionScale = getScalar();

    final String descriptionStyle =
        styleOptions[random.nextInt(styleOptions.length)];
    final double descriptionScale = getScalar();

    await setString(displayFontFamilyKey, attentionStyle);
    await setDouble(displayFontSizeKey, defaultDisplaySize * attentionScale);
    await setBool(displayBoldedKey, false);
    await setBool(displayItalicizedKey, false);
    await setBool(displayUnderlinedKey, random.nextBool());
    await setDouble(displayFontHeightKey, defaultFontHeight);
    await setDouble(displayLetterSpacingKey, defaultLetterSpacing);
    await setDouble(displayWordSpacingKey, defaultWordSpacing);

    await setString(headlineFontFamilyKey, attentionStyle);
    await setDouble(headlineFontSizeKey, defaultHeadlineSize * attentionScale);
    await setBool(headlineBoldedKey, false);
    await setBool(headlineItalicizedKey, false);
    await setBool(headlineUnderlinedKey, false);
    await setDouble(headlineFontHeightKey, defaultFontHeight);
    await setDouble(headlineLetterSpacingKey, defaultLetterSpacing);
    await setDouble(headlineWordSpacingKey, defaultWordSpacing);

    await setString(
        titleFontFamilyKey, styleOptions[random.nextInt(styleOptions.length)]);
    await setDouble(titleFontSizeKey, defaultTitleSize * attentionScale);
    await setBool(titleBoldedKey, false);
    await setBool(titleItalicizedKey, false);
    await setBool(titleUnderlinedKey, random.nextBool());
    await setDouble(titleFontHeightKey, defaultFontHeight);
    await setDouble(titleLetterSpacingKey, defaultLetterSpacing);
    await setDouble(titleWordSpacingKey, defaultWordSpacing);

    await setString(bodyFontFamilyKey, descriptionStyle);
    await setDouble(bodyFontSizeKey, defaultBodySize * descriptionScale);
    await setBool(bodyBoldedKey, false);
    await setBool(bodyItalicizedKey, false);
    await setBool(bodyUnderlinedKey, false);
    await setDouble(bodyFontHeightKey, defaultFontHeight);
    await setDouble(bodyLetterSpacingKey, defaultLetterSpacing);
    await setDouble(bodyWordSpacingKey, defaultWordSpacing);

    await setString(labelFontFamilyKey, descriptionStyle);
    await setDouble(labelFontSizeKey, defaultLabelSize * descriptionScale);
    await setBool(labelBoldedKey, false);
    await setBool(labelItalicizedKey, false);
    await setBool(labelUnderlinedKey, false);
    await setDouble(labelFontHeightKey, defaultFontHeight);
    await setDouble(labelLetterSpacingKey, defaultLetterSpacing);
    await setDouble(labelWordSpacingKey, defaultWordSpacing);

    // Leave text background opacity as-is

    await setDouble(iconSizeKey, defaultIconSize * getScalar());
  }

  // Removers //

  /// Remove the custom value for [key]
  /// When [reset] is true, the default value is restored (if present)
  /// By default, both the live [EzConfig.prefs] and stored [EzConfig.preferences] values are updated
  /// Set [storageOnly] to true to only update [EzConfig.preferences]
  /// Setting [storageOnly] to true will make [reset] moot
  static Future<bool> remove(
    String key, {
    bool reset = true,
    bool storageOnly = false,
  }) async {
    final bool result = await _instance!.preferences.remove(key);

    if (result && !storageOnly) {
      (reset && _instance!.defaults.containsKey(key))
          ? _instance!.prefs[key] = _instance!.defaults[key]
          : _instance!.prefs.remove(key);
    }

    return result;
  }

  /// Remove the [keys] custom values
  /// When [reset] is true, the default value is restored (if present)
  /// By default, both the live [EzConfig.prefs] and stored [EzConfig.preferences] values are updated
  /// Set [storageOnly] to true to only update [EzConfig.preferences]
  /// Setting [storageOnly] to true will make [reset] moot
  /// Returns false if any keys fail to be removed, but all keys will be attempted
  static Future<bool> removeKeys(
    Set<String> keys, {
    bool reset = true,
    bool storageOnly = false,
  }) async {
    bool success = true;

    for (final String key in keys) {
      final bool result = await _instance!.preferences.remove(key);

      if (result) {
        if (!storageOnly) {
          (reset && _instance!.defaults.containsKey(key))
              ? _instance!.prefs[key] = _instance!.defaults[key]
              : _instance!.prefs.remove(key);
        }
      } else {
        success = false;
        ezLog('Failed to remove key [$key]');
      }
    }

    return success;
  }

  /// Resets all keys in [EzConfig.prefs]
  /// By default, both the live [EzConfig.prefs] and stored [EzConfig.preferences] values are updated
  /// Set [storageOnly] to true to only update [EzConfig.preferences]
  /// Returns false if any keys fail to be reset, but all keys will be attempted
  static Future<bool> reset({
    Set<String>? skip,
    bool storageOnly = false,
  }) async {
    bool success = true;
    final List<String> itr = List<String>.from(_instance!.prefs.keys);

    for (final String key in itr) {
      if (skip?.contains(key) ?? false) continue;
      final bool result = await _instance!.preferences.remove(key);

      if (result) {
        if (!storageOnly) {
          _instance!.defaults.containsKey(key)
              ? _instance!.prefs[key] = _instance!.defaults[key]
              : _instance!.prefs.remove(key);
        }
      } else {
        success = false;
        ezLog('Failed to remove key [$key]');
      }
    }

    return success;
  }
}
