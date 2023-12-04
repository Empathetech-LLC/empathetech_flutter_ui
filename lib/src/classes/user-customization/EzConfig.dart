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

  /// [AssetImage] paths for the app
  final Set<String> assets;

  /// Default config values
  /// [empathetechConfig] merged with any provided customDefaults
  final Map<String, dynamic> defaults;

  /// All keys (and their value [Type]) in the known EzConfig universe
  final Map<String, Type> keys;

  /// Live values in use
  /// [defaults] merged with user [preferences]
  final Map<String, dynamic> prefs;

  /// Private instance
  static EzConfig? _instance;

  /// Private/internal constructor
  const EzConfig._({
    required this.preferences,
    required this.assets,
    required this.defaults,
    required this.keys,
    required this.prefs,
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

      // Build this.prefs //

      // Start with the newly merged defaults
      Map<String, dynamic> _prefs = new Map.from(_defaults);

      // Find the keys that users have overwritten
      Set<String> overwritten =
          preferences.getKeys().intersection(_keys.keys.toSet());

      // Get the updated values
      overwritten.forEach((key) {
        Type? valueType = _keys[key];
        dynamic userPref;

        switch (valueType) {
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
        assets: assetPaths,
        preferences: preferences,
        defaults: _defaults,
        prefs: _prefs,
        keys: _keys,
      );
    }

    return _instance!;
  }

  // No null checks below, for expediency
  // EFUI won't work at all if EzConfig isn't initialized, so they're moot

  // Getters //

  /// Get the [EzConfig] instance
  /// EzConfig must be initialized
  static EzConfig get instance {
    return _instance!;
  }

  /// Get the [keys] EzConfig value?
  /// EzConfig must be initialized
  static dynamic get(String key) {
    return _instance!.prefs[key];
  }

  // Setters //

  /// Set [key] to [value]
  /// EzConfig must be initialized
  static Future<bool> set(String key, dynamic value) async {
    Type? valueType = _instance!.keys[key];
    if (valueType == null) {
      log("""Key [$key] is not in the known EFUI universe
Please add it to the customDefaults when initializing EzConfig""");
      return false;
    }

    switch (valueType) {
      case int:
        return await _instance!.preferences.setInt(key, value);
      case bool:
        return await _instance!.preferences.setBool(key, value);
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

  // Cleaners //

  /// Remove the custom value for [key]
  /// EzConfig must be initialized
  static Future<bool> remove(String key) async {
    return await _instance!.preferences.remove(key);
  }
}
