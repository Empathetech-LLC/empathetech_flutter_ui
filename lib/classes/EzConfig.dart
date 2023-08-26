/// empathetech_flutter_ui
/// Copyright (c) 2023 Empathetech LLC. All rights reserved.
/// See LICENSE for distribution and usage details.

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
  paragraphSpacingKey: 35.0,

  circleDiameterKey: 45.0,

  fontFamilyKey: roboto,

  // Light theme //
  lightThemeColorKey: whiteHex,
  lightThemeTextColorKey: blackHex,

  lightBackgroundImageKey: null,
  lightBackgroundColorKey: offWhiteHex,
  lightBackgroundTextColorKey: blackHex,

  lightButtonColorKey: EmpathPurpleHex,
  lightButtonTextColorKey: whiteHex,

  lightAccentColorKey: EmpathGoldenrodHex,
  lightAccentTextColorKey: whiteHex,

  // Dark theme //
  darkThemeColorKey: blackHex,
  darkThemeTextColorKey: whiteHex,

  darkBackgroundImageKey: null,
  darkBackgroundColorKey: offBlackHex,
  darkBackgroundTextColorKey: whiteHex,

  darkButtonColorKey: EmpathEucalyptusHex,
  darkButtonTextColorKey: blackHex,

  darkAccentColorKey: EmpathGoldenrodHex,
  darkAccentTextColorKey: whiteHex,
};

/// Singleton class for managing user customization
class EzConfig {
  /// [AssetImage] paths for this app
  final List<String> assets;

  /// [SharedPreferences] instance
  final SharedPreferences preferences;

  /// [defaultConfig] merged with the constructor provided custom defaults
  final Map<String, dynamic> defaults;

  /// Live values in use => [defaults] merged with [preferences] storage
  final Map<String, dynamic> prefs;

  /// Current [googleStyles] for the app to use
  final String? fontFamily;

  /// What side of the screen touch points should be on
  final Hand dominantSide;

  /// Private single instance
  /// The factory constructor + singleton combo requires an internally mutable [instance]
  static EzConfig? _instance;

  /// Private/internal/finalization constructor
  const EzConfig._({
    required this.assets,
    required this.preferences,
    required this.defaults,
    required this.prefs,
    this.fontFamily,
    required this.dominantSide,
  });

  /// Factory/external/initialization constructor
  factory EzConfig({
    required List<String> assetPaths,
    required SharedPreferences preferences,
    Map<String, dynamic>? customDefaults,
  }) {
    if (_instance == null) {
      // Load any custom defaults
      Map<String, dynamic> mergedDefaults = new Map.from(defaultConfig);
      if (customDefaults != null) mergedDefaults.addAll(customDefaults);

      Map<String, dynamic> prefs = new Map.from(mergedDefaults);

      // Load the keys that have been overwritten
      List<String> overwritten =
          prefs.keys.toSet().intersection(preferences.getKeys()).toList();

      overwritten.forEach((key) {
        dynamic value = prefs[key];
        dynamic userPref;

        switch (value.runtimeType) {
          case int:
            userPref = preferences.getInt(key);
            break;
          case bool:
            userPref = preferences.getBool(key);
            break;
          case double:
            userPref = preferences.getDouble(key);
            break;
          case String:
            userPref = preferences.getString(key);
            break;
          case List<String>:
            userPref = preferences.getStringList(key);
            break;
          default:
            break;
        }

        if (userPref != null) prefs[key] = userPref;
      });

      // Load hand setting
      bool? isRight = preferences.getBool(isRightKey);
      final Hand dominantSide =
          (isRight == null || isRight == true) ? Hand.right : Hand.left;

      _instance = EzConfig._(
        assets: assetPaths,
        preferences: preferences,
        defaults: mergedDefaults,
        prefs: prefs,
        fontFamily: googleStyles[(prefs[fontFamilyKey])]?.fontFamily,
        dominantSide: dominantSide,
      );
    }

    return _instance!;
  }

  /// Getter
  static EzConfig get instance {
    if (_instance == null) {
      throw Exception("EzConfig has not been initialized!");
    }
    return _instance!;
  }
}
