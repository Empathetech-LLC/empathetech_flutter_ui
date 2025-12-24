/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

//*** Brand config ***//
//** Default **//

//* Color settings *//

const int blackHex = 0xFF000000;
const int whiteHex = 0xFFFFFFFF;
const int transparentHex = 0x00000000;

// Secondary //

/// 0xFFDAA520
/// Open source consumers: DO NOT USE
const int empathSandHex = 0xFFDAA520;

/// 0xFFDAA520
/// Open source consumers: DO NOT USE
const Color empathSand = Color(empathSandHex);

/// 0x45DAA520
/// Open source consumers: DO NOT USE
const int empathSandDimHex = 0x45DAA520;

/// 0x45DAA520
/// Open source consumers: DO NOT USE
const Color empathSandDim = Color(empathSandHex);

// Dark:Primary | Light:Tertiary //

/// 0xFF20DAA5
/// Open source consumers: DO NOT USE
const int empathEucalyptusHex = 0xFF20DAA5;

/// 0xFF20DAA5
/// Open source consumers: DO NOT USE
const Color empathEucalyptus = Color(empathEucalyptusHex);

/// 0x4520DAA5
/// Open source consumers: DO NOT USE
const int empathEucalyptusDimHex = 0x4520DAA5;

/// 0x4520DAA5
/// Open source consumers: DO NOT USE
const Color empathEucalyptusDim = Color(empathEucalyptusHex);

// Dark:Tertiary | Light:Primary //

/// 0xFFA520DA
/// Open source consumers: DO NOT USE
const int empathPurpleHex = 0xFFA520DA;

/// 0xFFA520DA
/// Open source consumers: DO NOT USE
const Color empathPurple = Color(empathPurpleHex);

/// 0x45A520DA
/// Open source consumers: DO NOT USE
const int empathPurpleDimHex = 0x45A520DA;

/// 0x45A520DA
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

/// 0x8AFFFFFF == white w/ double [defaultButtonOutlineOpacity]
const int darkOutlineHex = 0x8AFFFFFF;

/// 0x8AFFFFFF == white w/ double [defaultButtonOutlineOpacity]
const Color darkOutline = Color(darkOutlineHex);

/// 0x45FFFFFF == white w/ [defaultButtonOutlineOpacity]
const int darkOutlineVariantHex = 0x45FFFFFF;

/// 0x45FFFFFF == white w/ [defaultButtonOutlineOpacity]
const Color darkOutlineVariant = Color(darkOutlineVariantHex);

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

/// 0x8A000000 == black w/ double [defaultButtonOutlineOpacity]
const int lightOutlineHex = 0x8A000000;

/// 0x8A000000 == black w/ double [defaultButtonOutlineOpacity]
const Color lightOutline = Color(lightOutlineHex);

/// 0x45000000 == black w/ [defaultButtonOutlineOpacity]
const int lightOutlineVariantHex = 0x45000000;

/// 0x45000000 == black w/ [defaultButtonOutlineOpacity]
const Color lightOutlineVariant = Color(lightOutlineVariantHex);

//* Design settings *//

/// 500
const int defaultAnimationDuration = 500;

/// 0x45 / 255
const double defaultButtonOutlineOpacity = 0.270588235294;

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

/// 42.0, 32.0, 22.0, 16.0, 14.0
const Map<String, double> fontSizeDefaults = <String, double>{
  darkDisplayFontSizeKey: defaultDisplaySize,
  lightDisplayFontSizeKey: defaultDisplaySize,
  darkHeadlineFontSizeKey: defaultHeadlineSize,
  lightHeadlineFontSizeKey: defaultHeadlineSize,
  darkTitleFontSizeKey: defaultTitleSize,
  lightTitleFontSizeKey: defaultTitleSize,
  darkBodyFontSizeKey: defaultBodySize,
  lightBodyFontSizeKey: defaultBodySize,
  darkLabelFontSizeKey: defaultLabelSize,
  lightLabelFontSizeKey: defaultLabelSize,
};

