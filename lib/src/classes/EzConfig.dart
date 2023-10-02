/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Singleton class for managing user customization
class EzConfig {
  /// [AssetImage] paths for this app
  final List<String> assets;

  /// [SharedPreferences] instance
  final SharedPreferences preferences;

  /// The factory constructor will merge [empathetechConfig] with any provided customDefaults
  final Map<String, dynamic> defaults;

  /// Live values in use => [defaults] merged with user [preferences]
  final Map<String, dynamic> prefs;

  /// Current [googleStyles] for the app to use
  final String? fontFamily;

  /// What side of the screen touch points should be on
  final Hand dominantHand;

  /// Private instance
  /// The factory constructor + singleton combo requires an internally mutable [instance]
  static EzConfig? _instance;

  /// Private/internal constructor
  const EzConfig._({
    required this.assets,
    required this.preferences,
    required this.defaults,
    required this.prefs,
    this.fontFamily,
    required this.dominantHand,
  });

  /// Factory/external constructor
  ///
  /// [assetPaths] => provide your [AssetImage] paths for this app
  /// [preferences] => provide a [SharedPreferences] instance
  /// [customDefaults] => provide your brand colors, custom styling, etc
  factory EzConfig({
    required List<String> assetPaths,
    required SharedPreferences preferences,
    Map<String, dynamic>? customDefaults,
  }) {
    if (_instance == null) {
      // Build EzConfig.defaults //

      // Start with Emapthetech's config
      Map<String, dynamic> _defaults = new Map.from(empathetechConfig);

      // Merge custom defaults
      if (customDefaults != null) _defaults.addAll(customDefaults);

      // Build EzConfig.prefs //

      // Start with the newly merged defaults
      Map<String, dynamic> _prefs = new Map.from(_defaults);

      // Find the keys that users have overwritten
      List<String> overwritten = _prefs.keys.toSet().intersection(preferences.getKeys()).toList();

      // Get the updated values
      overwritten.forEach((key) {
        dynamic value = _prefs[key];
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

        if (userPref != null) _prefs[key] = userPref;
      });

      // Build EzConfig.hand //

      bool? isRight = preferences.getBool(isRightKey);
      final Hand _dominantHand = (isRight == null || isRight == true) ? Hand.right : Hand.left;

      // Build the EzConfig instance //

      _instance = EzConfig._(
        assets: assetPaths,
        preferences: preferences,
        defaults: _defaults,
        prefs: _prefs,
        fontFamily: googleStyles[(_prefs[fontFamilyKey])]?.fontFamily,
        dominantHand: _dominantHand,
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
