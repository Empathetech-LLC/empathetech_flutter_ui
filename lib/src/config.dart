/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Singleton class for managing user customization
class EzConfig {
  /// [SharedPreferences] instance
  final SharedPreferences preferences;

  /// Asset paths for the app
  /// Used for [AssetImage] and video checks
  final Set<String> assetPaths;

  /// Default config
  final Map<String, dynamic> defaults;

  /// All keys (and their value [Type]) in the known EzConfigverse
  final Map<String, Type> keys;

  /// Live values in use
  /// [defaults] merged with user [preferences]
  final Map<String, dynamic> prefs;

  /// Private instance
  static EzConfig? _instance;

  /// Private/internal constructor
  const EzConfig._({
    required this.preferences,
    required this.assetPaths,
    required this.defaults,
    required this.keys,
    required this.prefs,
  });

  /// [preferences] => provide a [SharedPreferences] instance
  /// [assetPaths] => provide your [AssetImage] paths for this app
  /// [defaults] => provide your brand colors, text styles, layout settings, etc.
  factory EzConfig.init({
    required SharedPreferences preferences,
    required Set<String> assetPaths,
    required Map<String, dynamic> defaults,
  }) {
    if (_instance == null) {
      // Build this.keys //

      // Start with the known EzConfigverse
      final Map<String, Type> keys = Map<String, Type>.from(allKeys);

      // Merge defaults
      for (final MapEntry<String, dynamic> entry in defaults.entries) {
        keys[entry.key] = entry.value.runtimeType;
      }

      // Build this.prefs //

      // Start with the defaults
      final Map<String, dynamic> prefs = Map<String, dynamic>.from(defaults);

      // Find the keys that users have overwritten
      final Set<String> overwritten =
          preferences.getKeys().intersection(keys.keys.toSet());

      // Get the updated values
      for (final String key in overwritten) {
        final Type? valueType = keys[key];
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
            debugPrint('''Key [$key] has unsupported Type [$valueType]
Must be one of [int, bool, double, String, List<String>]''');
            break;
        }

        if (userPref != null) prefs[key] = userPref;
      }

      // Build the EzConfig instance //

      _instance = EzConfig._(
        assetPaths: assetPaths,
        preferences: preferences,
        defaults: defaults,
        prefs: prefs,
        keys: keys,
      );
    }

