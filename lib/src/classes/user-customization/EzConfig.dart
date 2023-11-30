/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Singleton class for managing user customization
class EzConfig {
  /// [SharedPreferences] instance
  final SharedPreferences preferences;

  /// [AssetImage] paths for the app
  final List<String> assets;

  /// The factory constructor will merge [empathetechConfig] with any provided customDefaults
  final Map<String, dynamic> defaults;

  /// Live values in use
  /// [defaults] merged with user [preferences]
  final Map<String, dynamic> prefs;

  /// Current locale/language for the app
  final Locale? locale;

  /// Current [googleStyles] family for the app
  final String? fontFamily;

  /// What side of the screen touch points should be on
  final Hand? dominantHand;

  /// Private instance
  static EzConfig? _instance;

  /// Private/internal constructor
  const EzConfig._({
    required this.preferences,
    required this.assets,
    required this.defaults,
    required this.prefs,
    this.locale,
    this.fontFamily,
    this.dominantHand,
  });

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

      // Start with Empathetech's config
      Map<String, dynamic> _defaults = new Map.from(empathetechConfig);

      // Merge custom defaults
      if (customDefaults != null) _defaults.addAll(customDefaults);

      // Build EzConfig.prefs //

      // Start with the newly merged defaults
      Map<String, dynamic> _prefs = new Map.from(_defaults);

      // Find the keys that users have overwritten
      List<String> overwritten =
          _prefs.keys.toSet().intersection(preferences.getKeys()).toList();

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
          case const (List<String>):
            userPref = preferences.getStringList(key);
            break;
          default:
            break;
        }

        if (userPref != null) _prefs[key] = userPref;
      });

      // Gather trackers //
      final List<String>? localeData = preferences.getStringList(localeKey);
      final Locale? _locale = (localeData == null || localeData.isEmpty)
          ? null
          : Locale(localeData[0], localeData.length > 1 ? localeData[1] : null);

      final String? fontData = preferences.getString(fontFamilyKey);
      final String? _fontFamily =
          (fontData == null) ? null : googleStyles[(fontData)]?.fontFamily;

      final bool? isRight = preferences.getBool(isRightKey);
      final Hand? _dominantHand = (isRight == null)
          ? null
          : isRight
              ? Hand.right
              : Hand.left;

      // Build the EzConfig instance //

      _instance = EzConfig._(
        assets: assetPaths,
        preferences: preferences,
        defaults: _defaults,
        prefs: _prefs,
        locale: _locale,
        fontFamily: _fontFamily,
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
