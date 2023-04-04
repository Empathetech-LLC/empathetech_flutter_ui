library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Text that values its personal space
/// And requires a [TextStyle], for wide [TargetPlatform] support
Widget ezText(
  String text, {
  required TextStyle style,
  TextAlign? textAlign,
  Color background = Colors.transparent,
}) {
  double padding = AppConfig.prefs[paddingKey] / 2.0;

  return Padding(
    padding: EdgeInsets.all(padding),
    child: Container(
      decoration: BoxDecoration(
        color: background.withOpacity(background.opacity * 0.75),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(padding),
      child: Text(text, style: style, textAlign: textAlign),
    ),
  );
}

/// Styles an [Icon] from [AppConfig.prefs]
Icon ezIcon(
  IconData icon, {
  Color? color,
  double? size,
}) {
  return Icon(
    icon,
    color: color ?? Color(AppConfig.prefs[buttonTextColorKey]),
    size: size,
  );
}

/// Styles a [PlatformTextFormField] from [AppConfig.prefs]
Widget ezForm({
  required Key? key,
  required TextEditingController? controller,
  required String? hintText,
  bool private = false,
  Iterable<String>? autofillHints,
  String? Function(String?)? validator,
  AutovalidateMode? autovalidateMode,
}) {
  // Gather theme data
  Color buttonColor = Color(AppConfig.prefs[buttonColorKey]);
  Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);

  return Container(
    decoration: BoxDecoration(border: Border.all(color: buttonColor)),
    child: Form(
      key: key,
      child: PlatformTextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        obscureText: private,

        // Hint
        hintText: hintText,
        autofillHints: autofillHints,

        // Validating
        validator: validator,
        autovalidateMode: autovalidateMode,

        // Styling
        style: getTextStyle(dialogContentStyleKey),
        cursorColor: themeTextColor,
      ),
    ),
  );
}

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
    case colorSettingStyleKey:
    case fontSettingStyleKey:
    case imageSettingStyleKey:
    case sliderSettingStyleKey:
      return TextStyle(
        fontFamily: currFontFamily,
        fontSize: currSize,
        color: buttonTextColor,
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

/// Sets all [TextStyle]s to the default case from [getTextStyle]
/// [TextStyle]s are overwritten throughout EFUI, this serves as redundancy to insure third-party
/// [Widget] styling matches that of [AppConfig]
TextTheme materialTextTheme() {
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

/// Sets all [TextStyle]s to the default case from [getTextStyle]
/// [TextStyle]s are overwritten throughout EFUI, this serves as redundancy to insure third-party
/// [Widget] styling matches that of [AppConfig]
CupertinoTextThemeData cupertinoTextTheme() {
  Color textColor = Color(AppConfig.prefs[themeTextColorKey]);
  TextStyle defaultTextStyle = getTextStyle(defaultStyleKey);

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
