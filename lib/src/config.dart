/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Singleton class for managing user customization
class EzConfig {
  /// [SharedPreferences] instance
  final SharedPreferences preferences;

  /// Asset paths for the app
  /// Used for [AssetImage] and video checks
  final Set<String> assetPaths;

  /// Default config
  final Map<String, dynamic> defaults;

  /// All keys (and their value [Type]) in the known EzConfigverse
  final Map<String, Type> keys;

  /// Live values in use
  /// [defaults] merged with user [preferences]
  final Map<String, dynamic> prefs;

  /// Private instance
  static EzConfig? _instance;

  /// Private/internal constructor
  const EzConfig._({
    required this.preferences,
    required this.assetPaths,
    required this.defaults,
    required this.keys,
    required this.prefs,
  });

  /// [preferences] => provide a [SharedPreferences] instance
  /// [assetPaths] => provide your [AssetImage] paths for this app
  /// [defaults] => provide your brand colors, text styles, layout settings, etc.
  factory EzConfig.init({
    required SharedPreferences preferences,
    required Set<String> assetPaths,
    required Map<String, dynamic> defaults,
  }) {
    if (_instance == null) {
      // Build this.keys //

      // Start with the known EzConfigverse
      final Map<String, Type> keys = Map<String, Type>.from(allKeys);

      // Merge defaults
      for (final MapEntry<String, dynamic> entry in defaults.entries) {
        // Load missing custom defaults into preferences
        if (!keys.containsKey(entry.key)) {
          switch (entry.key.runtimeType) {
            case const (bool):
              if (preferences.getBool(entry.key) == null) {
                preferences.setBool(entry.key, entry.value);
              }
              break;
            case const (int):
              if (preferences.getInt(entry.key) == null) {
                preferences.setInt(entry.key, entry.value);
              }
              break;
            case const (double):
              if (preferences.getDouble(entry.key) == null) {
                preferences.setDouble(entry.key, entry.value);
              }
              break;
            case const (String):
              if (preferences.getString(entry.key) == null) {
                preferences.setString(entry.key, entry.value);
              }
              break;
            case const (List<String>):
              if (preferences.getStringList(entry.key) == null) {
                preferences.setStringList(entry.key, entry.value);
              }
              break;
            default:
              debugPrint(
                  '''Key [${entry.key}] has unsupported Type [${entry.key.runtimeType}]
Must be one of [int, bool, double, String, List<String>]''');
              break;
          }
        }

        keys[entry.key] = entry.value.runtimeType;
      }

      // Build this.prefs //

      // Start with the defaults
      final Map<String, dynamic> prefs = Map<String, dynamic>.from(defaults);

      // Find the keys that users have overwritten
      final Set<String> overwritten =
          preferences.getKeys().intersection(keys.keys.toSet());

      // Get the updated values
      for (final String key in overwritten) {
        final Type? valueType = keys[key];
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
            debugPrint('''Key [$key] has unsupported Type [$valueType]
Must be one of [int, bool, double, String, List<String>]''');
            break;
        }

        if (userPref != null) prefs[key] = userPref;
      }

      // Build the EzConfig instance //

      _instance = EzConfig._(
        assetPaths: assetPaths,
        preferences: preferences,
        defaults: defaults,
        prefs: prefs,
        keys: keys,
      );
    }

