library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// [PlatformApp] wrapper using [empathetech_flutter_ui] styling
PlatformProvider ezApp(
  BuildContext context, {
  required String appTitle,
  required Map<String, Widget Function(BuildContext)> routes,
}) {
  return PlatformProvider(
    builder: (context) => PlatformApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      routes: routes,
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      material: (context, platform) => materialAppTheme(),
      cupertino: (context, platform) => cupertinoAppTheme(),
    ),
    settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
  );
}

const String homeRoute = '/';

// AppConfig constants/keys
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
  static late List<String> assets;
  static late SharedPreferences preferences;
  static late Map<String, dynamic> prefs;
  static late FocusManager focus;

  static Map<String, dynamic> defaults = {
    backColorKey: 0xFF141414, // Almost black
    themeColorKey: 0xFF141414, // Almost black
    themeTextColorKey: 0xFFFFFFFF, // White text
    buttonColorKey: 0xE620DAA5, // Empathetech eucalyptus
    buttonTextColorKey: 0xFF000000, // Black text
    backImageKey: null,
    buttonSpacingKey: 35.0,
    dialogSpacingKey: 20.0,
    marginKey: 15.0,
    paddingKey: 12.5,
    fontSizeKey: 24.0,
    fontFamilyKey: 'Roboto',
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
  }
}