/// 0.0
const double defaultTextOpacity = 0.0;

/// 20.0
const double defaultIconSize = 20.0;

/// 2.0
const double iconDelta = 2.0;

/// 1.5
const double defaultFontHeight = 1.5;

/// 0.25
const double defaultLetterSpacing = 0.25;

/// 1.0
const double defaultWordSpacing = 1.0;

//** Min **//

// Design settings //

/// 0
const int minAnimationDuration = 0;

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
  darkDisplayFontSizeKey: minDisplay,
  lightDisplayFontSizeKey: minDisplay,
  darkHeadlineFontSizeKey: minHeadline,
  lightHeadlineFontSizeKey: minHeadline,
  darkTitleFontSizeKey: minTitle,
  lightTitleFontSizeKey: minTitle,
  darkBodyFontSizeKey: minBody,
  lightBodyFontSizeKey: minBody,
  darkLabelFontSizeKey: minLabel,
  lightLabelFontSizeKey: minLabel,
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

/// 1000
const int maxAnimationDuration = 1000;

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
  darkDisplayFontSizeKey: maxDisplay,
  lightDisplayFontSizeKey: maxDisplay,
  darkHeadlineFontSizeKey: maxHeadline,
  lightHeadlineFontSizeKey: maxHeadline,
  darkTitleFontSizeKey: maxTitle,
  lightTitleFontSizeKey: maxTitle,
  darkBodyFontSizeKey: maxBody,
  lightBodyFontSizeKey: maxBody,
  darkLabelFontSizeKey: maxLabel,
  lightLabelFontSizeKey: maxLabel,
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
  darkOutlineKey: darkOutlineHex,
  darkOutlineVariantKey: darkOutlineVariantHex,
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
  lightOutlineKey: lightOutlineHex,
  lightOutlineVariantKey: lightOutlineVariantHex,
  lightInversePrimaryKey: empathPurpleHex,
  lightSurfaceTintKey: transparentHex,

  lightColorSchemeImageKey: noImageValue,
  // userLightColorsKey: null, default defined in EzColorSettings()
  // Unassigned colors are automatically generated by ColorScheme.fromSeed

  // Design settings //

  // Dark
  darkAnimationDurationKey: defaultAnimationDuration,

  darkBackgroundImageKey: noImageValue,
  '$darkBackgroundImageKey$boxFitSuffix': none,
  darkButtonOpacityKey: maxOpacity,
  darkButtonOutlineOpacityKey: defaultButtonOutlineOpacity,

  // Light
  lightAnimationDurationKey: defaultAnimationDuration,

  lightBackgroundImageKey: noImageValue,
  '$lightBackgroundImageKey$boxFitSuffix': none,
  lightButtonOpacityKey: maxOpacity,
  lightButtonOutlineOpacityKey: defaultButtonOutlineOpacity,

  // Layout settings //

  // Dark
  darkMarginKey: defaultMargin,
  // padding and spacing defined in mobile/desktop configs

  // Light
  lightMarginKey: defaultMargin,
  // ditto

  // Text settings //
  // Selector
  advancedTextKey: false,

  // Dark
  darkDisplayFontFamilyKey: roboto,
  darkDisplayFontSizeKey: defaultDisplaySize,
  darkDisplayBoldedKey: false,
  darkDisplayItalicizedKey: false,
  darkDisplayUnderlinedKey: false,
  darkDisplayFontHeightKey: defaultFontHeight,
  darkDisplayLetterSpacingKey: defaultLetterSpacing,
  darkDisplayWordSpacingKey: defaultWordSpacing,

  darkHeadlineFontFamilyKey: roboto,
  darkHeadlineFontSizeKey: defaultHeadlineSize,
  darkHeadlineBoldedKey: false,
  darkHeadlineItalicizedKey: false,
  darkHeadlineUnderlinedKey: false,
  darkHeadlineFontHeightKey: defaultFontHeight,
  darkHeadlineLetterSpacingKey: defaultLetterSpacing,
  darkHeadlineWordSpacingKey: defaultWordSpacing,

  darkTitleFontFamilyKey: roboto,
  darkTitleFontSizeKey: defaultTitleSize,
  darkTitleBoldedKey: true,
  darkTitleItalicizedKey: false,
  darkTitleUnderlinedKey: false,
  darkTitleFontHeightKey: defaultFontHeight,
  darkTitleLetterSpacingKey: defaultLetterSpacing,
  darkTitleWordSpacingKey: defaultWordSpacing,

  darkBodyFontFamilyKey: roboto,
  darkBodyFontSizeKey: defaultBodySize,
  darkBodyBoldedKey: false,
  darkBodyItalicizedKey: false,
  darkBodyUnderlinedKey: false,
  darkBodyFontHeightKey: defaultFontHeight,
  darkBodyLetterSpacingKey: defaultLetterSpacing,
  darkBodyWordSpacingKey: defaultWordSpacing,

  darkLabelFontFamilyKey: roboto,
  darkLabelFontSizeKey: defaultLabelSize,
  darkLabelBoldedKey: false,
  darkLabelItalicizedKey: false,
  darkLabelUnderlinedKey: false,
  darkLabelFontHeightKey: defaultFontHeight,
  darkLabelLetterSpacingKey: defaultLetterSpacing,
  darkLabelWordSpacingKey: defaultWordSpacing,

  darkTextBackgroundOpacityKey: defaultTextOpacity,
  darkIconSizeKey: defaultIconSize,

  // Light
  lightDisplayFontFamilyKey: roboto,
  lightDisplayFontSizeKey: defaultDisplaySize,
  lightDisplayBoldedKey: false,
  lightDisplayItalicizedKey: false,
  lightDisplayUnderlinedKey: false,
  lightDisplayFontHeightKey: defaultFontHeight,
  lightDisplayLetterSpacingKey: defaultLetterSpacing,
  lightDisplayWordSpacingKey: defaultWordSpacing,

  lightHeadlineFontFamilyKey: roboto,
  lightHeadlineFontSizeKey: defaultHeadlineSize,
  lightHeadlineBoldedKey: false,
  lightHeadlineItalicizedKey: false,
  lightHeadlineUnderlinedKey: false,
  lightHeadlineFontHeightKey: defaultFontHeight,
  lightHeadlineLetterSpacingKey: defaultLetterSpacing,
  lightHeadlineWordSpacingKey: defaultWordSpacing,

  lightTitleFontFamilyKey: roboto,
  lightTitleFontSizeKey: defaultTitleSize,
  lightTitleBoldedKey: true,
  lightTitleItalicizedKey: false,
  lightTitleUnderlinedKey: false,
  lightTitleFontHeightKey: defaultFontHeight,
  lightTitleLetterSpacingKey: defaultLetterSpacing,
  lightTitleWordSpacingKey: defaultWordSpacing,

  lightBodyFontFamilyKey: roboto,
  lightBodyFontSizeKey: defaultBodySize,
  lightBodyBoldedKey: false,
  lightBodyItalicizedKey: false,
  lightBodyUnderlinedKey: false,
  lightBodyFontHeightKey: defaultFontHeight,
  lightBodyLetterSpacingKey: defaultLetterSpacing,
  lightBodyWordSpacingKey: defaultWordSpacing,

  lightLabelFontFamilyKey: roboto,
  lightLabelFontSizeKey: defaultLabelSize,
  lightLabelBoldedKey: false,
  lightLabelItalicizedKey: false,
  lightLabelUnderlinedKey: false,
  lightLabelFontHeightKey: defaultFontHeight,
  lightLabelLetterSpacingKey: defaultLetterSpacing,
  lightLabelWordSpacingKey: defaultWordSpacing,

  lightTextBackgroundOpacityKey: defaultTextOpacity,
  lightIconSizeKey: defaultIconSize,
};

