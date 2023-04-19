library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Sets all [TextStyle]s to the default case from [buildTextStyle]
/// [TextStyle]s are overwritten throughout EFUI, this serves as redundancy to insure third-party
/// [Widget] styling matches that of [EzConfig]
TextTheme materialTextTheme() {
  TextStyle defaultTextStyle = buildTextStyle(styleKey: defaultStyleKey);

  return TextTheme(
    labelLarge: defaultTextStyle,
    bodyLarge: defaultTextStyle,
    titleLarge: defaultTextStyle,
    displayLarge: defaultTextStyle,
    headlineLarge: defaultTextStyle,
    labelMedium: defaultTextStyle,
    bodyMedium: defaultTextStyle,
    titleMedium: defaultTextStyle,
    displayMedium: defaultTextStyle,
    headlineMedium: defaultTextStyle,
    labelSmall: defaultTextStyle,
    bodySmall: defaultTextStyle,
    titleSmall: defaultTextStyle,
    displaySmall: defaultTextStyle,
    headlineSmall: defaultTextStyle,
  );
}

/// Sets all [TextStyle]s to the default case from [buildTextStyle]
/// [TextStyle]s are overwritten throughout EFUI, this serves as redundancy to insure third-party
/// [Widget] styling matches that of [EzConfig]
CupertinoTextThemeData cupertinoTextTheme() {
  Color textColor = Color(EzConfig.prefs[themeTextColorKey]);
  TextStyle defaultTextStyle = buildTextStyle(styleKey: defaultStyleKey);

  return CupertinoTextThemeData(
    primaryColor: textColor,
    textStyle: defaultTextStyle,
    actionTextStyle: defaultTextStyle,
    tabLabelTextStyle: defaultTextStyle,
    navTitleTextStyle: defaultTextStyle,
    navLargeTitleTextStyle: defaultTextStyle,
    navActionTextStyle: defaultTextStyle,
    pickerTextStyle: defaultTextStyle,
    dateTimePickerTextStyle: defaultTextStyle,
  );
}
