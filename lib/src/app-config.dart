library ez_ui;

import 'constants.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static late FocusManager focus;

  static late SharedPreferences preferences;
  static Map<String, dynamic> prefs = new Map.from(defaultConfig);

  // Populate prefs, overwriting defaults whenever a user value is found
  static void init() {
    defaultConfig.forEach((key, value) {
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

  static void expandPrefs(Map<String, dynamic> uniqueConfig) {
    prefs.addAll(uniqueConfig);
  }
}