/// [baseEmpathConfig] with a more compact layout and hidden scrolls
/// -- ATTENTION --
/// For open source consumers: this is Empathetech LLC's config
/// You do NOT have permission to use this config in your production app
const Map<String, Object> empathMobileConfig = <String, Object>{
  ...baseEmpathConfig,

  // Layout //

  // Dark
  darkPaddingKey: defaultMobilePadding,
  darkSpacingKey: defaultMobileSpacing,
  darkHideScrollKey: true,

  // Light
  lightPaddingKey: defaultMobilePadding,
  lightSpacingKey: defaultMobileSpacing,
  lightHideScrollKey: true,
};

/// [baseEmpathConfig] with a more open layout and visible scrolls
/// -- ATTENTION --
/// For open source consumers: this is Empathetech LLC's config
/// You do NOT have permission to use this config in your production app
const Map<String, Object> empathDesktopConfig = <String, Object>{
  ...baseEmpathConfig,

  // Layout //

  // Dark
  darkPaddingKey: defaultDesktopPadding,
  darkSpacingKey: defaultDesktopSpacing,
  darkHideScrollKey: false,

  // Light
  lightPaddingKey: defaultDesktopPadding,
  lightSpacingKey: defaultDesktopSpacing,
  lightHideScrollKey: false,
};

