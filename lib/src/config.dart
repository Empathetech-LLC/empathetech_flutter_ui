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
  final EFUILang _fallbackLang;

  /// [SharedPreferencesAsync] instance
  final SharedPreferencesAsync _preferences;

  /// Allows [EzConfig] setters to call [EzThemeProvider.rebuild]
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
    required EFUILang fallbackLang,
    required SharedPreferencesAsync preferences,
    EzThemeProvider? themeProvider,

    // Internal (built by factory)
    required Map<String, dynamic> prefs,
    required Map<String, Type> typeMap,
  })  : _assetPaths = assetPaths,
        _defaults = defaults,
        _fallbackLang = fallbackLang,
        _preferences = preferences,
        _themeProvider = themeProvider,
        _prefs = prefs,
        _typeMap = typeMap;

  /// [assetPaths] => provide the [AssetImage] paths for this app
  /// [defaults] => provide your brand colors, text styles, layout settings, etc.
  /// [fallbackLang] => provide a fallback [EFUILang] for [Locale]s that [EFUILang] doesn't support (yet)
  /// [preferences] => provide a [SharedPreferencesAsync] instance
  /// [themeProvider] => Set by [EzAppProvider], recommended to leave null unless you are not using [EzAppProvider]
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

  // Getters //
  // w/out null checks
  // EFUI won't work at all if EzConfig isn't initialized, so they're moot

  static bool get isApple => _instance!._themeProvider!.isCupertino;

  /// [EzSpacer] alias that updates alongside [EzThemeProvider]
  static EzSpacer get spacer => _instance!._themeProvider!.spacer;

  /// [EzSpacer] alias that updates alongside [EzThemeProvider]
  static EzSeparator get separator => _instance!._themeProvider!.separator;

  /// [EzSpacer] alias that updates alongside [EzThemeProvider]
  static EzDivider get divider => _instance!._themeProvider!.divider;

  /// Get the [key]s current EzConfig value
  /// bool, int, double, String, String List, or null
  static dynamic get(String key) =>
      _instance!._prefs[key] ?? _instance!._defaults[key];

  /// Quick alias for [EzConfig.get] => [isLeftyKey]
  static bool get isLefty => _instance!._prefs[isLeftyKey];

  /// Quick alias for [EzConfig.get] => [marginKey]
  static double get margin => _instance!._prefs[marginKey];

  /// Quick alias for [EzConfig.get] => [paddingKey]
  static double get padding => _instance!._prefs[paddingKey];

  /// Quick alias for [EzConfig.get] => [spacingKey]
  static double get spacing => _instance!._prefs[spacingKey];

  /// Quick alias for [EzConfig.get] => [iconSizeKey]
  static double get iconSize => _instance!._prefs[iconSizeKey];

  /// Quick alias for [EzConfig.get] => [animationDurationKey]
  static int get animDuration => _instance!._prefs[animationDurationKey];

  /// Get the [key]s default EzConfig (nullable) value
  static dynamic getDefault(String key) => _instance!._defaults[key];

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

  static EFUILang get l10nFallback => _instance!._fallbackLang;

  /// Return the user's selected [Locale], if any (null otherwise)
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

  // Setters //

  static bool setThemeProvider(EzThemeProvider themeProvider) {
    if (_instance == null || _instance!._themeProvider != null) {
      return false;
    } else {
      _instance!._themeProvider = themeProvider;
      return true;
    }
  }

  static void rebuild({void Function()? onComplete}) =>
      _instance!._themeProvider!.rebuild(onComplete: onComplete);

  /// Set the EzConfig [key] to [value] with type [bool]
  /// Defaults to both the live and [SharedPreferencesAsync] values
  static Future<bool> setBool(
    String key,
    bool value, {
    bool storageOnly = false,
    bool notifyTheme = false,
    void Function()? onNotify,
  }) async {
    try {
      await _instance!._preferences.setBool(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;

      if (notifyTheme) {
        _instance!._themeProvider!.rebuild(onComplete: onNotify);
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
    bool notifyTheme = false,
    void Function()? onNotify,
  }) async {
    try {
      await _instance!._preferences.setInt(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;

      if (notifyTheme) {
        _instance!._themeProvider!.rebuild(onComplete: onNotify);
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
    bool notifyTheme = false,
    void Function()? onNotify,
  }) async {
    try {
      await _instance!._preferences.setDouble(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;

      if (notifyTheme) {
        _instance!._themeProvider!.rebuild(onComplete: onNotify);
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
    bool notifyTheme = false,
    void Function()? onNotify,
  }) async {
    try {
      await _instance!._preferences.setString(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;

      if (notifyTheme) {
        _instance!._themeProvider!.rebuild(onComplete: onNotify);
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
    bool notifyTheme = false,
    void Function()? onNotify,
  }) async {
    try {
      await _instance!._preferences.setStringList(key, value);
      if (!storageOnly) _instance!._prefs[key] = value;

      if (notifyTheme) {
        _instance!._themeProvider!.rebuild(onComplete: onNotify);
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
    bool notifyTheme = false,
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

    if (notifyTheme) {
      _instance!._themeProvider!.rebuild(onComplete: onNotify);
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

    await setInt(
      animationDurationKey,
      random.nextInt(500) + 250,
    );

    await setDouble(
      isDark ? darkButtonOpacityKey : lightButtonOpacityKey,
      random.nextDouble(),
    );
    await setDouble(
      isDark ? darkButtonOutlineOpacityKey : lightButtonOutlineOpacityKey,
      random.nextDouble(),
    );

    // Update layout settings //

    await setDouble(
      marginKey,
      defaultMargin * getScalar(),
    );
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

    await setString(
      displayFontFamilyKey,
      attentionStyle,
    );
    await setDouble(
      displayFontSizeKey,
      defaultDisplaySize * attentionScale,
    );
    await setBool(displayBoldedKey, false);
    await setBool(displayItalicizedKey, false);
    await setBool(
      displayUnderlinedKey,
      random.nextBool(),
    );
    await setDouble(
      displayFontHeightKey,
      defaultFontHeight,
    );
    await setDouble(
      displayLetterSpacingKey,
      defaultLetterSpacing,
    );
    await setDouble(
      displayWordSpacingKey,
      defaultWordSpacing,
    );

    await setString(
      headlineFontFamilyKey,
      attentionStyle,
    );
    await setDouble(
      headlineFontSizeKey,
      defaultHeadlineSize * attentionScale,
    );
    await setBool(headlineBoldedKey, false);
    await setBool(headlineItalicizedKey, false);
    await setBool(headlineUnderlinedKey, false);
    await setDouble(
      headlineFontHeightKey,
      defaultFontHeight,
    );
    await setDouble(
      headlineLetterSpacingKey,
      defaultLetterSpacing,
    );
    await setDouble(
      headlineWordSpacingKey,
      defaultWordSpacing,
    );

    await setString(
      titleFontFamilyKey,
      styleOptions[random.nextInt(styleOptions.length)],
    );
    await setDouble(
      titleFontSizeKey,
      defaultTitleSize * attentionScale,
    );
    await setBool(titleBoldedKey, false);
    await setBool(titleItalicizedKey, false);
    await setBool(
      titleUnderlinedKey,
      random.nextBool(),
    );
    await setDouble(
      titleFontHeightKey,
      defaultFontHeight,
    );
    await setDouble(
      titleLetterSpacingKey,
      defaultLetterSpacing,
    );
    await setDouble(
      titleWordSpacingKey,
      defaultWordSpacing,
    );

    await setString(
      bodyFontFamilyKey,
      descriptionStyle,
    );
    await setDouble(
      bodyFontSizeKey,
      defaultBodySize * descriptionScale,
    );
    await setBool(bodyBoldedKey, false);
    await setBool(bodyItalicizedKey, false);
    await setBool(bodyUnderlinedKey, false);
    await setDouble(
      bodyFontHeightKey,
      defaultFontHeight,
    );
    await setDouble(
      bodyLetterSpacingKey,
      defaultLetterSpacing,
    );
    await setDouble(
      bodyWordSpacingKey,
      defaultWordSpacing,
    );

    await setString(
      labelFontFamilyKey,
      descriptionStyle,
    );
    await setDouble(
      labelFontSizeKey,
      defaultLabelSize * descriptionScale,
    );
    await setBool(labelBoldedKey, false);
    await setBool(labelItalicizedKey, false);
    await setBool(labelUnderlinedKey, false);
    await setDouble(
      labelFontHeightKey,
      defaultFontHeight,
    );
    await setDouble(
      labelLetterSpacingKey,
      defaultLetterSpacing,
    );
    await setDouble(
      labelWordSpacingKey,
      defaultWordSpacing,
    );

    // Leave text background opacity as-is

    await setDouble(
      iconSizeKey,
      defaultIconSize * getScalar(),
    );

    _instance!._themeProvider!.rebuild(onComplete: onNotify);
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
    bool notifyTheme = false,
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
        _instance!._themeProvider!.rebuild(onComplete: onNotify);
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
    bool notifyTheme = false,
    void Function()? onNotify,
  }) async {
    bool success = true;
    for (final String key in keys) {
      success &= await remove(
        key,
        reset: reset,
        storageOnly: storageOnly,
      );
    }

    if (notifyTheme) {
      _instance!._themeProvider!.rebuild(onComplete: onNotify);
    }
    return success;
  }

  /// [removeKeys], all
  static Future<bool> reset({
    Set<String>? skip,
    bool reset = true,
    bool storageOnly = false,
    bool notifyTheme = false,
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
      );
    }

    if (notifyTheme) {
      _instance!._themeProvider!.rebuild(onComplete: onNotify);
    }
    return success;
  }
}
