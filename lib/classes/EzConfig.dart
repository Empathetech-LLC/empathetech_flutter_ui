library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Hand {
  right,
  left,
}

/// Alias for [EzConfig.focus] -> unfocus()
void closeFocus() {
  EzConfig.focus.primaryFocus?.unfocus();
}

/// Static object for managing a dynamic && user customizable UI
/// Tracks the apps image [assets] for ease of development
/// Setting are tracked with shared_preferences
/// Tracks the apps [FocusManager] for keyboard management
/// Maintains [themeMode] and [dominantSide] trackers for integrating user accessibility
class EzConfig {
  /// [AssetImage] paths for this app
  static late List<String> assets;

  static late SharedPreferences preferences;

  /// Top-level [EzConfig.preferences]
  static late Map<String, dynamic> prefs;

  /// Used to close active dialogs
  static late FocusManager focus;

  /// [ThemeMode.system] wrapper that allows for overwrite
  static late ThemeMode themeMode;

  /// []

  /// What side of the screen touch points should be on
  static late Hand dominantSide;

  static Map<String, dynamic> defaults = {
    // Shared //
    marginKey: 15.0,
    paddingKey: 12.5,

    fontFamilyKey: roboto,
    fontScalarKey: 1,

    alertColorKey:
        0xFFDAA520, // Goldenrod (one of Empathetech's triadic colors)
    lightButtonColorKey:
        0xE620DAA5, // Eucalyptus (one of Empathetech's triadic colors)
    lightButtonTextColorKey: 0xFF000000, // Black text
    darkButtonColorKey: 0xE620DAA5, // Same as light by default
    darkButtonTextColorKey: 0xFF000000,

    buttonSpacingKey: 35.0,
    dialogSpacingKey: 20.0,
    paragraphSpacingKey: 50,

    // Light theme //
    lightBackgroundImageKey: null,
    lightBackgroundColorKey: 0xFFEBEBEB, // Almost white
    lightThemeColorKey: 0xFFEBEBEB,
    lightThemeTextColorKey: 0xFF000000, // Black

    // Dark theme //
    darkBackgroundImageKey: null,
    darkBackgroundColorKey: 0xFF141414, // Almost black
    darkThemeColorKey: 0xFF141414,
    darkThemeTextColorKey: 0xFFFFFFFF, // White
  };

  /// Populate [EzConfig.prefs], overwriting defaults whenever a user value is found
  /// Optionally expand the user customizable values with [customDefaults]
  static void init({
    required List<String> assetPaths,
    Map<String, dynamic>? customDefaults,
    List<DeviceOrientation>? orientations,
  }) async {
    // Initialize storage //
    assets = assetPaths;

    preferences = await SharedPreferences.getInstance();

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

    // Initialize screen //
    List<DeviceOrientation> allOptions = [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ];
    SystemChrome.setPreferredOrientations(orientations ?? allOptions);

    focus = FocusManager.instance;

    // Initialize theme //
    bool? isLight = preferences.getBool(isLightKey);
    themeMode = (isLight == null)
        ? ThemeMode.system
        : (isLight)
            ? ThemeMode.light
            : ThemeMode.dark;

    bool? isRight = preferences.getBool(isRightKey);

    dominantSide =
        (isRight == null || isRight == true) ? Hand.right : Hand.left;
  }
}

// Preference keys //

// Shared
const String isLightKey = 'isLight';
const String isRightKey = 'isRight';

const String noImageKey = 'noImage';

const String marginKey = 'margin';
const String paddingKey = 'padding';

const String fontFamilyKey = 'fontFamily';
const String fontScalarKey = 'fontScalar';

const String alertColorKey = 'alertColor';

const String buttonSpacingKey = 'buttonSpacing';
const String dialogSpacingKey = 'dialogSpacing';
const String paragraphSpacingKey = 'paragraphSpacing';

// Light theme
const String lightBackgroundImageKey = 'lightBackgroundImage';
const String lightBackgroundColorKey = 'lightBackgroundColor';
const String lightThemeColorKey = 'lightThemeColor';
const String lightThemeTextColorKey = 'lightThemeTextColor';
const String lightButtonColorKey = 'lightButtonColor';
const String lightButtonTextColorKey = 'lightButtonTextColor';

// Dark theme
const String darkBackgroundImageKey = 'darkBackgroundImage';
const String darkBackgroundColorKey = 'darkBackgroundColor';
const String darkThemeColorKey = 'darkThemeColor';
const String darkThemeTextColorKey = 'darkThemeTextColor';
const String darkButtonColorKey = 'darkButtonColor';
const String darkButtonTextColorKey = 'darkButtonTextColor';
