/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

//*** Brand config ***//
//** Default **//

//* Color settings *//
// Shared //

/// 0xFF000000
const int blackHex = 0xFF000000;

/// 0x7F000000
const int dimBlackHex = 0x7F000000;

/// 0x7F000000
const Color dimBlack = Color(dimBlackHex);

/// 0xFFFFFFFF
const int whiteHex = 0xFFFFFFFF;

/// 0x7FFFFFFF
const int dimWhiteHex = 0x7FFFFFFF;

/// 0x7FFFFFFF
const Color dimWhite = Color(dimWhiteHex);

/// 0x00000000
const int transparentHex = 0x00000000;

// Secondary //

/// 0xFFDAA520
/// Open source consumers: DO NOT USE
const int empathSandHex = 0xFFDAA520;

/// 0xFFDAA520
/// Open source consumers: DO NOT USE
const Color empathSand = Color(empathSandHex);

/// 0x40DAA520
/// Open source consumers: DO NOT USE
const int empathSandDimHex = 0x40DAA520;

/// 0x40DAA520
/// Open source consumers: DO NOT USE
const Color empathSandDim = Color(empathSandHex);

// Dark:Primary | Light:Tertiary //

/// 0xFF20DAA5
/// Open source consumers: DO NOT USE
const int empathEucalyptusHex = 0xFF20DAA5;

/// 0xFF20DAA5
/// Open source consumers: DO NOT USE
const Color empathEucalyptus = Color(empathEucalyptusHex);

/// 0x4020DAA5
/// Open source consumers: DO NOT USE
const int empathEucalyptusDimHex = 0x4020DAA5;

/// 0x4020DAA5
/// Open source consumers: DO NOT USE
const Color empathEucalyptusDim = Color(empathEucalyptusHex);

// Dark:Tertiary | Light:Primary //

/// 0xFFA520DA
/// Open source consumers: DO NOT USE
const int empathPurpleHex = 0xFFA520DA;

/// 0xFFA520DA
/// Open source consumers: DO NOT USE
const Color empathPurple = Color(empathPurpleHex);

/// 0x40A520DA
/// Open source consumers: DO NOT USE
const int empathPurpleDimHex = 0x40A520DA;

/// 0x40A520DA
/// Open source consumers: DO NOT USE
const Color empathPurpleDim = Color(empathPurpleDimHex);

// Dark //

/// 0xFF111111 == 17 of each
const int darkSurfaceContainerHex = 0xFF111111;

/// 0xFF111111 == 17 of each
const Color darkSurfaceContainer = Color(darkSurfaceContainerHex);

/// 0xFF191919 == 25 of each
const int darkSurfaceDimHex = 0xFF191919;

/// 0xFF191919 == 25 of each
const Color darkSurfaceDim = Color(darkSurfaceDimHex);

/// 0xFF222222 == 34 of each
const int darkSurfaceHex = 0xFF222222;

/// 0xFF222222 == 34 of each
const Color darkSurface = Color(darkSurfaceHex);

// Light //

/// 0xFFF0F0F0 == -15 of each
const int lightSurfaceContainerHex = 0xFFF0F0F0;

/// 0xFFF0F0F0 == -15 of each
const Color lightSurfaceContainer = Color(lightSurfaceContainerHex);

/// 0xFFF8F8F8 == -7 of each
const int lightSurfaceDimHex = 0xFFF8F8F8;

/// 0xFFF8F8F8 == -7 of each
const Color lightSurfaceDim = Color(lightSurfaceDimHex);

/// 0xFFFFFFFF == white
const int lightSurfaceHex = whiteHex;

/// 0xFFFFFFFF == white
const Color lightSurface = Color(lightSurfaceHex);

//* Design settings *//

/// 200.0
const double defaultAnimationDuration = 200.0;

//* Layout settings *//

/// 10.0
const double defaultMargin = 10.0;

/// 17.5
const double defaultMobilePadding = 17.5;

/// 17.5
const double defaultDesktopPadding = 20.0;

/// 25.0
const double defaultMobileSpacing = 25.0;

/// 25.0
const double defaultDesktopSpacing = 30.0;

//* Text settings *//

/// 42.0
const double defaultDisplaySize = 42.0;

