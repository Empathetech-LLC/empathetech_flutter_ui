/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Singleton class for managing user customization
class EzConfig {
  /// [SharedPreferences] instance
  final SharedPreferences preferences;

  /// Asset paths for the app
  /// Used for [AssetImage] and video checks
  final Set<String> assetPaths;

  /// Default config values
  /// [empathetechConfig] merged with any provided customDefaults
  final Map<String, dynamic> defaults;

  /// All keys (and their value [Type]) in the known EzConfig universe
  final Map<String, Type> keys;

  /// Live values in use
  /// [defaults] merged with user [preferences]
  final Map<String, dynamic> prefs;

  /// All [Color] keys that are being tracked by the user
  /// They can be used to populate a dynamic color settings screen
  final Set<String> userColors;

  /// Private instance
  static EzConfig? _instance;

  /// Private/internal constructor
  const EzConfig._({
    required this.preferences,
    required this.assetPaths,
    required this.defaults,
    required this.keys,
    required this.prefs,
    required this.userColors,
  });

  /// [preferences] => provide a [SharedPreferences] instance
  /// [assetPaths] => provide your [AssetImage] paths for this app
  /// [customDefaults] => provide your brand colors, custom styling, etc
  factory EzConfig({
    required SharedPreferences preferences,
    required Set<String> assetPaths,
    Map<String, dynamic>? customDefaults,
  }) {
    if (_instance == null) {
      // Build this.defaults //

      // Start with Empathetech's config
      Map<String, dynamic> _defaults = new Map.from(empathetechConfig);

      // Merge custom defaults
      if (customDefaults != null) _defaults.addAll(customDefaults);

      // Build this.keys //

      // Start with Empathetech's config
      Map<String, Type> _keys = new Map.from(allKeys);

      // Merge custom defaults
      if (customDefaults != null) {
        for (var entry in customDefaults.entries) {
          _keys[entry.key] = entry.value.runtimeType;
        }
      }

      // Build this.prefs (and this.userColors) //

      // Start with the newly merged defaults
      Map<String, dynamic> _prefs = new Map.from(_defaults);

      // Find the keys that users have overwritten
      final Set<String> overwritten =
          preferences.getKeys().intersection(_keys.keys.toSet());

      // Gather the colorKeys that the user is tracking
      Set<String> _userColors = {};

      // Get the updated values
      overwritten.forEach((key) {
        Type? valueType = _keys[key];
        dynamic userPref;

        switch (valueType) {
          case bool:
            userPref = preferences.getBool(key);
            break;

          case int:
            userPref = preferences.getInt(key);

            if (userPref != null && allColors.contains(key)) {
              _userColors.add(key);
            }
            break;

          case double:
            userPref = preferences.getDouble(key);
            break;

          case String:
            userPref = preferences.getString(key);
            break;

          case const (List<String>):
            userPref = preferences.getStringList(key);
            break;

          default:
            log("""Key [$key] has unsupported Type [$valueType]
Must be one of [int, bool, double, String, List<String>]""");
            break;
        }

        if (userPref != null) _prefs[key] = userPref;
      });

      // Build the EzConfig instance //

      _instance = EzConfig._(
        assetPaths: assetPaths,
        preferences: preferences,
        defaults: _defaults,
        prefs: _prefs,
        keys: _keys,
        userColors: _userColors,
      );
    }

    return _instance!;
  }

  // No null checks below, for expediency
  // EFUI won't work at all if EzConfig isn't initialized, so they're moot

  // Getters //

  /// Get the [keys] EzConfig value?
  /// Uses the live values from [prefs]
  /// Faster but less reliable than the other getters
  static dynamic get(String key) {
    return _instance!.prefs[key];
  }

  /// Return the user's selected [Locale]?
  static Locale? getLocale() {
    final List<String>? localeData = _instance!.prefs[localeKey];

    if (localeData == null) {
      return null;
    } else {
      return Locale(localeData[0], localeData[1]);
    }
  }

  /// All [Color] keys that the user is tracking
  static Set<String> getUserColors() {
    return _instance!.userColors;
  }

  /// Get the [keys] default EzConfig value?
  /// Fast && reliable
  static dynamic getDefault(String key) {
    return _instance!.defaults[key];
  }

