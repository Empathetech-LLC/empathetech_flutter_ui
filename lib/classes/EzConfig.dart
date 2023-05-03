library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Hand {
  right,
  left,
}

/// Empathetech's defaults for [EzConfig]
const Map<String, dynamic> defaultConfig = {
  // App-wide //
  marginKey: 15.0,
  paddingKey: 12.5,

  buttonSpacingKey: 30.0,
  paragraphSpacingKey: 50.0,

  fontFamilyKey: roboto,

  alertColorKey: 0xFFDAA520, // Goldenrod (one of Empathetech's triadic colors)

  lightButtonColorKey:
      0xFF20DAA5, // Eucalyptus (one of Empathetech's triadic colors)
  lightButtonTextColorKey: 0xFF000000, // Black
  darkButtonColorKey: 0xFF20DAA5,
  darkButtonTextColorKey: 0xFF000000,

  // Light theme //
  lightBackgroundImageKey: null,
  lightBackgroundColorKey: 0xFFF5F5F5, // Almost white
  lightBackgroundTextColorKey: 0xFF000000,
  lightThemeColorKey: 0xFFFFFFFF, // White
  lightThemeTextColorKey: 0xFF000000,

  // Dark theme //
  darkBackgroundImageKey: null,
  darkBackgroundColorKey: 0xFF0A0A0A, // Almost black
  darkBackgroundTextColorKey: 0xFFFFFFFF,
  darkThemeColorKey: 0xFF000000, // Black
  darkThemeTextColorKey: 0xFFFFFFFF,
};

/// Singleton class for managing a responsive and user-customizable UI
class EzConfig {
  /// [AssetImage] paths for this app
  final List<String> assets;

  final SharedPreferences preferences;

  /// [defaultConfig] merged with init's customDefaults
  final Map<String, dynamic> defaults;

  /// Top-level [preferences]
  final Map<String, dynamic> prefs;

  /// Current [googleStyles] for the app to use
  final String? fontFamily;

  /// [ThemeMode.system] wrapper that allows for overwrite
  final ThemeMode themeMode;

  /// What side of the screen touch points should be on
  final Hand dominantSide;

  // Singleton instance
  static EzConfig? _instance;

  // Private constructor
  const EzConfig._({
    required this.assets,
    required this.preferences,
    required this.defaults,
    required this.prefs,
    required this.themeMode,
    this.fontFamily,
    required this.dominantSide,
  });

  // Factory constructor
  factory EzConfig({
    required List<String> assetPaths,
    required SharedPreferences preferences,
    Map<String, dynamic>? customDefaults,
  }) {
    if (_instance == null) {
      // Load any custom defaults
      Map<String, dynamic> baseCopy = Map.from(defaultConfig);
      if (customDefaults != null) baseCopy.addAll(customDefaults);

      // Start prefs from a deep copy of all defaults
      Map<String, dynamic> prefs = new Map.from(baseCopy);

      // Load the keys that have been overwritten
      List<String> overwritten = preferences.getKeys().toList();

      overwritten.forEach((key) {
        dynamic value = prefs[key];
        dynamic userPref;

        if (value is int) {
          userPref = preferences.getInt(key);
        } else if (value is bool) {
          userPref = preferences.getBool(key);
        } else if (value is double) {
          userPref = preferences.getDouble(key);
        } else if (value is String) {
          userPref = preferences.getString(key);
        } else if (value is List<String>) {
          userPref = preferences.getStringList(key);
        }

        if (userPref != null) prefs[key] = userPref;
      });

      // Load theme setting
      bool? isLight = preferences.getBool(isLightKey);
      final ThemeMode themeMode = (isLight == null)
          ? ThemeMode.system
          : (isLight)
              ? ThemeMode.light
              : ThemeMode.dark;

      // Load hand setting
      bool? isRight = preferences.getBool(isRightKey);
      final Hand dominantSide =
          (isRight == null || isRight == true) ? Hand.right : Hand.left;

      _instance = EzConfig._(
        assets: assetPaths,
        preferences: preferences,
        defaults: baseCopy,
        prefs: prefs,
        fontFamily: googleStyles[(prefs[fontFamilyKey])]?.fontFamily,
        themeMode: themeMode,
        dominantSide: dominantSide,
      );
    }
    return _instance!;
  }

  // Get instance
  static EzConfig get instance {
    if (_instance == null) {
      throw Exception("EzConfig has not been initialized!");
    }
    return _instance!;
  }
}
