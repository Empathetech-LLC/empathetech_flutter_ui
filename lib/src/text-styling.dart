library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Saved/supported Google Fonts

const String soraKey = 'Sora';
const String hahmletKey = 'Hahmlet';
const String jetbrainsMonoKey = 'JetBrains Mono';
const String andadaProKey = 'Andada Pro';
const String epilogueKey = 'Epilogue';
const String interKey = 'Inter';
const String encodeSansKey = 'Encode Sans';
const String manropeKey = 'Manrope';
const String loraKey = 'Lora';
const String bioRhymeKey = 'BioRhyme';
const String playfairDisplayKey = 'Playfair Display';
const String archivoKey = 'Archivo';
const String robotoKey = 'Roboto';
const String cormorantKey = 'Cormorant';
const String spectralKey = 'Spectral';
const String ralewayKey = 'Raleway';
const String workSansKey = 'Work Sans';
const String latoKey = 'Lato';
const String antonKey = 'Anton';
const String oldStandardKey = 'Old Standard TT';

/// List of [GoogleFonts] (https://fonts.google.com/) EFUI has saved
const List<String> myGoogleFonts = [
  soraKey,
  hahmletKey,
  jetbrainsMonoKey,
  andadaProKey,
  epilogueKey,
  interKey,
  encodeSansKey,
  manropeKey,
  loraKey,
  bioRhymeKey,
  playfairDisplayKey,
  archivoKey,
  robotoKey,
  cormorantKey,
  spectralKey,
  ralewayKey,
  workSansKey,
  latoKey,
  antonKey,
  oldStandardKey,
];

/// Returns the [TextStyle] of the [GoogleFonts] matching [fontName]
TextStyle googleStyleAlias(String fontName) {
  switch (fontName) {
    case soraKey:
      return GoogleFonts.sora();

    case hahmletKey:
      return GoogleFonts.hahmlet();

    case jetbrainsMonoKey:
      return GoogleFonts.jetBrainsMono();

    case andadaProKey:
      return GoogleFonts.andadaPro();

    case epilogueKey:
      return GoogleFonts.epilogue();

    case interKey:
      return GoogleFonts.inter();

    case encodeSansKey:
      return GoogleFonts.encodeSans();

    case manropeKey:
      return GoogleFonts.manrope();

    case loraKey:
      return GoogleFonts.lora();

    case bioRhymeKey:
      return GoogleFonts.bioRhyme();

    case playfairDisplayKey:
      return GoogleFonts.playfairDisplay();

    case archivoKey:
      return GoogleFonts.archivo();

    case robotoKey:
      return GoogleFonts.roboto();

    case cormorantKey:
      return GoogleFonts.cormorant();

    case spectralKey:
      return GoogleFonts.spectral();

    case ralewayKey:
      return GoogleFonts.raleway();

    case workSansKey:
      return GoogleFonts.workSans();

    case latoKey:
      return GoogleFonts.lato();

    case antonKey:
      return GoogleFonts.anton();

    case oldStandardKey:
      return GoogleFonts.oldStandardTt();

    case errorStyleKey:
    default:
      return TextStyle(
        fontSize: 48,
        color: Colors.red,
      );
  }
}

// Keys for building the text styles in-app

const String defaultStyleKey = 'defaultStyle';
const String headerStyleKey = 'headerStyle';
const String titleStyleKey = 'titleStyle';
const String subTitleStyleKey = 'subTitleStyle';
const String dialogTitleStyleKey = 'dialogTitleStyle';
const String buttonStyleKey = 'buttonStyle';
const String dialogContentStyleKey = 'dialogContentStyle';
const String colorSettingStyleKey = 'colorSettingStyle';
const String imageSettingStyleKey = 'imageSettingStyle';
const String fontSettingStyleKey = 'fontSettingStyle';
const String sliderSettingStyleKey = 'sliderSettingStyle';
const String errorStyleKey = 'errorStyle';

/// Returns the [style] style, built from the current [EzConfig.prefs] values
TextStyle buildTextStyle({
  required String style,
  Color? color,
  TextDecoration? decoration,
  FontWeight? fontWeight,
}) {
  late String currFontFamily =
      googleStyleAlias(EzConfig.prefs[fontFamilyKey]).fontFamily!;

  late double currSize = EzConfig.prefs[fontSizeKey];

  late Color themeColor = Color(EzConfig.prefs[themeColorKey]);
  late Color themeTextColor = Color(EzConfig.prefs[themeTextColorKey]);
  late Color buttonTextColor = Color(EzConfig.prefs[buttonTextColorKey]);

  switch (style) {
    case headerStyleKey:
      return TextStyle(
        fontFamily: currFontFamily,
        fontSize: currSize * 2.0,
        color: color ?? themeColor,
        decoration: decoration,
        fontWeight: fontWeight ?? FontWeight.bold,
      );

    case titleStyleKey:
      return TextStyle(
        fontFamily: currFontFamily,
        fontSize: currSize * 1.5,
        color: color ?? themeTextColor,
        decoration: decoration,
        fontWeight: fontWeight,
      );

    case subTitleStyleKey:
      return TextStyle(
        fontFamily: currFontFamily,
        fontSize: currSize * 1.25,
        color: color ?? themeTextColor,
        decoration: decoration ?? TextDecoration.underline,
        fontWeight: fontWeight,
      );

    case dialogTitleStyleKey:
      return TextStyle(
        fontFamily: currFontFamily,
        fontSize: currSize * 1.25,
        color: color ?? themeTextColor,
        decoration: decoration ?? TextDecoration.underline,
        fontWeight: fontWeight,
      );

    case defaultStyleKey:
    case dialogContentStyleKey:
      return TextStyle(
        fontFamily: currFontFamily,
        fontSize: currSize,
        color: color ?? themeTextColor,
        decoration: decoration,
        fontWeight: fontWeight,
      );

    case buttonStyleKey:
    case colorSettingStyleKey:
    case fontSettingStyleKey:
    case imageSettingStyleKey:
    case sliderSettingStyleKey:
      return TextStyle(
        fontFamily: currFontFamily,
        fontSize: currSize,
        color: color ?? buttonTextColor,
        decoration: decoration,
        fontWeight: fontWeight,
      );

    case errorStyleKey:
    default:
      return TextStyle(
        fontSize: 48,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      );
  }
}

/// Sets all [TextStyle]s to the default case from [buildTextStyle]
/// [TextStyle]s are overwritten throughout EFUI, this serves as redundancy to insure third-party
/// [Widget] styling matches that of [EzConfig]
TextTheme materialTextTheme() {
  TextStyle defaultTextStyle = buildTextStyle(style: defaultStyleKey);

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
  TextStyle defaultTextStyle = buildTextStyle(style: defaultStyleKey);

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
