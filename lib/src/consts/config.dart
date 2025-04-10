/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

//** Brand config **//

//* Default *//

// Text settings //

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

// Layout settings //

/// 10.0
const double defaultMargin = 10.0;

/// 20.0
const double defaultPadding = 20.0;

/// 25.0
const double defaultSpacing = 25.0;

// Color settings //

/// 0xFF20DAA5
const int empathEucalyptusHex = 0xFF20DAA5;

/// 0xFF20DAA5
const Color empathEucalyptus = Color(empathEucalyptusHex);

/// 0x4020DAA5
const int empathEucalyptusDimHex = 0x4020DAA5;

/// 0x4020DAA5
const Color empathEucalyptusDim = Color(empathEucalyptusHex);

/// 0xFFA520DA
const int empathPurpleHex = 0xFFA520DA;

/// 0xFFA520DA
const Color empathPurple = Color(empathPurpleHex);

/// 0x40A520DA
const int empathPurpleDimHex = 0x40A520DA;

/// 0x40A520DA
const Color empathPurpleDim = Color(empathPurpleDimHex);

/// 0xFFDAA520
const int empathSandHex = 0xFFDAA520;

/// 0xFFDAA520
const Color empathSand = Color(empathSandHex);

/// 0x40DAA520
const int empathSandDimHex = 0x40DAA520;

/// 0x40DAA520
const Color empathSandSim = Color(empathSandHex);

/// 0xFFFFFFFF
const int whiteHex = 0xFFFFFFFF;

/// 0xFFF5F5F5
const int offWhiteHex = 0xFFF5F5F5;

/// 0xFFF5F5F5
const Color empathOffWhite = Color(offWhiteHex);

/// 0xFF000000
const int blackHex = 0xFF000000;

/// 0xFF191919
const int offBlackHex = 0xFF191919;

/// 0xFF191919
const Color empathOffBlack = Color(offBlackHex);

/// 0xFF000000
const int transparentHex = 0x00000000;

//* Min *//

// Text theme //

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

// Layout settings //

/// 5.0
const double minMargin = 5.0;

/// 10.0
const double minPadding = 10.0;

/// 10.0
const double minSpacing = 10.0;

//* Max *//

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

// Layout settings //

/// 20.0
const double maxMargin = 20.0;

/// 40.0
const double maxPadding = 40.0;

/// 50.0
const double maxSpacing = 75.0;

//* Maps *//

/// Empathetech [EzConfig.defaults]
const Map<String, Object> empathetechConfig = <String, Object>{
  // Global settings //

  isLeftyKey: false,

  // Text settings //

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

  // Layout settings //

  marginKey: defaultMargin,
  paddingKey: defaultPadding,
  spacingKey: defaultSpacing,

  hideScrollKey: false,

  // Color settings //

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

  lightSurfaceKey: whiteHex,
  lightOnSurfaceKey: blackHex,
  lightSurfaceContainerKey: offWhiteHex,
  lightInversePrimaryKey: empathPurpleHex,
  lightSurfaceTintKey: transparentHex,

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

  darkSurfaceKey: blackHex,
  darkOnSurfaceKey: whiteHex,
  darkSurfaceContainerKey: offBlackHex,
  darkInversePrimaryKey: empathEucalyptusHex,
  darkSurfaceTintKey: transparentHex,

  // Image settings //

  lightBackgroundImageKey: noImageValue,
  '$lightBackgroundImageKey$boxFitSuffix': none,

  darkBackgroundImageKey: noImageValue,
  '$darkBackgroundImageKey$boxFitSuffix': none,
};

/// For testing
/// [EzConfig.defaults] set to all recommended max values
final Map<String, Object> empathetechMaxConfig = <String, Object>{
  ...empathetechConfig,

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

/// For testing
/// [EzConfig.defaults] set to all recommended min values
final Map<String, Object> empathetechMinConfig = <String, Object>{
  ...empathetechConfig,

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