/// 32.0
const double defaultHeadlineSize = 32.0;

/// 22.0
const double defaultTitleSize = 22.0;

/// 16.0
const double defaultBodySize = 16.0;

/// 14.0
const double defaultLabelSize = 14.0;

/// 0.0
const double defaultTextOpacity = 0.0;

/// 20.0
const double defaultIconSize = 20.0;

/// 1.5
const double defaultFontHeight = 1.5;

/// 0.25
const double defaultLetterSpacing = 0.25;

/// 1.0
const double defaultWordSpacing = 1.0;

//** Min **//

// Design settings //

/// 0.0
const double minAnimationDuration = 0.0;

// Layout settings //

/// 5.0
const double minMargin = 5.0;

/// 10.0
const double minPadding = 10.0;

/// 10.0
const double minSpacing = 10.0;

// Text settings //

/// 21.0
const double minDisplay = 21.0;

/// 16.0
const double minHeadline = 16.0;

/// 11.0
const double minTitle = 11.0;

/// 8.0
const double minBody = 8.0;

/// 7.0
const double minLabel = 7.0;

/// 21.0, 16.0, 11.0, 8.0, 7.0
const Map<String, double> fontSizeMins = <String, double>{
  displayFontSizeKey: minDisplay,
  headlineFontSizeKey: minHeadline,
  titleFontSizeKey: minTitle,
  bodyFontSizeKey: minBody,
  labelFontSizeKey: minLabel,
};

/// 0.0
const double minOpacity = 0.0;

/// 16.0
const double minIconSize = 16.0;

/// 0.0
const double minLetterSpacing = 0.0;

/// 0.0
const double minWordSpacing = 0.0;

/// 1.0
const double minFontHeight = 1.0;

//** Max **//

// Design settings //

/// 1000.0
const double maxAnimationDuration = 1000.0;

// Layout settings //

/// 20.0
const double maxMargin = 20.0;

/// 40.0
const double maxPadding = 40.0;

/// 50.0
const double maxSpacing = 75.0;

// Text settings //

/// 84.0
const double maxDisplay = 84.0;

/// 64.0
const double maxHeadline = 64.0;

/// 42.0
const double maxTitle = 42.0;

/// 32.0
const double maxBody = 32.0;

/// 28.0
const double maxLabel = 28.0;

/// 84.0, 64.0, 42.0, 32.0, 28.0
const Map<String, double> fontSizeMaxes = <String, double>{
  displayFontSizeKey: maxDisplay,
  headlineFontSizeKey: maxHeadline,
  titleFontSizeKey: maxTitle,
  bodyFontSizeKey: maxBody,
  labelFontSizeKey: maxLabel,
};

/// 1.0
const double maxOpacity = 1.0;

/// 48.0
const double maxIconSize = 48.0;

/// 2.0
const double maxLetterSpacing = 2.0;

/// 3.0
const double maxWordSpacing = 3.0;

/// 2.0
const double maxFontHeight = 2.0;

//** Maps **//