  /// Get the [keys] EzConfig value
  /// Uses the value stored in [preferences]
  /// Slower but more reliable than [EzConfig.get]
  static bool? getBool(String key) {
    return _instance!.preferences.getBool(key);
  }

  /// Get the [keys] EzConfig value
  /// Uses the value stored in [preferences]
  /// Slower but more reliable than [EzConfig.get]
  static int? getInt(String key) {
    return _instance!.preferences.getInt(key);
  }

  /// Get the [keys] EzConfig value
  /// Uses the value stored in [preferences]
  /// Slower but more reliable than [EzConfig.get]
  static double? getDouble(String key) {
    return _instance!.preferences.getDouble(key);
  }

  /// Get the [keys] EzConfig value
  /// Uses the value stored in [preferences]
  /// Slower but more reliable than [EzConfig.get]
  static String? getString(String key) {
    return _instance!.preferences.getString(key);
  }

  /// Get the [keys] EzConfig value
  /// Uses the value stored in [preferences]
  /// Slower but more reliable than [EzConfig.get]
  static List<String>? getStringList(String key) {
    return _instance!.preferences.getStringList(key);
  }

  /// Wether the [key] contains the value to a recognized asset path
  static bool isKeyAsset(String key) {
    if (_instance!.prefs.containsKey(key)) {
      return false;
    } else {
      return _instance!.assetPaths.contains(_instance!.prefs[key]);
    }
  }

  /// Wether the [path] leads to a recognized asset
  static bool isPathAsset(String path) {
    return _instance!.assetPaths.contains(path);
  }

  // Setters //

  /// Set [key] to [value] - EzConfig must be initialized
  /// Handles [Type] checking
  /// If the [Type] is known, the direct setters are faster
  /// [EzConfig.setInt], [EzConfig.setBool], [EzConfig.setDouble], [EzConfig.setString], [EzConfig.setStringList]
  static Future<bool> set(String key, dynamic value) async {
    Type? valueType = _instance!.keys[key];
    if (valueType == null) {
      log("""Key [$key] is not in the known EFUI universe
Please add it to the customDefaults when initializing EzConfig""");
      return false;
    }

    switch (valueType) {
      case bool:
        return await _instance!.preferences.setBool(key, value);
      case int:
        return await _instance!.preferences.setInt(key, value);
      case double:
        return await _instance!.preferences.setDouble(key, value);
      case String:
        return await _instance!.preferences.setString(key, value);
      case const (List<String>):
        return await _instance!.preferences.setStringList(key, value);
      default:
        log("""Key [$key] has unsupported Type [$valueType]
Must be one of [int, bool, double, String, List<String>]""");
        return false;
    }
  }

  /// Set the EzConfig [key] to [value]
  /// EzConfig must be initialized
  static Future<bool> setBool(String key, bool value) async {
    return await _instance!.preferences.setBool(key, value);
  }

  /// Set the EzConfig [key] to [value]
  /// EzConfig must be initialized
  static Future<bool> setInt(String key, int value) async {
    return await _instance!.preferences.setInt(key, value);
  }

  /// Set the EzConfig [key] to [value]
  /// EzConfig must be initialized
  static Future<bool> setDouble(String key, double value) async {
    return await _instance!.preferences.setDouble(key, value);
  }

  /// Set the EzConfig [key] to [value]
  /// EzConfig must be initialized
  static Future<bool> setString(String key, String value) async {
    return await _instance!.preferences.setString(key, value);
  }

  /// Set the EzConfig [key] to [value]
  /// EzConfig must be initialized
  static Future<bool> setStringList(String key, List<String> value) async {
    return await _instance!.preferences.setStringList(key, value);
  }

  // Cleaners //

  /// Remove the custom value for [key]
  /// EzConfig must be initialized
  static Future<bool> remove(String key) async {
    return await _instance!.preferences.remove(key);
  }

  static void removeKeys(Set<String> keys) async {
    final Set<String> updated =
        keys.intersection(_instance!.preferences.getKeys());

    for (String key in updated) {
      _instance!.preferences.remove(key);
    }
  }
}
