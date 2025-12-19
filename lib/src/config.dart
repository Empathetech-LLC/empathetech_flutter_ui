/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EzConfig {
  /// [AssetImage] paths for the app
  final Set<String> _assetPaths;

  /// Default config
  final Map<String, dynamic> _defaults;

  /// Fallback [EFUILang] for unsupported [Locale]s
  /// [english] or [americanEnglish] is recommended
  final EFUILang fallbackLang;

  /// [SharedPreferencesAsync] instance
  final SharedPreferencesAsync _preferences;

  /// Allows [EzConfig] setters to call [EzThemeProvider.rebuildTheme]
  EzThemeProvider? _themeProvider;

  /// Live values in use
  final Map<String, dynamic> _prefs;

  /// [EzConfig] key : value runtime [Type] map
  final Map<String, Type> _typeMap;

  /// Private instance
  static EzConfig? _instance;

  /// Private/internal constructor
  EzConfig._({
    // External (factory parameters)
    required Set<String> assetPaths,
    required Map<String, dynamic> defaults,
    required this.fallbackLang,
    required SharedPreferencesAsync preferences,
    EzThemeProvider? themeProvider,

    // Internal (built by factory)
    required Map<String, dynamic> prefs,
    required Map<String, Type> typeMap,
  })  : _assetPaths = assetPaths,
        _defaults = defaults,
        _preferences = preferences,
        _themeProvider = themeProvider,
        _prefs = prefs,
        _typeMap = typeMap;

  /// [assetPaths] => provide the [AssetImage] paths for this app
  /// [defaults] => provide your brand colors, text styles, layout settings, etc.
  /// [fallbackLang] => provide a fallback [EFUILang] for [Locale]s that [EFUILang] doesn't support (yet)
  /// [preferences] => provide a [SharedPreferencesAsync] instance
  factory EzConfig.init({
    required Set<String> assetPaths,
    required Map<String, dynamic> defaults,
    required EFUILang fallbackLang,
    required SharedPreferencesWithCache preferences,
    EzThemeProvider? themeProvider,
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
        assetPaths: assetPaths,
        defaults: defaults,
        fallbackLang: fallbackLang,
        preferences: SharedPreferencesAsync(),
        themeProvider: themeProvider,
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

  /// Get the [key]s current EzConfig value
  /// bool, int, double, String, String List, or null
  static dynamic get(String key) =>
      _instance!._prefs[key] ?? _instance!._defaults[key];

  /// Get the [key]s default EzConfig (nullable) value
  static dynamic getDefault(String key) => _instance!._defaults[key];

  /// Return the user's selected [Locale], if any
  /// null otherwise
  static Locale? getLocale() {
    final List<String>? localeData = _instance!._prefs[appLocaleKey];

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
    final bool? isDarkTheme = _instance!._prefs[isDarkThemeKey];

    if (isDarkTheme == null) {
      return ThemeMode.system;
    } else {
      return isDarkTheme ? ThemeMode.dark : ThemeMode.light;
    }
  }

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

  // Setters //

  static bool setThemeProvider(EzThemeProvider themeProvider) {
    if (_instance == null || _instance!._themeProvider != null) {
      return false;
    } else {
      _instance!._themeProvider = themeProvider;
      return true;
    }
  }

  static void rebuildTheme({void Function()? onComplete}) =>
      _instance!._themeProvider?.rebuildTheme(onComplete: onComplete);

  /// Set the EzConfig [key] to [value] with type [bool]
  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<bool> setBool(
    String key,
    bool value, {
    bool storageOnly = false,
    bool notifyTheme = true,
    void Function()? onNotify,
  }) async {
    try {
      await _instance!._preferences.setBool(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;

      if (notifyTheme) {
        _instance!._themeProvider?.rebuildTheme(onComplete: onNotify);
      }
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
    bool notifyTheme = true,
    void Function()? onNotify,
  }) async {
    try {
      await _instance!._preferences.setInt(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;

      if (notifyTheme) {
        _instance!._themeProvider?.rebuildTheme(onComplete: onNotify);
      }
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
    bool notifyTheme = true,
    void Function()? onNotify,
  }) async {
    try {
      await _instance!._preferences.setDouble(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;

      if (notifyTheme) {
        _instance!._themeProvider?.rebuildTheme(onComplete: onNotify);
      }
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
    bool notifyTheme = true,
    void Function()? onNotify,
  }) async {
    try {
      await _instance!._preferences.setString(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;

      if (notifyTheme) {
        _instance!._themeProvider?.rebuildTheme(onComplete: onNotify);
      }
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
    bool notifyTheme = true,
    void Function()? onNotify,
  }) async {
    try {
      await _instance!._preferences.setStringList(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;

      if (notifyTheme) {
        _instance!._themeProvider?.rebuildTheme(onComplete: onNotify);
      }
      return true;
    } catch (e) {
      ezLog('Error setting String List [$key]...\n$e');
      return false;
    }
  }

  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<void> loadConfig(
    Map<String, dynamic> config, {
    Set<String>? filter,
    bool storageOnly = false,
    bool notifyTheme = true,
    void Function()? onNotify,
  }) async {
    for (final MapEntry<String, dynamic> entry in config.entries) {
      // Check filter
      if (filter != null && filter.contains(entry.key)) {
        ezLog('Filtering [${entry.key}]');
        continue;
      }

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
            notifyTheme: false,
          );
          break;
        case const (int):
          await setInt(
            entry.key,
            entry.value,
            storageOnly: storageOnly,
            notifyTheme: false,
          );
        case const (double):
          await setDouble(
            entry.key,
            entry.value,
            storageOnly: storageOnly,
            notifyTheme: false,
          );
        case const (String):
          await setString(
            entry.key,
            entry.value,
            storageOnly: storageOnly,
            notifyTheme: false,
          );
          break;
        case const (List<String>):
          await setStringList(
            entry.key,
            entry.value,
            storageOnly: storageOnly,
            notifyTheme: false,
          );
          break;
      }
    }

    if (notifyTheme) {
      _instance!._themeProvider?.rebuildTheme(onComplete: onNotify);
    }
  }

  /// Create a pseudo-random config that follows the default vibe
  /// i.e. a triadic [ColorScheme] that should be highly legible
  /// Doubles are limited to half and/or twice their default values'
  /// There is an optional [shiny] chance (1 in 4096) to change the [Locale]
  static Future<void> randomize(
    bool isDark, {
    bool shiny = true,
    void Function()? onNotify,
  }) async {
    // Define data //

    final Random random = Random();
    final bool onMobile = isMobile();

    double getScalar() => (random.nextDouble() * 1.5) + 0.5;

    // Update global settings //

    // Lefty
    await setBool(isLeftyKey, random.nextBool(), notifyTheme: false);

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

      await setStringList(appLocaleKey, localeData, notifyTheme: false);
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

    await setInt(
      animationDurationKey,
      random.nextInt(500) + 250,
      notifyTheme: false,
    );

    await setDouble(
      isDark ? darkButtonOpacityKey : lightButtonOpacityKey,
      random.nextDouble(),
      notifyTheme: false,
    );
    await setDouble(
      isDark ? darkButtonOutlineOpacityKey : lightButtonOutlineOpacityKey,
      random.nextDouble(),
      notifyTheme: false,
    );

    // Update layout settings //

    await setDouble(
      marginKey,
      defaultMargin * getScalar(),
      notifyTheme: false,
    );
    await setDouble(
      paddingKey,
      (onMobile ? defaultMobilePadding : defaultDesktopPadding) * getScalar(),
      notifyTheme: false,
    );
    await setDouble(
      spacingKey,
      (onMobile ? defaultMobileSpacing : defaultDesktopSpacing) * getScalar(),
      notifyTheme: false,
    );

    await setBool(hideScrollKey, random.nextBool(), notifyTheme: false);

    // Update text settings //

    final List<String> styleOptions = googleStyles.keys.toList();

    final String attentionStyle =
        styleOptions[random.nextInt(styleOptions.length)];
    final double attentionScale = getScalar();

    final String descriptionStyle =
        styleOptions[random.nextInt(styleOptions.length)];
    final double descriptionScale = getScalar();

    await setString(
      displayFontFamilyKey,
      attentionStyle,
      notifyTheme: false,
    );
    await setDouble(
      displayFontSizeKey,
      defaultDisplaySize * attentionScale,
      notifyTheme: false,
    );
    await setBool(displayBoldedKey, false, notifyTheme: false);
    await setBool(displayItalicizedKey, false, notifyTheme: false);
    await setBool(
      displayUnderlinedKey,
      random.nextBool(),
      notifyTheme: false,
    );
    await setDouble(
      displayFontHeightKey,
      defaultFontHeight,
      notifyTheme: false,
    );
    await setDouble(
      displayLetterSpacingKey,
      defaultLetterSpacing,
      notifyTheme: false,
    );
    await setDouble(
      displayWordSpacingKey,
      defaultWordSpacing,
      notifyTheme: false,
    );

    await setString(
      headlineFontFamilyKey,
      attentionStyle,
      notifyTheme: false,
    );
    await setDouble(
      headlineFontSizeKey,
      defaultHeadlineSize * attentionScale,
      notifyTheme: false,
    );
    await setBool(headlineBoldedKey, false, notifyTheme: false);
    await setBool(headlineItalicizedKey, false, notifyTheme: false);
    await setBool(headlineUnderlinedKey, false, notifyTheme: false);
    await setDouble(
      headlineFontHeightKey,
      defaultFontHeight,
      notifyTheme: false,
    );
    await setDouble(
      headlineLetterSpacingKey,
      defaultLetterSpacing,
      notifyTheme: false,
    );
    await setDouble(
      headlineWordSpacingKey,
      defaultWordSpacing,
      notifyTheme: false,
    );

    await setString(
      titleFontFamilyKey,
      styleOptions[random.nextInt(styleOptions.length)],
      notifyTheme: false,
    );
    await setDouble(
      titleFontSizeKey,
      defaultTitleSize * attentionScale,
      notifyTheme: false,
    );
    await setBool(titleBoldedKey, false, notifyTheme: false);
    await setBool(titleItalicizedKey, false, notifyTheme: false);
    await setBool(
      titleUnderlinedKey,
      random.nextBool(),
      notifyTheme: false,
    );
    await setDouble(
      titleFontHeightKey,
      defaultFontHeight,
      notifyTheme: false,
    );
    await setDouble(
      titleLetterSpacingKey,
      defaultLetterSpacing,
      notifyTheme: false,
    );
    await setDouble(
      titleWordSpacingKey,
      defaultWordSpacing,
      notifyTheme: false,
    );

    await setString(
      bodyFontFamilyKey,
      descriptionStyle,
      notifyTheme: false,
    );
    await setDouble(
      bodyFontSizeKey,
      defaultBodySize * descriptionScale,
      notifyTheme: false,
    );
    await setBool(bodyBoldedKey, false, notifyTheme: false);
    await setBool(bodyItalicizedKey, false, notifyTheme: false);
    await setBool(bodyUnderlinedKey, false, notifyTheme: false);
    await setDouble(
      bodyFontHeightKey,
      defaultFontHeight,
      notifyTheme: false,
    );
    await setDouble(
      bodyLetterSpacingKey,
      defaultLetterSpacing,
      notifyTheme: false,
    );
    await setDouble(
      bodyWordSpacingKey,
      defaultWordSpacing,
      notifyTheme: false,
    );

    await setString(
      labelFontFamilyKey,
      descriptionStyle,
      notifyTheme: false,
    );
    await setDouble(
      labelFontSizeKey,
      defaultLabelSize * descriptionScale,
      notifyTheme: false,
    );
    await setBool(labelBoldedKey, false, notifyTheme: false);
    await setBool(labelItalicizedKey, false, notifyTheme: false);
    await setBool(labelUnderlinedKey, false, notifyTheme: false);
    await setDouble(
      labelFontHeightKey,
      defaultFontHeight,
      notifyTheme: false,
    );
    await setDouble(
      labelLetterSpacingKey,
      defaultLetterSpacing,
      notifyTheme: false,
    );
    await setDouble(
      labelWordSpacingKey,
      defaultWordSpacing,
      notifyTheme: false,
    );

    // Leave text background opacity as-is

    await setDouble(
      iconSizeKey,
      defaultIconSize * getScalar(),
      notifyTheme: false,
    );

    _instance!._themeProvider?.rebuildTheme(onComplete: onNotify);
  }

  // Removers //

  /// Remove the custom value for [key]
  /// When [reset] is true, the default value is restored (if present)
  /// By default, both the live and [SharedPreferencesAsync] values are modified
  /// Setting [storageOnly] to true will make [reset] moot
  static Future<bool> remove(
    String key, {
    bool reset = true,
    bool storageOnly = false,
    bool notifyTheme = true,
    void Function()? onNotify,
  }) async {
    try {
      await _instance!._preferences.remove(key);
      if (!storageOnly) {
        (reset && _instance!._defaults.containsKey(key))
            ? _instance!._prefs[key] = _instance!._defaults[key]
            : _instance!._prefs.remove(key);
      }

      if (notifyTheme) {
        _instance!._themeProvider?.rebuildTheme(onComplete: onNotify);
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
    bool notifyTheme = true,
    void Function()? onNotify,
  }) async {
    bool success = true;
    for (final String key in keys) {
      success &= await remove(
        key,
        reset: reset,
        storageOnly: storageOnly,
        notifyTheme: false,
      );
    }

    if (notifyTheme) {
      _instance!._themeProvider?.rebuildTheme(onComplete: onNotify);
    }
    return success;
  }

  /// [removeKeys], all
  static Future<bool> reset({
    Set<String>? skip,
    bool reset = true,
    bool storageOnly = false,
    bool notifyTheme = true,
    void Function()? onNotify,
  }) async {
    final List<String> keys = List<String>.from(_instance!._prefs.keys);

    bool success = true;
    for (final String key in keys) {
      if (skip?.contains(key) ?? false) continue;
      success &= await remove(
        key,
        reset: reset,
        storageOnly: storageOnly,
        notifyTheme: false,
      );
    }

    if (notifyTheme) {
      _instance!._themeProvider?.rebuildTheme(onComplete: onNotify);
    }
    return success;
  }
}
