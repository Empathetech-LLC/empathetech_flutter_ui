library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Hand {
  right,
  left,
}

/// Static object for managing a dynamic && user customizable UI
/// Tracks the apps [FocusManager] for keyboard management
/// Setting are tracked with shared_preferences
class EzConfig {
  static late List<String> assets;
  static late SharedPreferences preferences;
  static late Map<String, dynamic> prefs;
  static late FocusManager focus;
  static late bool lightTheme;
  static late Hand dominantSide;

  static Map<String, dynamic> defaults = {
    // Shared
    marginKey: 15.0,
    paddingKey: 12.5,
    fontFamilyKey: 'Roboto',
    fontScalarKey: 1,
    alertColorKey:
        0xFFDAA520, // Goldenrod (one of Empathetech's triadic colors)
    lightButtonColorKey:
        0xE620DAA5, // Eucalyptus (one of Empathetech's triadic colors)
    lightButtonTextColorKey: 0xFF000000, // Black text
    darkButtonColorKey: 0xE620DAA5, // Same as light
    darkButtonTextColorKey: 0xFF000000, // Ditto
    buttonSpacingKey: 35.0,
    dialogSpacingKey: 20.0,
    paragraphSpacingKey: 50,

    // Light theme
    lightBackgroundImage: null,
    lightBackgroundColorKey: 0xFFEBEBEB, // Almost white
    lightThemeColorKey: 0xFFEBEBEB, // Almost white
    lightThemeTextColorKey: 0xFF000000, // Black text

    // Dark theme
    darkBackgroundImage: null,
    darkBackgroundColorKey: 0xFF141414, // Almost black
    darkThemeColorKey: 0xFF141414, // Almost black
    darkThemeTextColorKey: 0xFFFFFFFF, // White text
  };

  /// Populate [EzConfig.prefs], overwriting defaults whenever a user value is found
  /// Optionally expand the user customizable values with [customDefaults]
  static void init({
    required List<String> assetPaths,
    Map<String, dynamic>? customDefaults,
    List<DeviceOrientation>? orientations,
  }) async {
    List<DeviceOrientation> allOptions = [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ];
    SystemChrome.setPreferredOrientations(orientations ?? allOptions);

    focus = FocusManager.instance;
    preferences = await SharedPreferences.getInstance();

    // Load asset paths
    assets = assetPaths;

    // Load any custom defaults
    if (customDefaults != null) defaults.addAll(customDefaults);

    // Start prefs from a deep copy of all defaults
    prefs = new Map.from(defaults);

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

    // Set the theme
    lightTheme = preferences.getBool(isLightKey) ??
        (ThemeMode.system == ThemeMode.light);

    bool? isLefty = preferences.getBool(isLeftyKey);

    dominantSide =
        (isLefty == null || isLefty == false) ? Hand.right : Hand.left;
  }
}

// Preference keys //

// Shared

const String noBackgroundImage = 'noImage';

const String marginKey = 'margin';
const String paddingKey = 'padding';

const String fontFamilyKey = 'fontFamily';
const String fontScalarKey = 'fontScalar';

const String alertColorKey = 'alertColor';

const String buttonSpacingKey = 'buttonSpacing';
const String dialogSpacingKey = 'dialogSpacing';
const String paragraphSpacingKey = 'paragraphSpacing';

// Theme dependent

// Light
const String isLightKey = 'isLight';
const String isLeftyKey = 'isLefty';

const String lightBackgroundImage = 'lightBackImage';
const String lightBackgroundColorKey = 'lightBackgroundColor';
const String lightThemeColorKey = 'lightThemeColor';
const String lightThemeTextColorKey = 'lightThemeTextColor';

// Dark
const String darkBackgroundImage = 'darkBackImage';
const String darkBackgroundColorKey = 'darkBackgroundColor';
const String darkThemeColorKey = 'darkThemeColor';
const String darkThemeTextColorKey = 'darkThemeTextColor';

const String lightButtonColorKey = 'lightButtonColor';
const String darkButtonColorKey = 'darkButtonColor';

const String lightButtonTextColorKey = 'lightButtonTextColor';
const String darkButtonTextColorKey = 'darkButtonTextColor';
