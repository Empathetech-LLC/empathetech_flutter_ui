library ez_ui;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String backImageKey = 'backImage';
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

class AppConfig {
  static late FocusManager focus;
  static late SharedPreferences preferences;
  static late Map<String, dynamic> prefs;

  static Map<String, dynamic> defaults = {
    backImageKey: null,
    backColorKey: 0xE6A520DA, // Empathetech purple
    themeColorKey: 0xFF141414, // Almost black
    themeTextColorKey: 0xFFFFFFFF, // White
    buttonColorKey: 0xE6DAA520, // Empathetech gold
    buttonTextColorKey: 0xFF000000, // Black
    buttonSpacingKey: 35.0,
    dialogSpacingKey: 20.0,
    marginKey: 15.0,
    paddingKey: 12.5,
    fontFamilyKey: 'Roboto',
    fontSizeKey: 24.0,
  };

  // Populate prefs, overwriting defaults whenever a user value is found
  static void init([Map<String, dynamic>? customDefaults]) {
    if (customDefaults != null) defaults.addAll(customDefaults);

    prefs = new Map.from(defaults);

    defaults.forEach((key, value) {
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