    return _instance!;
  }

  // No null checks below, for expediency
  // EFUI won't work at all if EzConfig isn't initialized, so they're moot

  // Getters //

  /// Get the [key]s EzConfig value?
  /// Uses the live values from [prefs]
  static dynamic get(String key) {
    return _instance!.prefs[key];
  }

  /// Get the [key]s default EzConfig value?
  static dynamic getDefault(String key) {
    return _instance!.defaults[key];
  }

  /// Return the user's selected [Locale]?
  static Locale? getLocale() {
    final List<String>? localeData = _instance!.prefs[localeKey];

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
    final bool? isDarkTheme = _instance!.prefs[isDarkThemeKey];

    if (isDarkTheme == null) {
      return ThemeMode.system;
    } else {
      return isDarkTheme ? ThemeMode.dark : ThemeMode.light;
    }
  }

  /// Get the [key]s EzConfig value
  /// Uses the value stored in [EzConfig.preferences]
  static bool? getBool(String key) {
    return _instance!.preferences.getBool(key);
  }

  /// Get the [key]s EzConfig value
  /// Uses the value stored in [EzConfig.preferences]
  static int? getInt(String key) {
    return _instance!.preferences.getInt(key);
  }

  /// Get the [key]s EzConfig value
  /// Uses the value stored in [EzConfig.preferences]
  static double? getDouble(String key) {
    return _instance!.preferences.getDouble(key);
  }

  /// Get the [key]s EzConfig value
  /// Uses the value stored in [EzConfig.preferences]
  static String? getString(String key) {
    return _instance!.preferences.getString(key);
  }

  /// Get the [key]s EzConfig value
  /// Uses the value stored in [EzConfig.preferences]
  static List<String>? getStringList(String key) {
    return _instance!.preferences.getStringList(key);
  }

  /// Wether the [key] contains the value to a recognized asset path
  /// From the [EzConfig.init] field [assetPaths]
  static bool isKeyAsset(String key) {
    return _instance!.assetPaths.contains(_instance!.prefs[key]);
  }

  /// Wether the [path] leads to a recognized asset
  /// From the [EzConfig.init] field [assetPaths]
  static bool isPathAsset(String path) {
    return _instance!.assetPaths.contains(path);
  }

  // Setters //

  /// Set the EzConfig [key] to [value] with type [bool]
  /// Defaults to both the live [EzConfig.prefs] and stored [EzConfig.preferences]
  /// Optionally set [storageOnly] to true to only update [EzConfig.preferences]
  static Future<bool> setBool(
    String key,
    bool value, {
    bool storageOnly = false,
  }) async {
    final bool result = await _instance!.preferences.setBool(key, value);
    if (result && !storageOnly) _instance!.prefs[key] = value;
    return result;
  }

  /// Set the EzConfig [key] to [value] with type [int]
  /// Defaults to both the live [EzConfig.prefs] and stored [EzConfig.preferences]
  /// Optionally set [storageOnly] to true to only update [EzConfig.preferences]
  static Future<bool> setInt(
    String key,
    int value, {
    bool storageOnly = false,
  }) async {
    final bool result = await _instance!.preferences.setInt(key, value);
    if (result && !storageOnly) _instance!.prefs[key] = value;
    return result;
  }

  /// Set the EzConfig [key] to [value] with type [double]
  /// Defaults to both the live [EzConfig.prefs] and stored [EzConfig.preferences]
  /// Optionally set [storageOnly] to true to only update [EzConfig.preferences]
  static Future<bool> setDouble(
    String key,
    double value, {
    bool storageOnly = false,
  }) async {
    final bool result = await _instance!.preferences.setDouble(key, value);
    if (result && !storageOnly) _instance!.prefs[key] = value;
    return result;
  }

  /// Set the EzConfig [key] to [value] with type [String]
  /// Defaults to both the live [EzConfig.prefs] and stored [EzConfig.preferences]
  /// Optionally set [storageOnly] to true to only update [EzConfig.preferences]
  static Future<bool> setString(
    String key,
    String value, {
    bool storageOnly = false,
  }) async {
    final bool result = await _instance!.preferences.setString(key, value);
    if (result && !storageOnly) _instance!.prefs[key] = value;
    return result;
  }

  /// Set the EzConfig [key] to [value] with type [List]
  /// Defaults to both the live [EzConfig.prefs] and stored [EzConfig.preferences]
  /// Optionally set [storageOnly] to true to only update [EzConfig.preferences]
  static Future<bool> setStringList(
    String key,
    List<String> value, {
    bool storageOnly = false,
  }) async {
    final bool result = await _instance!.preferences.setStringList(key, value);
    if (result && !storageOnly) _instance!.prefs[key] = value;
    return result;
  }

  // Removers //

  /// Remove the custom value for [key]
  /// Defaults to both the live [EzConfig.prefs] and stored [EzConfig.preferences]
  /// Optionally set [storageOnly] to true to only update [EzConfig.preferences]
  static Future<bool> remove(String key, {bool storageOnly = false}) async {
    final bool result = await _instance!.preferences.remove(key);

    if (result && !storageOnly) {
      _instance!.defaults.containsKey(key)
          ? _instance!.prefs[key] = _instance!.defaults[key]
          : _instance!.prefs.remove(key);
    }

    return result;
  }

  /// Remove the [keys] custom values
  /// Defaults to both the live [EzConfig.prefs] and stored [EzConfig.preferences]
  /// Optionally set [storageOnly] to true to only update [EzConfig.preferences]
  static Future<bool> removeKeys(
    Set<String> keys, {
    bool storageOnly = false,
  }) async {
    bool success = true;

    for (final String key in keys) {
      final bool remove = await _instance!.preferences.remove(key);

      if (remove) {
        if (!storageOnly) {
          _instance!.defaults.containsKey(key)
              ? _instance!.prefs[key] = _instance!.defaults[key]
              : _instance!.prefs.remove(key);
        }
      } else {
        success = false;
        debugPrint('Failed to remove key [$key]');
      }
    }

    return success;
  }
}
