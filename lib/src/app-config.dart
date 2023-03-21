library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Constants/keys
const String backImageKey = 'backImage';
const String noImageKey = 'noImage';
const String backColorKey = 'appBackgroundColor';
const String themeColorKey = 'themeColor';
const String themeTextColorKey = 'themeTextColor';
const String buttonColorKey = 'buttonColor';
const String buttonTextColorKey = 'buttonTextColor';
const String buttonSpacingKey = 'buttonSpacing';
const String dialogSpacingKey = 'dialogSpacing';
const String marginKey = 'margin';
const String paddingKey = 'padding';
const String fontFamilyKey = 'fontFamily';
const String fontSizeKey = 'fontSize';

/// Static object for managing a dynamic && user customizable UI
/// Tracks the apps [FocusManager] for keyboard management
/// Setting are tracked with [shared_preferences]
class AppConfig {
  static late FocusManager focus;
  static late SharedPreferences preferences;
  static late Map<String, dynamic> prefs;
  static late List<String> assets;

  static Map<String, dynamic> defaults = {
    backImageKey: null,
    backColorKey: 0xFF141414, // Almost black
    themeColorKey: 0xFF141414, // Almost black
    themeTextColorKey: 0xFFFFFFFF, // White text
    buttonColorKey: 0xE620DAA5, // Empathetech eucalyptus
    buttonTextColorKey: 0xFF000000, // Black text
    buttonSpacingKey: 35.0,
    dialogSpacingKey: 20.0,
    marginKey: 15.0,
    paddingKey: 12.5,
    fontFamilyKey: 'Roboto',
    fontSizeKey: 24.0,
  };

  /// Populate [AppConfig.prefs], overwriting defaults whenever a user value is found
  /// Optionally expand the user customizable values with [customDefaults]
  static void init({
    required List<String> assetPaths,
    Map<String, dynamic>? customDefaults,
  }) {
    // Load asset paths
    assets = assetPaths;

    // Load any custom defaults
    if (customDefaults != null) defaults.addAll(customDefaults);

    // Start prefs with a deep copy of defaults
    prefs = new Map.from(defaults);

    // Find all the keys that have been overwritten
    List<String> toOverwrite =
        preferences.getKeys().toSet().intersection(defaults.keys.toSet()).toList();

    // Load the changes
    toOverwrite.forEach((key) {
      dynamic value = defaults[key];
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
  }
}