    return _instance!;
  }

  // No null checks below, for expediency
  // EFUI won't work at all if EzConfig isn't initialized, so they're moot

  // Getters //

  /// Get the [key]s EzConfig value?
  /// Uses the live values from [prefs]
  static dynamic get(String key) {
    return _instance!.prefs[key];
  }

  /// Get the [key]s default EzConfig value?
  static dynamic getDefault(String key) {
    return _instance!.defaults[key];
  }

  /// Return the user's selected [Locale]?
  static Locale? getLocale() {
    final List<String>? localeData = _instance!.prefs[localeKey];

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

  /// Get the [key]s EzConfig value
  /// Uses the value stored in [EzConfig.preferences]
  static bool? getBool(String key) {
    return _instance!.preferences.getBool(key);
  }

  /// Get the [key]s EzConfig value
  /// Uses the value stored in [EzConfig.preferences]
  static int? getInt(String key) {
    return _instance!.preferences.getInt(key);
  }

  /// Get the [key]s EzConfig value
  /// Uses the value stored in [EzConfig.preferences]
  static double? getDouble(String key) {
    return _instance!.preferences.getDouble(key);
  }

  /// Get the [key]s EzConfig value
  /// Uses the value stored in [EzConfig.preferences]
  static String? getString(String key) {
    return _instance!.preferences.getString(key);
  }

  /// Get the [key]s EzConfig value
  /// Uses the value stored in [EzConfig.preferences]
  static List<String>? getStringList(String key) {
    return _instance!.preferences.getStringList(key);
  }

  /// Wether the [key] contains the value to a recognized asset path
  /// From the [EzConfig.init] field [assetPaths]
  static bool isKeyAsset(String key) {
    return _instance!.assetPaths.contains(_instance!.prefs[key]);
  }

  /// Wether the [path] leads to a recognized asset
  /// From the [EzConfig.init] field [assetPaths]
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

  /// Create a pseudo-random config that follows the default vibe
  static Future<void> randomize(bool isDark) async {
    final Random random = Random();

    // Update global settings //

    // Lefty
    await EzConfig.setBool(isLeftyKey, random.nextBool());

    // Leave theme as-is, don't wanna light blast peeps at night

    // Locale
    if (random.nextInt(4096) == 376) {
      final List<Locale> trimmedLocales =
          List<Locale>.from(EFUILang.supportedLocales);
      trimmedLocales.remove(EzConfig.getLocale());

      final Locale randomLocale = trimmedLocales
          .elementAt(random.nextInt(EFUILang.supportedLocales.length));

      final List<String> localeData = <String>[randomLocale.languageCode];
      if (randomLocale.countryCode != null) {
        localeData.add(randomLocale.countryCode!);
      }

      await EzConfig.setStringList(localeKey, localeData);
    }

    // Update text settings //

    final List<String> styleOptions = googleStyles.keys.toList();

    final String attentionStyle =
        styleOptions[random.nextInt(styleOptions.length)];
    final double attentionScale = (random.nextDouble() * 1.5) + 0.5;

    final String descriptionStyle =
        styleOptions[random.nextInt(styleOptions.length)];
    final double descriptionScale = (random.nextDouble() * 1.5) + 0.5;

    await EzConfig.setString(displayFontFamilyKey, attentionStyle);
    await EzConfig.setDouble(displayFontSizeKey, 42.0 * attentionScale);
    await EzConfig.setBool(displayBoldKey, false);
    await EzConfig.setBool(displayItalicsKey, false);
    await EzConfig.setBool(displayUnderlinedKey, random.nextBool());
    await EzConfig.setDouble(displayFontHeightKey, defaultFontHeight);
    await EzConfig.setDouble(displayLetterSpacingKey, defaultLetterSpacing);
    await EzConfig.setDouble(displayWordSpacingKey, defaultWordSpacing);

    await EzConfig.setString(headlineFontFamilyKey, attentionStyle);
    await EzConfig.setDouble(
        headlineFontSizeKey, defaultHeadlineSize * attentionScale);
    await EzConfig.setBool(headlineBoldKey, false);
    await EzConfig.setBool(headlineItalicsKey, false);
    await EzConfig.setBool(headlineUnderlinedKey, false);
    await EzConfig.setDouble(headlineFontHeightKey, defaultFontHeight);
    await EzConfig.setDouble(headlineLetterSpacingKey, defaultLetterSpacing);
    await EzConfig.setDouble(headlineWordSpacingKey, defaultWordSpacing);

    await EzConfig.setString(
        titleFontFamilyKey, styleOptions[random.nextInt(styleOptions.length)]);
    await EzConfig.setDouble(
        titleFontSizeKey, defaultTitleSize * attentionScale);
    await EzConfig.setBool(titleBoldKey, false);
    await EzConfig.setBool(titleItalicsKey, false);
    await EzConfig.setBool(titleUnderlinedKey, random.nextBool());
    await EzConfig.setDouble(titleFontHeightKey, defaultFontHeight);
    await EzConfig.setDouble(titleLetterSpacingKey, defaultLetterSpacing);
    await EzConfig.setDouble(titleWordSpacingKey, defaultWordSpacing);

    await EzConfig.setString(bodyFontFamilyKey, descriptionStyle);
    await EzConfig.setDouble(bodyFontSizeKey, 16.0 * descriptionScale);
    await EzConfig.setBool(bodyBoldKey, false);
    await EzConfig.setBool(bodyItalicsKey, false);
    await EzConfig.setBool(bodyUnderlinedKey, false);
    await EzConfig.setDouble(bodyFontHeightKey, defaultFontHeight);
    await EzConfig.setDouble(bodyLetterSpacingKey, defaultLetterSpacing);
    await EzConfig.setDouble(bodyWordSpacingKey, defaultWordSpacing);

    await EzConfig.setString(labelFontFamilyKey, descriptionStyle);
    await EzConfig.setDouble(labelFontSizeKey, 14.0 * descriptionScale);
    await EzConfig.setBool(labelBoldKey, false);
    await EzConfig.setBool(labelItalicsKey, false);
    await EzConfig.setBool(labelUnderlinedKey, false);
    await EzConfig.setDouble(labelFontHeightKey, defaultFontHeight);
    await EzConfig.setDouble(labelLetterSpacingKey, defaultLetterSpacing);
    await EzConfig.setDouble(labelWordSpacingKey, defaultWordSpacing);

    // Update layout settings //

    await EzConfig.setDouble(
      marginKey,
      defaultMargin * ((random.nextDouble() * 1.5) + 0.5),
    );
    await EzConfig.setDouble(
      paddingKey,
      defaultPadding * ((random.nextDouble() * 1.5) + 0.5),
    );
    await EzConfig.setDouble(
      spacingKey,
      defaultSpacing * ((random.nextDouble() * 1.5) + 0.5),
    );

    await EzConfig.setBool(hideScrollKey, random.nextBool());

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
              primaryContainer: primary.withOpacity(containerOpacity),
              onPrimary: onPrimary,
              onPrimaryContainer: onPrimary,
              secondary: secondary,
              secondaryContainer: secondary.withOpacity(containerOpacity),
              onSecondary: onSecondary,
              onSecondaryContainer: onSecondary,
              tertiary: tertiary,
              tertiaryContainer: tertiary.withOpacity(containerOpacity),
              onTertiary: onTertiary,
              onTertiaryContainer: onTertiary,
              surface: Colors.black,
              onSurface: Colors.white,
              surfaceContainer: Color.fromRGBO(
                (primary.red / 4).floor(),
                (primary.green / 4).floor(),
                (primary.blue / 4).floor(),
                1.0,
              ),
              surfaceTint: Colors.transparent,
            )
          : ColorScheme.fromSeed(
              brightness: Brightness.light,
              seedColor: primary,
              primary: primary,
              primaryContainer: primary.withOpacity(containerOpacity),
              onPrimary: onPrimary,
              onPrimaryContainer: onPrimary,
              secondary: secondary,
              secondaryContainer: secondary.withOpacity(containerOpacity),
              onSecondary: onSecondary,
              onSecondaryContainer: onSecondary,
              tertiary: tertiary,
              tertiaryContainer: tertiary.withOpacity(containerOpacity),
              onTertiary: onTertiary,
              onTertiaryContainer: onTertiary,
              surface: Colors.white,
              onSurface: Colors.black,
              surfaceContainer: Color.fromRGBO(
                ((primary.red + 765) / 4).ceil(),
                ((primary.green + 765) / 4).ceil(),
                ((primary.blue + 765) / 4).ceil(),
                1.0,
              ),
              surfaceTint: Colors.transparent,
            ),
      brightness: isDark ? Brightness.dark : Brightness.light,
    );
  }

  // Removers //

  /// Remove the custom value for [key]
  /// Defaults to both the live [EzConfig.prefs] and stored [EzConfig.preferences]
  /// Optionally set [storageOnly] to true to only update [EzConfig.preferences]
  static Future<bool> remove(String key, {bool storageOnly = false}) async {
    final bool result = await _instance!.preferences.remove(key);

    if (result && !storageOnly) {
      _instance!.defaults.containsKey(key)
          ? _instance!.prefs[key] = _instance!.defaults[key]
          : _instance!.prefs.remove(key);
    }

    return result;
  }

  /// Remove the [keys] custom values
  /// Defaults to both the live [EzConfig.prefs] and stored [EzConfig.preferences]
  /// Optionally set [storageOnly] to true to only update [EzConfig.preferences]
  static Future<bool> removeKeys(
    Set<String> keys, {
    bool storageOnly = false,
  }) async {
    bool success = true;

    for (final String key in keys) {
      final bool remove = await _instance!.preferences.remove(key);

      if (remove) {
        if (!storageOnly) {
          _instance!.defaults.containsKey(key)
              ? _instance!.prefs[key] = _instance!.defaults[key]
              : _instance!.prefs.remove(key);
        }
      } else {
        success = false;
        debugPrint('Failed to remove key [$key]');
      }
    }

    return success;
  }

  static Future<bool> reset({bool storageOnly = false}) async {
    bool success = true;

    for (final String key in _instance!.keys.keys) {
      final bool remove = await _instance!.preferences.remove(key);

      if (remove) {
        if (!storageOnly) {
          _instance!.defaults.containsKey(key)
              ? _instance!.prefs[key] = _instance!.defaults[key]
              : _instance!.prefs.remove(key);
        }
      } else {
        success = false;
        debugPrint('Failed to remove key [$key]');
      }
    }

    return success;
  }
}