/// Empathetech [EzConfig.defaults] base to build from
/// For open source consumers: this is Empathetech LLC's config
/// You have permission to modify this code
/// You do not have permission to use this config in your app
const Map<String, Object> baseEmpathConfig = <String, Object>{
  // Global settings //

  isLeftyKey: false,
  // isDarkThemeKey: null => system
  // appLocaleKey: null => system

  // Color settings //
  // Selector
  advancedColorsKey: false,

  // Dark
  darkPrimaryKey: empathEucalyptusHex,
  darkPrimaryContainerKey: empathEucalyptusDimHex,
  darkOnPrimaryKey: blackHex,
  darkOnPrimaryContainerKey: blackHex,

  darkSecondaryKey: empathSandHex,
  darkSecondaryContainerKey: empathSandDimHex,
  darkOnSecondaryKey: blackHex,
  darkOnSecondaryContainerKey: blackHex,

  darkTertiaryKey: empathPurpleHex,
  darkTertiaryContainerKey: empathPurpleDimHex,
  darkOnTertiaryKey: whiteHex,
  darkOnTertiaryContainerKey: whiteHex,

  darkSurfaceKey: darkSurfaceHex,
  darkOnSurfaceKey: whiteHex,
  darkSurfaceDimKey: darkSurfaceDimHex,
  darkSurfaceContainerKey: darkSurfaceContainerHex,
  darkInversePrimaryKey: empathEucalyptusHex,
  darkSurfaceTintKey: transparentHex,

  darkColorSchemeImageKey: noImageValue,
  // userDarkColorsKey: null, default defined in EzColorSettings()

  // Light
  lightPrimaryKey: empathPurpleHex,
  lightPrimaryContainerKey: empathPurpleDimHex,
  lightOnPrimaryKey: whiteHex,
  lightOnPrimaryContainerKey: whiteHex,

  lightSecondaryKey: empathSandHex,
  lightSecondaryContainerKey: empathSandDimHex,
  lightOnSecondaryKey: blackHex,
  lightOnSecondaryContainerKey: blackHex,

  lightTertiaryKey: empathEucalyptusHex,
  lightTertiaryContainerKey: empathEucalyptusDimHex,
  lightOnTertiaryKey: blackHex,
  lightOnTertiaryContainerKey: blackHex,

  lightSurfaceKey: lightSurfaceHex,
  lightOnSurfaceKey: blackHex,
  lightSurfaceDimKey: lightSurfaceDimHex,
  lightSurfaceContainerKey: lightSurfaceContainerHex,
  lightInversePrimaryKey: empathPurpleHex,
  lightSurfaceTintKey: transparentHex,

  lightColorSchemeImageKey: noImageValue,
  // userLightColorsKey: null, default defined in EzColorSettings()

  // Unassigned colors are automatically generated by ColorScheme.fromSeed

  // Design settings //

  // Global
  animationDurationKey: defaultAnimationDuration,

  // Dark
  darkBackgroundImageKey: noImageValue,
  '$darkBackgroundImageKey$boxFitSuffix': none,
  darkButtonOpacityKey: maxOpacity,
  darkOutlineOpacityKey: maxOpacity,
  darkGlassKey: false,

  // Light
  lightBackgroundImageKey: noImageValue,
  '$lightBackgroundImageKey$boxFitSuffix': none,
  lightButtonOpacityKey: maxOpacity,
  lightOutlineOpacityKey: maxOpacity,
  lightGlassKey: false,

  // Layout settings //

  marginKey: defaultMargin,

  // Text settings //
  // Selector
  advancedTextKey: false,

  // Display
  displayFontFamilyKey: roboto,
  displayFontSizeKey: defaultDisplaySize,
  displayBoldedKey: false,
  displayItalicizedKey: false,
  displayUnderlinedKey: false,
  displayFontHeightKey: defaultFontHeight,
  displayLetterSpacingKey: defaultLetterSpacing,
  displayWordSpacingKey: defaultWordSpacing,

  // Headline
  headlineFontFamilyKey: roboto,
  headlineFontSizeKey: defaultHeadlineSize,
  headlineBoldedKey: false,
  headlineItalicizedKey: false,
  headlineUnderlinedKey: false,
  headlineFontHeightKey: defaultFontHeight,
  headlineLetterSpacingKey: defaultLetterSpacing,
  headlineWordSpacingKey: defaultWordSpacing,

  // Title
  titleFontFamilyKey: roboto,
  titleFontSizeKey: defaultTitleSize,
  titleBoldedKey: true,
  titleItalicizedKey: false,
  titleUnderlinedKey: false,
  titleFontHeightKey: defaultFontHeight,
  titleLetterSpacingKey: defaultLetterSpacing,
  titleWordSpacingKey: defaultWordSpacing,

  // Body
  bodyFontFamilyKey: roboto,
  bodyFontSizeKey: defaultBodySize,
  bodyBoldedKey: false,
  bodyItalicizedKey: false,
  bodyUnderlinedKey: false,
  bodyFontHeightKey: defaultFontHeight,
  bodyLetterSpacingKey: defaultLetterSpacing,
  bodyWordSpacingKey: defaultWordSpacing,

  // Label
  labelFontFamilyKey: roboto,
  labelFontSizeKey: defaultLabelSize,
  labelBoldedKey: false,
  labelItalicizedKey: false,
  labelUnderlinedKey: false,
  labelFontHeightKey: defaultFontHeight,
  labelLetterSpacingKey: defaultLetterSpacing,
  labelWordSpacingKey: defaultWordSpacing,

  // Background opacity
  darkTextBackgroundOpacityKey: defaultTextOpacity,
  lightTextBackgroundOpacityKey: defaultTextOpacity,

  // Icon size
  iconSizeKey: defaultIconSize,
};

