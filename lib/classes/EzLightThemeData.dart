library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

ThemeData ezLightThemeData() {
  Color themeColor = Color(EzConfig.prefs[lightThemeColorKey]);
  Color themeTextColor = Color(EzConfig.prefs[lightThemeTextColorKey]);
  Color unSelectedThemeTextColor = blendColors(themeColor, themeTextColor);

  Color backgroundColor = Color(EzConfig.prefs[lightBackgroundColorKey]);
  Color backgroundTextColor =
      Color(EzConfig.prefs[lightBackgroundTextColorKey]);

  Color buttonColor = Color(EzConfig.prefs[lightButtonColorKey]);
  Color buttonTextColor = Color(EzConfig.prefs[lightButtonTextColorKey]);

  TextStyle appBarTextStyle = buildHeadlineMedium(themeTextColor);
  TextStyle tabBarTextStyle = buildHeadlineSmall(themeTextColor);
  IconThemeData appBarIconData = IconThemeData(
    color: themeTextColor,
    size: appBarTextStyle.fontSize,
  );

  TextStyle buttonTextStyle = buildTitleMedium(buttonTextColor);
  IconThemeData buttonIconData = IconThemeData(
    color: buttonTextColor,
    size: buttonTextStyle.fontSize,
  );

  TextStyle pageSelection = buildTitleMedium(backgroundTextColor);

  TextStyle dialogTitleStyle = buildHeadlineSmall(themeTextColor);
  TextStyle dialogContentStyle = buildTitleMedium(themeTextColor);

  return ThemeData(
    brightness: Brightness.light,

    // General colors
    highlightColor: buttonColor,
    hintColor: themeTextColor,
    indicatorColor: buttonColor,
    primaryColor: themeColor,
    scaffoldBackgroundColor: backgroundColor,

    // Text && icons
    fontFamily: googleStyles[(EzConfig.prefs[fontFamilyKey])]?.fontFamily,
    iconTheme: buttonIconData,
    primaryIconTheme: buttonIconData,
    primaryTextTheme: EzTextTheme(color: backgroundTextColor),
    textTheme: EzTextTheme(color: backgroundTextColor),

    // Transitions
    pageTransitionsTheme: EzTransitions(),

    // AppBar
    appBarTheme: AppBarTheme(
      color: themeColor,
      iconTheme: appBarIconData,
      actionsIconTheme: appBarIconData,
      titleTextStyle: appBarTextStyle,
    ),

    // TabBar
    tabBarTheme: TabBarTheme(
      labelStyle: tabBarTextStyle,
      labelColor: themeTextColor,
      unselectedLabelStyle: tabBarTextStyle.copyWith(
        color: unSelectedThemeTextColor,
      ),
      unselectedLabelColor: unSelectedThemeTextColor,
    ),

    // Drawer
    drawerTheme: DrawerThemeData(backgroundColor: themeColor),

    // Bottom navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: themeColor,
      selectedItemColor: buttonColor,
      selectedIconTheme: IconThemeData(color: buttonColor),
      unselectedItemColor: themeTextColor,
      unselectedIconTheme: IconThemeData(color: themeTextColor),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: buttonTextStyle,
        alignment: Alignment.center,
        backgroundColor: buttonColor,
        shadowColor: buttonColor,
        side: BorderSide(color: buttonColor),
        padding: EdgeInsets.all(EzConfig.prefs[paddingKey]),
      ),
    ),

    // Dropdown Menu
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: pageSelection,
    ),

    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return buttonColor;
          } else {
            return themeTextColor;
          }
        },
      ),
      checkColor: MaterialStateProperty.all(buttonColor),
    ),

    // Dialogs
    dialogTheme: DialogTheme(
      titleTextStyle: dialogTitleStyle,
      backgroundColor: themeColor,
      contentTextStyle: dialogContentStyle,
      iconColor: themeTextColor,
      alignment: Alignment.center,
    ),

    // Sliders
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noOverlay,
      overlayColor: Colors.transparent,
      thumbColor: buttonColor,
      activeTrackColor: buttonColor,
      valueIndicatorColor: buttonColor,
      activeTickMarkColor: buttonTextColor,
      disabledThumbColor: Colors.transparent,
      disabledActiveTrackColor: Colors.transparent,
      disabledInactiveTrackColor: Colors.transparent,
      disabledActiveTickMarkColor: Colors.transparent,
      disabledInactiveTickMarkColor: Colors.transparent,
      disabledSecondaryActiveTrackColor: Colors.transparent,
      inactiveTrackColor: unSelectedThemeTextColor,
      inactiveTickMarkColor: themeTextColor,
    ),
  );
}
