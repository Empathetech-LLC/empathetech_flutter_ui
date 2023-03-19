library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// Local text type(s)

const String defaultStyleKey = 'defaultStyle';
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

/// Returns the [textType] style, built from the current [AppConfig.prefs] values
TextStyle getTextStyle(String textType) {
  late String currFontFamily =
      googleStyleAlias(AppConfig.prefs[fontFamilyKey]).fontFamily!;

  late double currSize = AppConfig.prefs[fontSizeKey];

  late Color themeColor = Color(AppConfig.prefs[themeColorKey]);
  late Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);
  late Color buttonTextColor = Color(AppConfig.prefs[buttonTextColorKey]);

  switch (textType) {
    case defaultStyleKey:
      return TextStyle(
        fontFamily: currFontFamily,
        fontSize: currSize,
        color: themeTextColor,
      );

    case titleStyleKey:
      return TextStyle(
        fontFamily: currFontFamily,
        fontSize: currSize * 1.5,
        color: themeTextColor,
      );

    case subTitleStyleKey:
      return TextStyle(
        fontFamily: currFontFamily,
        fontSize: currSize * 1.25,
        color: themeTextColor,
        decoration: TextDecoration.underline,
      );

    case dialogTitleStyleKey:
      return TextStyle(
        fontFamily: currFontFamily,
        fontSize: currSize * 1.25,
        color: themeTextColor,
      );

    case dialogContentStyleKey:
      return TextStyle(
        fontFamily: currFontFamily,
        fontSize: currSize,
        color: themeTextColor,
      );

    case buttonStyleKey:
    case imageSettingStyleKey:
    case fontSettingStyleKey:
    case sliderSettingStyleKey:
      return TextStyle(
        fontFamily: currFontFamily,
        fontSize: currSize,
        color: buttonTextColor,
      );

    case colorSettingStyleKey:
      return TextStyle(
        fontFamily: currFontFamily,
        fontSize: currSize,
        color: themeColor,
      );

    case errorStyleKey:
    default:
      return TextStyle(
        fontSize: 48,
        color: Colors.red,
      );
  }
}

// Local text theme(s)

TextTheme defaultTextTheme() {
  TextStyle defaultTextStyle = getTextStyle(defaultStyleKey);

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

// Supported Google font(s)

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

/// Returns the [GoogleFonts] styling for [fontName]
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