/// [EzConfig.defaults] set to all recommended max values
/// -- ATTENTION --
/// Open source do NOT have permission to use this config in production apps
/// Also, this is intended for testing anyway
final Map<String, Object> empathMaxConfig = <String, Object>{
  ...baseEmpathConfig,

  // Design settings //

  darkAnimationDurationKey: maxAnimationDuration,
  lightAnimationDurationKey: maxAnimationDuration,

  // Layout settings //

  darkMarginKey: maxMargin,
  lightMarginKey: maxMargin,
  darkPaddingKey: maxPadding,
  lightPaddingKey: maxPadding,
  darkSpacingKey: maxSpacing,
  lightSpacingKey: maxSpacing,

  darkHideScrollKey: false,
  lightHideScrollKey: false,

  // Text settings //

  // Display
  darkDisplayFontSizeKey: maxDisplay,
  lightDisplayFontSizeKey: maxDisplay,
  darkDisplayFontHeightKey: maxFontHeight,
  lightDisplayFontHeightKey: maxFontHeight,
  darkDisplayLetterSpacingKey: maxLetterSpacing,
  lightDisplayLetterSpacingKey: maxLetterSpacing,
  darkDisplayWordSpacingKey: maxWordSpacing,
  lightDisplayWordSpacingKey: maxWordSpacing,

  // Headline
  darkHeadlineFontSizeKey: maxHeadline,
  lightHeadlineFontSizeKey: maxHeadline,
  darkHeadlineFontHeightKey: maxFontHeight,
  lightHeadlineFontHeightKey: maxFontHeight,
  darkHeadlineLetterSpacingKey: maxLetterSpacing,
  lightHeadlineLetterSpacingKey: maxLetterSpacing,
  darkHeadlineWordSpacingKey: maxWordSpacing,
  lightHeadlineWordSpacingKey: maxWordSpacing,

  // Title
  darkTitleFontSizeKey: maxTitle,
  lightTitleFontSizeKey: maxTitle,
  darkTitleFontHeightKey: maxFontHeight,
  lightTitleFontHeightKey: maxFontHeight,
  darkTitleLetterSpacingKey: maxLetterSpacing,
  lightTitleLetterSpacingKey: maxLetterSpacing,
  darkTitleWordSpacingKey: maxWordSpacing,
  lightTitleWordSpacingKey: maxWordSpacing,

  // Body
  darkBodyFontSizeKey: maxBody,
  lightBodyFontSizeKey: maxBody,
  darkBodyFontHeightKey: maxFontHeight,
  lightBodyFontHeightKey: maxFontHeight,
  darkBodyLetterSpacingKey: maxLetterSpacing,
  lightBodyLetterSpacingKey: maxLetterSpacing,
  darkBodyWordSpacingKey: maxWordSpacing,
  lightBodyWordSpacingKey: maxWordSpacing,

  // Label
  darkLabelFontSizeKey: maxLabel,
  lightLabelFontSizeKey: maxLabel,
  darkLabelFontHeightKey: maxFontHeight,
  lightLabelFontHeightKey: maxFontHeight,
  darkLabelLetterSpacingKey: maxLetterSpacing,
  lightLabelLetterSpacingKey: maxLetterSpacing,
  darkLabelWordSpacingKey: maxWordSpacing,
  lightLabelWordSpacingKey: maxWordSpacing,

  darkIconSizeKey: maxIconSize,
  lightIconSizeKey: maxIconSize,
};

