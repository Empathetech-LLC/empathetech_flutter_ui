library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Material (Android) [ThemeData] built from [AppConfig.prefs]
MaterialAppData materialAppTheme() {
  Color themeColor = Color(AppConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);
  Color buttonColor = Color(AppConfig.prefs[buttonColorKey]);
  Color buttonTextColor = Color(AppConfig.prefs[buttonTextColorKey]);

  TextStyle dialogTitleText = getTextStyle(dialogTitleStyleKey);
  TextStyle dialogContentText = getTextStyle(dialogContentStyleKey);

  return MaterialAppData(
    theme: ThemeData(
      primaryColor: themeColor,

      // App bar
      appBarTheme: AppBarTheme(
        backgroundColor: themeColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: themeTextColor),
        titleTextStyle: getTextStyle(titleStyleKey),
      ),

      // Nav bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: themeColor,
        selectedItemColor: buttonColor,
        selectedIconTheme: IconThemeData(color: buttonColor),
        unselectedItemColor: themeTextColor,
        unselectedIconTheme: IconThemeData(color: themeTextColor),
      ),

      // Text
      textTheme: defaultTextTheme(),
      primaryTextTheme: defaultTextTheme(),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: themeTextColor,
        selectionColor: themeColor,
        selectionHandleColor: buttonColor,
      ),
      hintColor: themeTextColor,

      // Icons
      iconTheme: IconThemeData(color: themeTextColor),

      // Sliders
      sliderTheme: SliderThemeData(
        thumbColor: buttonColor,
        disabledThumbColor: themeColor,
        overlayColor: buttonColor,
        activeTrackColor: buttonColor,
        activeTickMarkColor: buttonTextColor,
        inactiveTrackColor: themeColor,
        inactiveTickMarkColor: themeTextColor,
        valueIndicatorTextStyle: dialogContentText,
        overlayShape: SliderComponentShape.noOverlay,
      ),

      // Dialogs
      dialogTheme: DialogTheme(
        backgroundColor: themeColor,
        iconColor: themeTextColor,
        alignment: Alignment.center,
        titleTextStyle: dialogTitleText,
        contentTextStyle: dialogContentText,
      ),
    ),
  );
}

/// (iOS) [CupertinoAppData] data built [from] the passed in [MaterialAppData]
CupertinoAppData m2cApp(MaterialAppData from) {
  return CupertinoAppData();
}

/// Cupertino (iOS) [Scaffold] data built [from] the passed in [MaterialScaffoldData]
CupertinoPageScaffoldData m2cScaffold(MaterialScaffoldData from) {
  return CupertinoPageScaffoldData();
}

/// Material (Android) [ElevatedButton] style built from [AppConfig.prefs]
ButtonStyle materialButton() {
  return ElevatedButton.styleFrom(
    backgroundColor: Color(AppConfig.prefs[buttonColorKey]),
    foregroundColor: Color(AppConfig.prefs[buttonTextColorKey]),
    textStyle: getTextStyle(buttonStyleKey),
    padding: EdgeInsets.all(AppConfig.prefs[paddingKey]),
  );
}

/// Cupertino (iOS) [ElevatedButton] data built [from] the passed in Material [ButtonStyle]
CupertinoElevatedButtonData m2cButton(ButtonStyle from) {
  return CupertinoElevatedButtonData(
    color: from.backgroundColor is Color
        ? from.backgroundColor as Color
        : AppConfig.prefs[buttonColorKey],
    padding: from.padding is EdgeInsetsGeometry
        ? from.padding as EdgeInsetsGeometry
        : EdgeInsets.all(AppConfig.prefs[paddingKey]),
  );
}
