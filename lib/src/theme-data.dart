library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

ThemeData ezThemeData({
  required bool light,
  bool? applyElevationOverlayColor,
  NoDefaultCupertinoThemeData? cupertinoOverrideTheme,
  Iterable<ThemeExtension<dynamic>>? extensions,
  InputDecorationTheme? inputDecorationTheme,
  MaterialTapTargetSize? materialTapTargetSize,
  PageTransitionsTheme? pageTransitionsTheme,
  TargetPlatform? platform,
  ScrollbarThemeData? scrollbarTheme,
  InteractiveInkFeatureFactory? splashFactory,
  bool? useMaterial3,
  VisualDensity? visualDensity,
  Brightness? brightness,
  Color? canvasColor,
  Color? cardColor,
  ColorScheme? colorScheme,
  Color? colorSchemeSeed,
  Color? dialogBackgroundColor,
  Color? disabledColor,
  Color? dividerColor,
  Color? focusColor,
  Color? highlightColor,
  Color? hintColor,
  Color? hoverColor,
  Color? indicatorColor,
  Color? primaryColor,
  MaterialColor? primarySwatch,
  Color? scaffoldBackgroundColor,
  Color? secondaryHeaderColor,
  Color? shadowColor,
  Color? splashColor,
  Color? unselectedWidgetColor,
  String? fontFamily,
  List<String>? fontFamilyFallback,
  String? package,
  IconThemeData? iconTheme,
  IconThemeData? primaryIconTheme,
  TextTheme? primaryTextTheme,
  TextTheme? textTheme,
  Typography? typography,
  AppBarTheme? appBarTheme,
  BadgeThemeData? badgeTheme,
  MaterialBannerThemeData? bannerTheme,
  BottomAppBarTheme? bottomAppBarTheme,
  BottomNavigationBarThemeData? bottomNavigationBarTheme,
  BottomSheetThemeData? bottomSheetTheme,
  ButtonBarThemeData? buttonBarTheme,
  ButtonThemeData? buttonTheme,
  CardTheme? cardTheme,
  CheckboxThemeData? checkboxTheme,
  ChipThemeData? chipTheme,
  DataTableThemeData? dataTableTheme,
  DialogTheme? dialogTheme,
  DividerThemeData? dividerTheme,
  DrawerThemeData? drawerTheme,
  DropdownMenuThemeData? dropdownMenuTheme,
  ElevatedButtonThemeData? elevatedButtonTheme,
  ExpansionTileThemeData? expansionTileTheme,
  FilledButtonThemeData? filledButtonTheme,
  FloatingActionButtonThemeData? floatingActionButtonTheme,
  IconButtonThemeData? iconButtonTheme,
  ListTileThemeData? listTileTheme,
  MenuBarThemeData? menuBarTheme,
  MenuButtonThemeData? menuButtonTheme,
  MenuThemeData? menuTheme,
  NavigationBarThemeData? navigationBarTheme,
  NavigationDrawerThemeData? navigationDrawerTheme,
  NavigationRailThemeData? navigationRailTheme,
  OutlinedButtonThemeData? outlinedButtonTheme,
  PopupMenuThemeData? popupMenuTheme,
  ProgressIndicatorThemeData? progressIndicatorTheme,
  RadioThemeData? radioTheme,
  SegmentedButtonThemeData? segmentedButtonTheme,
  SliderThemeData? sliderTheme,
  SnackBarThemeData? snackBarTheme,
  SwitchThemeData? switchTheme,
  TabBarTheme? tabBarTheme,
  TextButtonThemeData? textButtonTheme,
  TextSelectionThemeData? textSelectionTheme,
  TimePickerThemeData? timePickerTheme,
  ToggleButtonsThemeData? toggleButtonsTheme,
  TooltipThemeData? tooltipTheme,
}) {
  Color themeColor =
      Color(EzConfig.prefs[light ? lightThemeColorKey : darkThemeColorKey]);
  Color themeTextColor = Color(
      EzConfig.prefs[light ? lightThemeTextColorKey : darkThemeTextColorKey]);

  Color backgroundColor = Color(
      EzConfig.prefs[light ? lightBackgroundColorKey : darkBackgroundColorKey]);

  Color buttonColor =
      Color(EzConfig.prefs[light ? lightButtonColorKey : darkButtonColorKey]);
  Color buttonTextColor = Color(
      EzConfig.prefs[light ? lightButtonTextColorKey : darkButtonTextColorKey]);

  return ThemeData(
    applyElevationOverlayColor: applyElevationOverlayColor,
    cupertinoOverrideTheme: cupertinoOverrideTheme,
    extensions: extensions,
    inputDecorationTheme: inputDecorationTheme,
    materialTapTargetSize: materialTapTargetSize,
    pageTransitionsTheme: pageTransitionsTheme,
    platform: platform,
    scrollbarTheme: scrollbarTheme,
    splashFactory: splashFactory,
    useMaterial3: useMaterial3,
    visualDensity: visualDensity,
    brightness: brightness,
    canvasColor: canvasColor ?? backgroundColor,
    cardColor: cardColor ?? themeColor,
    colorScheme: colorScheme,
    colorSchemeSeed: colorSchemeSeed,
    dialogBackgroundColor: dialogBackgroundColor ?? themeColor,
    disabledColor: disabledColor,
    dividerColor: dividerColor ?? themeTextColor,
    focusColor: focusColor,
    highlightColor: highlightColor ?? buttonColor,
    hintColor: hintColor ?? themeTextColor,
    hoverColor: hoverColor,
    indicatorColor: indicatorColor ?? buttonColor,
    primaryColor: primaryColor ?? themeColor,
    primarySwatch: primarySwatch,
    scaffoldBackgroundColor: scaffoldBackgroundColor ?? backgroundColor,
    secondaryHeaderColor: secondaryHeaderColor,
    shadowColor: shadowColor,
    splashColor: splashColor,
    unselectedWidgetColor: unselectedWidgetColor,
    fontFamily: fontFamily ?? gStyle(EzConfig.prefs[fontFamilyKey]).fontFamily,
    fontFamilyFallback: fontFamilyFallback,
    package: package,
    iconTheme: iconTheme ?? IconThemeData(color: themeTextColor),
    primaryIconTheme: primaryIconTheme ?? IconThemeData(color: themeTextColor),
    primaryTextTheme: primaryTextTheme ?? materialTextTheme(themeTextColor),
    textTheme: textTheme ?? materialTextTheme(themeTextColor),
    typography: typography,
    appBarTheme: appBarTheme ??
        AppBarTheme(
          backgroundColor: themeColor,
          iconTheme: IconThemeData(color: themeTextColor),
        ),
    badgeTheme: badgeTheme,
    bannerTheme: bannerTheme,
    bottomAppBarTheme: bottomAppBarTheme,
    bottomNavigationBarTheme: bottomNavigationBarTheme ??
        BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: themeColor,
          selectedItemColor: buttonColor,
          selectedIconTheme: IconThemeData(color: buttonColor),
          unselectedItemColor: themeTextColor,
          unselectedIconTheme: IconThemeData(color: themeTextColor),
        ),
    bottomSheetTheme: bottomSheetTheme,
    buttonBarTheme: buttonBarTheme,
    buttonTheme: buttonTheme,
    cardTheme: cardTheme,
    checkboxTheme: checkboxTheme ??
        CheckboxThemeData(
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
    chipTheme: chipTheme,
    dataTableTheme: dataTableTheme,
    dialogTheme: dialogTheme ??
        DialogTheme(
          backgroundColor: themeColor,
          iconColor: themeTextColor,
          alignment: Alignment.center,
        ),
    dividerTheme: dividerTheme,
    drawerTheme: drawerTheme,
    dropdownMenuTheme: dropdownMenuTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    expansionTileTheme: expansionTileTheme,
    filledButtonTheme: filledButtonTheme,
    floatingActionButtonTheme: floatingActionButtonTheme,
    iconButtonTheme: iconButtonTheme,
    listTileTheme: listTileTheme,
    menuBarTheme: menuBarTheme,
    menuButtonTheme: menuButtonTheme,
    menuTheme: menuTheme,
    navigationBarTheme: navigationBarTheme,
    navigationDrawerTheme: navigationDrawerTheme,
    navigationRailTheme: navigationRailTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    popupMenuTheme: popupMenuTheme,
    progressIndicatorTheme: progressIndicatorTheme,
    radioTheme: radioTheme,
    segmentedButtonTheme: segmentedButtonTheme,
    sliderTheme: sliderTheme ??
        SliderThemeData(
          thumbColor: buttonColor,
          disabledThumbColor: themeColor,
          overlayColor: buttonColor,
          activeTrackColor: buttonColor,
          activeTickMarkColor: buttonTextColor,
          inactiveTrackColor: themeColor,
          inactiveTickMarkColor: themeTextColor,
          overlayShape: SliderComponentShape.noOverlay,
        ),
    snackBarTheme: snackBarTheme,
    switchTheme: switchTheme,
    tabBarTheme: tabBarTheme,
    textButtonTheme: textButtonTheme,
    textSelectionTheme: textSelectionTheme,
    timePickerTheme: timePickerTheme,
    toggleButtonsTheme: toggleButtonsTheme,
    tooltipTheme: tooltipTheme,
  );
}

CupertinoThemeData ezCupertinoThemeData({
  required bool light,
  Brightness? brightness,
  Color? primaryColor,
  Color? primaryContrastingColor,
  CupertinoTextThemeData? textTheme,
  Color? barBackgroundColor,
  Color? scaffoldBackgroundColor,
}) {
  Color themeColor =
      Color(EzConfig.prefs[light ? lightThemeColorKey : darkThemeColorKey]);
  Color themeTextColor = Color(
      EzConfig.prefs[light ? lightThemeTextColorKey : darkThemeTextColorKey]);

  Color backgroundColor = Color(
      EzConfig.prefs[light ? lightBackgroundColorKey : darkBackgroundColorKey]);

  return CupertinoThemeData(
    brightness: brightness,
    primaryColor: primaryColor ?? themeColor,
    primaryContrastingColor: primaryContrastingColor ?? themeTextColor,
    textTheme: textTheme ?? cupertinoTextTheme(themeTextColor),
    barBackgroundColor: barBackgroundColor ?? backgroundColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor ?? backgroundColor,
  );
}