/// [EzConfig.defaults] set to all recommended min values
/// -- ATTENTION --
/// Open source do NOT have permission to use this config in production apps
/// Also, this is intended for testing anyway
final Map<String, Object> empathMinConfig = <String, Object>{
  ...baseEmpathConfig,

  // Design settings //

  darkAnimationDurationKey: minAnimationDuration,
  lightAnimationDurationKey: minAnimationDuration,

  // Layout settings //

  darkMarginKey: minMargin,
  lightMarginKey: minMargin,
  darkPaddingKey: minPadding,
  lightPaddingKey: minPadding,
  darkSpacingKey: minSpacing,
  lightSpacingKey: minSpacing,

  darkHideScrollKey: true,
  lightHideScrollKey: true,

  // Text settings //

  // Display
  darkDisplayFontSizeKey: minDisplay,
  lightDisplayFontSizeKey: minDisplay,
  darkDisplayFontHeightKey: minFontHeight,
  lightDisplayFontHeightKey: minFontHeight,
  darkDisplayLetterSpacingKey: minLetterSpacing,
  lightDisplayLetterSpacingKey: minLetterSpacing,
  darkDisplayWordSpacingKey: minWordSpacing,
  lightDisplayWordSpacingKey: minWordSpacing,

  // Headline
  darkHeadlineFontSizeKey: minHeadline,
  lightHeadlineFontSizeKey: minHeadline,
  darkHeadlineFontHeightKey: minFontHeight,
  lightHeadlineFontHeightKey: minFontHeight,
  darkHeadlineLetterSpacingKey: minLetterSpacing,
  lightHeadlineLetterSpacingKey: minLetterSpacing,
  darkHeadlineWordSpacingKey: minWordSpacing,
  lightHeadlineWordSpacingKey: minWordSpacing,

  // Title
  darkTitleFontSizeKey: minTitle,
  lightTitleFontSizeKey: minTitle,
  darkTitleFontHeightKey: minFontHeight,
  lightTitleFontHeightKey: minFontHeight,
  darkTitleLetterSpacingKey: minLetterSpacing,
  lightTitleLetterSpacingKey: minLetterSpacing,
  darkTitleWordSpacingKey: minWordSpacing,
  lightTitleWordSpacingKey: minWordSpacing,

  // Body
  darkBodyFontSizeKey: minBody,
  lightBodyFontSizeKey: minBody,
  darkBodyFontHeightKey: minFontHeight,
  lightBodyFontHeightKey: minFontHeight,
  darkBodyLetterSpacingKey: minLetterSpacing,
  lightBodyLetterSpacingKey: minLetterSpacing,
  darkBodyWordSpacingKey: minWordSpacing,
  lightBodyWordSpacingKey: minWordSpacing,

  // Label
  darkLabelFontSizeKey: minLabel,
  lightLabelFontSizeKey: minLabel,
  darkLabelFontHeightKey: minFontHeight,
  lightLabelFontHeightKey: minFontHeight,
  darkLabelLetterSpacingKey: minLetterSpacing,
  lightLabelLetterSpacingKey: minLetterSpacing,
  darkLabelWordSpacingKey: minWordSpacing,
  lightLabelWordSpacingKey: minWordSpacing,

  darkIconSizeKey: minIconSize,
  lightIconSizeKey: minIconSize,
};