/// base with a more compact layout and hidden scrolls
/// For open source consumers: this is Empathetech LLC's config
/// You have permission to modify this code
/// You do not have permission to use this config in your app
const Map<String, Object> mobileEmpathConfig = <String, Object>{
  ...baseEmpathConfig,

  // Layout
  paddingKey: defaultMobilePadding,
  spacingKey: defaultMobileSpacing,
  hideScrollKey: true,
};

/// base with a more open layout and visible scrolls
/// For open source consumers: this is Empathetech LLC's config
/// You have permission to modify this code
/// You do not have permission to use this config in your app
const Map<String, Object> desktopEmpathConfig = <String, Object>{
  ...baseEmpathConfig,

  // Layout
  paddingKey: defaultDesktopPadding,
  spacingKey: defaultDesktopSpacing,
  hideScrollKey: false,
};

/// [EzConfig.defaults] set to all recommended max values
/// For open source consumers: you may use this in testing, but not in production
final Map<String, Object> empathetechMaxConfig = <String, Object>{
  ...baseEmpathConfig,

  // Text settings //

  // Display
  displayFontSizeKey: maxDisplay,
  displayFontHeightKey: maxFontHeight,
  displayLetterSpacingKey: maxLetterSpacing,
  displayWordSpacingKey: maxWordSpacing,

  // Headline
  headlineFontSizeKey: maxHeadline,
  headlineFontHeightKey: maxFontHeight,
  headlineLetterSpacingKey: maxLetterSpacing,
  headlineWordSpacingKey: maxWordSpacing,

  // Title
  titleFontSizeKey: maxTitle,
  titleFontHeightKey: maxFontHeight,
  titleLetterSpacingKey: maxLetterSpacing,
  titleWordSpacingKey: maxWordSpacing,

  // Body
  bodyFontSizeKey: maxBody,
  bodyFontHeightKey: maxFontHeight,
  bodyLetterSpacingKey: maxLetterSpacing,
  bodyWordSpacingKey: maxWordSpacing,

  // Label
  labelFontSizeKey: maxLabel,
  labelFontHeightKey: maxFontHeight,
  labelLetterSpacingKey: maxLetterSpacing,
  labelWordSpacingKey: maxWordSpacing,

  iconSizeKey: maxIconSize,

  // Layout settings //

  marginKey: maxMargin,
  paddingKey: maxPadding,
  spacingKey: maxSpacing,
};

/// [EzConfig.defaults] set to all recommended min values
/// For open source consumers: you may use this in testing, but not in production
final Map<String, Object> empathetechMinConfig = <String, Object>{
  ...baseEmpathConfig,

  // Text settings //

  // Display
  displayFontSizeKey: minDisplay,
  displayFontHeightKey: minFontHeight,
  displayLetterSpacingKey: minLetterSpacing,
  displayWordSpacingKey: minWordSpacing,

  // Headline
  headlineFontSizeKey: minHeadline,
  headlineFontHeightKey: minFontHeight,
  headlineLetterSpacingKey: minLetterSpacing,
  headlineWordSpacingKey: minWordSpacing,

  // Title
  titleFontSizeKey: minTitle,
  titleFontHeightKey: minFontHeight,
  titleLetterSpacingKey: minLetterSpacing,
  titleWordSpacingKey: minWordSpacing,

  // Body
  bodyFontSizeKey: minBody,
  bodyFontHeightKey: minFontHeight,
  bodyLetterSpacingKey: minLetterSpacing,
  bodyWordSpacingKey: minWordSpacing,

  // Label
  labelFontSizeKey: minLabel,
  labelFontHeightKey: minFontHeight,
  labelLetterSpacingKey: minLetterSpacing,
  labelWordSpacingKey: minWordSpacing,

  iconSizeKey: minIconSize,

  // Layout settings //

  marginKey: minMargin,
  paddingKey: minPadding,
  spacingKey: minSpacing,
};
