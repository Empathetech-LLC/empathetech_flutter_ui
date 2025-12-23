/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

//* Global (home) settings' keys *//

const String isLeftyKey = 'isLefty';

const String isDarkThemeKey = 'isDarkTheme';

const String appLocaleKey = 'appLocale';

///  [isLeftyKey], [isDarkThemeKey], [appLocaleKey]
const Map<String, Type> allGlobalKeys = <String, Type>{
  isLeftyKey: bool,
  isDarkThemeKey: bool,
  appLocaleKey: List<String>,
};

//* Color settings' keys *//

// Dark theme //

const String darkPrimaryKey = 'darkPrimary';
const String darkOnPrimaryKey = 'darkOnPrimary';
const String darkPrimaryContainerKey = 'darkPrimaryContainer';
const String darkOnPrimaryContainerKey = 'darkOnPrimaryContainer';

const String darkPrimaryFixedKey = 'darkPrimaryFixed';
const String darkPrimaryFixedDimKey = 'darkPrimaryFixedDim';
const String darkOnPrimaryFixedKey = 'darkOnPrimaryFixed';
const String darkOnPrimaryFixedVariantKey = 'darkOnPrimaryFixedVariant';

const String darkSecondaryKey = 'darkSecondary';
const String darkOnSecondaryKey = 'darkOnSecondary';
const String darkSecondaryContainerKey = 'darkSecondaryContainer';
const String darkOnSecondaryContainerKey = 'darkOnSecondaryContainer';

const String darkSecondaryFixedKey = 'darkSecondaryFixed';
const String darkSecondaryFixedDimKey = 'darkSecondaryFixedDim';
const String darkOnSecondaryFixedKey = 'darkOnSecondaryFixed';
const String darkOnSecondaryFixedVariantKey = 'darkOnSecondaryFixedVariant';

const String darkTertiaryKey = 'darkTertiary';
const String darkOnTertiaryKey = 'darkOnTertiary';
const String darkTertiaryContainerKey = 'darkTertiaryContainer';
const String darkOnTertiaryContainerKey = 'darkOnTertiaryContainer';

const String darkTertiaryFixedKey = 'darkTertiaryFixed';
const String darkTertiaryFixedDimKey = 'darkTertiaryFixedDim';
const String darkOnTertiaryFixedKey = 'darkOnTertiaryFixed';
const String darkOnTertiaryFixedVariantKey = 'darkOnTertiaryFixedVariant';

const String darkErrorKey = 'darkError';
const String darkOnErrorKey = 'darkOnError';
const String darkErrorContainerKey = 'darkErrorContainer';
const String darkOnErrorContainerKey = 'darkOnErrorContainer';

const String darkOutlineKey = 'darkOutline';
const String darkOutlineVariantKey = 'darkOutlineVariant';

const String darkSurfaceKey = 'darkSurface';
const String darkOnSurfaceKey = 'darkOnSurface';
const String darkSurfaceDimKey = 'darkSurfaceDim';
const String darkSurfaceBrightKey = 'darkSurfaceBright';

const String darkSurfaceContainerLowestKey = 'darkSurfaceContainerLowest';
const String darkSurfaceContainerLowKey = 'darkSurfaceContainerLow';
const String darkSurfaceContainerKey = 'darkSurfaceContainer';
const String darkSurfaceContainerHighKey = 'darkSurfaceContainerHigh';
const String darkSurfaceContainerHighestKey = 'darkSurfaceContainerHighest';

const String darkOnSurfaceVariantKey = 'darkOnSurfaceVariant';
const String darkInverseSurfaceKey = 'darkInverseSurface';
const String darkOnInverseSurfaceKey = 'darkOnInverseSurface';
const String darkInversePrimaryKey = 'darkInversePrimary';

const String darkShadowKey = 'darkShadow';
const String darkScrimKey = 'darkScrim';
const String darkSurfaceTintKey = 'darkSurfaceTint';

/// Ordered [List] for populating color setting screen(s)
const List<String> darkColorOrder = <String>[
  darkPrimaryKey,
  darkOnPrimaryKey,
  darkPrimaryContainerKey,
  darkOnPrimaryContainerKey,
  darkPrimaryFixedKey,
  darkPrimaryFixedDimKey,
  darkOnPrimaryFixedKey,
  darkOnPrimaryFixedVariantKey,
  darkSecondaryKey,
  darkOnSecondaryKey,
  darkSecondaryContainerKey,
  darkOnSecondaryContainerKey,
  darkSecondaryFixedKey,
  darkSecondaryFixedDimKey,
  darkOnSecondaryFixedKey,
  darkOnSecondaryFixedVariantKey,
  darkTertiaryKey,
  darkOnTertiaryKey,
  darkTertiaryContainerKey,
  darkOnTertiaryContainerKey,
  darkTertiaryFixedKey,
  darkTertiaryFixedDimKey,
  darkOnTertiaryFixedKey,
  darkOnTertiaryFixedVariantKey,
  darkErrorKey,
  darkOnErrorKey,
  darkErrorContainerKey,
  darkOnErrorContainerKey,
  darkSurfaceKey,
  darkOnSurfaceKey,
  darkSurfaceDimKey,
  darkSurfaceBrightKey,
  darkSurfaceContainerLowestKey,
  darkSurfaceContainerLowKey,
  darkSurfaceContainerKey,
  darkSurfaceContainerHighKey,
  darkSurfaceContainerHighestKey,
  darkOnSurfaceVariantKey,
  darkOutlineKey,
  darkOutlineVariantKey,
  darkShadowKey,
  darkScrimKey,
  darkInverseSurfaceKey,
  darkOnInverseSurfaceKey,
  darkInversePrimaryKey,
  darkSurfaceTintKey,
];

const String darkColorSchemeImageKey = 'darkColorSchemeImage';
const String userDarkColorsKey = 'userDarkColors';

/// [darkColorOrder], [darkColorSchemeImageKey], && [userDarkColorsKey]
const Map<String, Type> darkColorKeys = <String, Type>{
  // Color scheme
  darkPrimaryKey: int,
  darkOnPrimaryKey: int,
  darkPrimaryContainerKey: int,
  darkOnPrimaryContainerKey: int,
  darkPrimaryFixedKey: int,
  darkPrimaryFixedDimKey: int,
  darkOnPrimaryFixedKey: int,
  darkOnPrimaryFixedVariantKey: int,
  darkSecondaryKey: int,
  darkOnSecondaryKey: int,
  darkSecondaryContainerKey: int,
  darkOnSecondaryContainerKey: int,
  darkSecondaryFixedKey: int,
  darkSecondaryFixedDimKey: int,
  darkOnSecondaryFixedKey: int,
  darkOnSecondaryFixedVariantKey: int,
  darkTertiaryKey: int,
  darkOnTertiaryKey: int,
  darkTertiaryContainerKey: int,
  darkOnTertiaryContainerKey: int,
  darkTertiaryFixedKey: int,
  darkTertiaryFixedDimKey: int,
  darkOnTertiaryFixedKey: int,
  darkOnTertiaryFixedVariantKey: int,
  darkErrorKey: int,
  darkOnErrorKey: int,
  darkErrorContainerKey: int,
  darkOnErrorContainerKey: int,
  darkOutlineKey: int,
  darkOutlineVariantKey: int,
  darkSurfaceKey: int,
  darkOnSurfaceKey: int,
  darkSurfaceDimKey: int,
  darkSurfaceBrightKey: int,
  darkSurfaceContainerLowestKey: int,
  darkSurfaceContainerLowKey: int,
  darkSurfaceContainerKey: int,
  darkSurfaceContainerHighKey: int,
  darkSurfaceContainerHighestKey: int,
  darkOnSurfaceVariantKey: int,
  darkInverseSurfaceKey: int,
  darkOnInverseSurfaceKey: int,
  darkInversePrimaryKey: int,
  darkScrimKey: int,
  darkShadowKey: int,
  darkSurfaceTintKey: int,

  // Helpers
  darkColorSchemeImageKey: String,
  userDarkColorsKey: List<String>,
};

// Light theme //

const String lightPrimaryKey = 'lightPrimary';
const String lightOnPrimaryKey = 'lightOnPrimary';
const String lightPrimaryContainerKey = 'lightPrimaryContainer';
const String lightOnPrimaryContainerKey = 'lightOnPrimaryContainer';

const String lightPrimaryFixedKey = 'lightPrimaryFixed';
const String lightPrimaryFixedDimKey = 'lightPrimaryFixedDim';
const String lightOnPrimaryFixedKey = 'lightOnPrimaryFixed';
const String lightOnPrimaryFixedVariantKey = 'lightOnPrimaryFixedVariant';

const String lightSecondaryKey = 'lightSecondary';
const String lightOnSecondaryKey = 'lightOnSecondary';
const String lightSecondaryContainerKey = 'lightSecondaryContainer';
const String lightOnSecondaryContainerKey = 'lightOnSecondaryContainer';

const String lightSecondaryFixedKey = 'lightSecondaryFixed';
const String lightSecondaryFixedDimKey = 'lightSecondaryFixedDim';
const String lightOnSecondaryFixedKey = 'lightOnSecondaryFixed';
const String lightOnSecondaryFixedVariantKey = 'lightOnSecondaryFixedVariant';

const String lightTertiaryKey = 'lightTertiary';
const String lightOnTertiaryKey = 'lightOnTertiary';
const String lightTertiaryContainerKey = 'lightTertiaryContainer';
const String lightOnTertiaryContainerKey = 'lightOnTertiaryContainer';

const String lightTertiaryFixedKey = 'lightTertiaryFixed';
const String lightTertiaryFixedDimKey = 'lightTertiaryFixedDim';
const String lightOnTertiaryFixedKey = 'lightOnTertiaryFixed';
const String lightOnTertiaryFixedVariantKey = 'lightOnTertiaryFixedVariant';

const String lightErrorKey = 'lightError';
const String lightOnErrorKey = 'lightOnError';
const String lightErrorContainerKey = 'lightErrorContainer';
const String lightOnErrorContainerKey = 'lightOnErrorContainer';

const String lightOutlineKey = 'lightOutline';
const String lightOutlineVariantKey = 'lightOutlineVariant';

const String lightSurfaceKey = 'lightSurface';
const String lightOnSurfaceKey = 'lightOnSurface';
const String lightSurfaceDimKey = 'lightSurfaceDim';
const String lightSurfaceBrightKey = 'lightSurfaceBright';

const String lightSurfaceContainerLowestKey = 'lightSurfaceContainerLowest';
const String lightSurfaceContainerLowKey = 'lightSurfaceContainerLow';
const String lightSurfaceContainerKey = 'lightSurfaceContainer';
const String lightSurfaceContainerHighKey = 'lightSurfaceContainerHigh';
const String lightSurfaceContainerHighestKey = 'lightSurfaceContainerHighest';

const String lightOnSurfaceVariantKey = 'lightOnSurfaceVariant';
const String lightInverseSurfaceKey = 'lightInverseSurface';
const String lightOnInverseSurfaceKey = 'lightOnInverseSurface';
const String lightInversePrimaryKey = 'lightInversePrimary';

const String lightShadowKey = 'lightShadow';
const String lightScrimKey = 'lightScrim';
const String lightSurfaceTintKey = 'lightSurfaceTint';

/// Ordered [List] for populating color setting screen(s)
const List<String> lightColorOrder = <String>[
  lightPrimaryKey,
  lightOnPrimaryKey,
  lightPrimaryContainerKey,
  lightOnPrimaryContainerKey,
  lightPrimaryFixedKey,
  lightPrimaryFixedDimKey,
  lightOnPrimaryFixedKey,
  lightOnPrimaryFixedVariantKey,
  lightSecondaryKey,
  lightOnSecondaryKey,
  lightSecondaryContainerKey,
  lightOnSecondaryContainerKey,
  lightSecondaryFixedKey,
  lightSecondaryFixedDimKey,
  lightOnSecondaryFixedKey,
  lightOnSecondaryFixedVariantKey,
  lightTertiaryKey,
  lightOnTertiaryKey,
  lightTertiaryContainerKey,
  lightOnTertiaryContainerKey,
  lightTertiaryFixedKey,
  lightTertiaryFixedDimKey,
  lightOnTertiaryFixedKey,
  lightOnTertiaryFixedVariantKey,
  lightErrorKey,
  lightOnErrorKey,
  lightErrorContainerKey,
  lightOnErrorContainerKey,
  lightSurfaceKey,
  lightOnSurfaceKey,
  lightSurfaceDimKey,
  lightSurfaceBrightKey,
  lightSurfaceContainerLowestKey,
  lightSurfaceContainerLowKey,
  lightSurfaceContainerKey,
  lightSurfaceContainerHighKey,
  lightSurfaceContainerHighestKey,
  lightOnSurfaceVariantKey,
  lightOutlineKey,
  lightOutlineVariantKey,
  lightShadowKey,
  lightScrimKey,
  lightInverseSurfaceKey,
  lightOnInverseSurfaceKey,
  lightInversePrimaryKey,
  lightSurfaceTintKey,
];

const String lightColorSchemeImageKey = 'lightColorSchemeImage';
const String userLightColorsKey = 'userLightColors';

/// [lightColorOrder], [lightColorSchemeImageKey], && [userLightColorsKey]
const Map<String, Type> lightColorKeys = <String, Type>{
  // Color scheme
  lightPrimaryKey: int,
  lightOnPrimaryKey: int,
  lightPrimaryContainerKey: int,
  lightOnPrimaryContainerKey: int,
  lightPrimaryFixedKey: int,
  lightPrimaryFixedDimKey: int,
  lightOnPrimaryFixedKey: int,
  lightOnPrimaryFixedVariantKey: int,
  lightSecondaryKey: int,
  lightOnSecondaryKey: int,
  lightSecondaryContainerKey: int,
  lightOnSecondaryContainerKey: int,
  lightSecondaryFixedKey: int,
  lightSecondaryFixedDimKey: int,
  lightOnSecondaryFixedKey: int,
  lightOnSecondaryFixedVariantKey: int,
  lightTertiaryKey: int,
  lightOnTertiaryKey: int,
  lightTertiaryContainerKey: int,
  lightOnTertiaryContainerKey: int,
  lightTertiaryFixedKey: int,
  lightTertiaryFixedDimKey: int,
  lightOnTertiaryFixedKey: int,
  lightOnTertiaryFixedVariantKey: int,
  lightErrorKey: int,
  lightOnErrorKey: int,
  lightErrorContainerKey: int,
  lightOnErrorContainerKey: int,
  lightOutlineKey: int,
  lightOutlineVariantKey: int,
  lightSurfaceKey: int,
  lightOnSurfaceKey: int,
  lightSurfaceDimKey: int,
  lightSurfaceBrightKey: int,
  lightSurfaceContainerLowestKey: int,
  lightSurfaceContainerLowKey: int,
  lightSurfaceContainerKey: int,
  lightSurfaceContainerHighKey: int,
  lightSurfaceContainerHighestKey: int,
  lightOnSurfaceVariantKey: int,
  lightInverseSurfaceKey: int,
  lightOnInverseSurfaceKey: int,
  lightInversePrimaryKey: int,
  lightScrimKey: int,
  lightShadowKey: int,
  lightSurfaceTintKey: int,

  // Helpers
  lightColorSchemeImageKey: String,
  userLightColorsKey: List<String>,
};

// Shared //

/// For segmented button; 'advancedColors'
const String advancedColorsKey = 'advancedColors';

/// [advancedColorsKey], [darkColorKeys], && [lightColorKeys]
const Map<String, Type> allColorKeys = <String, Type>{
  advancedColorsKey: bool,
  ...darkColorKeys,
  ...lightColorKeys,
};

//* Color settings' values *//

/// On
const String textColorPrefix = 'On';

const String csPrimary = 'Primary';
const String csOnPrimary = 'On primary';
const String csPrimaryContainer = 'Primary container';
const String csOnPrimaryContainer = 'On primary container';
const String csPrimaryFixed = 'Primary fixed';
const String csPrimaryFixedDim = 'Primary fixed dim';
const String csOnPrimaryFixed = 'On primary fixed';
const String csOnPrimaryFixedVariant = 'On primary fixed variant';
const String csSecondary = 'Secondary';
const String csOnSecondary = 'On secondary';
const String csSecondaryContainer = 'Secondary container';
const String csOnSecondaryContainer = 'On secondary container';
const String csSecondaryFixed = 'Secondary fixed';
const String csSecondaryFixedDim = 'Secondary fixed dim';
const String csOnSecondaryFixed = 'On secondary fixed';
const String csOnSecondaryFixedVariant = 'On secondary fixed variant';
const String csTertiary = 'Tertiary';
const String csOnTertiary = 'On tertiary';
const String csTertiaryContainer = 'Tertiary container';
const String csOnTertiaryContainer = 'On tertiary container';
const String csTertiaryFixed = 'Tertiary fixed';
const String csTertiaryFixedDim = 'Tertiary fixed dim';
const String csOnTertiaryFixed = 'On tertiary fixed';
const String csOnTertiaryFixedVariant = 'On tertiary fixed variant';
const String csError = 'Error';
const String csOnError = 'On error';
const String csErrorContainer = 'Error container';
const String csOnErrorContainer = 'On error container';
const String csOutline = 'Outline';
const String csOutlineVariant = 'Outline variant';
const String csSurface = 'Surface';
const String csOnSurface = 'On surface';
const String csSurfaceDim = 'Surface dim';
const String csSurfaceBright = 'Surface bright';
const String csSurfaceContainerLowest = 'Surface container lowest';
const String csSurfaceContainerLow = 'Surface container low';
const String csSurfaceContainer = 'Surface container';
const String csSurfaceContainerHigh = 'Surface container high';
const String csSurfaceContainerHighest = 'Surface container highest';
const String csOnSurfaceVariant = 'On surface variant';
const String csInverseSurface = 'Inverse surface';
const String csOnInverseSurface = 'On inverse surface';
const String csInversePrimary = 'Inverse primary';
const String csScrim = 'Scrim';
const String csShadow = 'Shadow';
const String csSurfaceTint = 'Surface tint';

//* Design settings' keys *//

// Dark theme //

const String darkAnimationDurationKey = 'darkAnimationDuration';
const String darkBackgroundImageKey = 'darkBackgroundImage';
const String darkButtonOpacityKey = 'darkButtonOpacity';
const String darkButtonOutlineOpacityKey = 'darkButtonOutlineOpacity';

/// Animation, background, && button opacity keys
const Map<String, Type> darkDesignKeys = <String, Type>{
  darkAnimationDurationKey: int,
  darkBackgroundImageKey: String,
  '$darkBackgroundImageKey$boxFitSuffix': String,
  darkButtonOpacityKey: double,
  darkButtonOutlineOpacityKey: double,
};

// Light theme //

const String lightAnimationDurationKey = 'lightAnimationDuration';
const String lightBackgroundImageKey = 'lightBackgroundImage';
const String lightButtonOpacityKey = 'lightButtonOpacity';
const String lightButtonOutlineOpacityKey = 'lightButtonOutlineOpacity';

/// Animation, background, && button opacity keys
const Map<String, Type> lightDesignKeys = <String, Type>{
  lightAnimationDurationKey: int,
  lightBackgroundImageKey: String,
  '$lightBackgroundImageKey$boxFitSuffix': String,
  lightButtonOpacityKey: double,
  lightButtonOutlineOpacityKey: double,
};

// Shared //

/// [darkDesignKeys], && [lightDesignKeys]
const Map<String, Type> allDesignKeys = <String, Type>{
  ...darkDesignKeys,
  ...lightDesignKeys,
};

//* Design settings' values *//

// Image values //

/// Allows for app images whose default is an asset to be "null"
const String noImageValue = 'noImage';

/// Fit
const String boxFitSuffix = 'Fit';

/// contain
const String contain = 'contain';

/// cover
const String cover = 'cover';

/// fill
const String fill = 'fill';

/// fitWidth
const String fitWidth = 'fitWidth';

/// fitHeight
const String fitHeight = 'fitHeight';

/// none
const String none = 'none';

/// scaleDown
const String scaleDown = 'scaleDown';

//* Layout settings' keys *//

// Dark theme //

const String darkMarginKey = 'darkMargin';
const String darkPaddingKey = 'darkPadding';
const String darkSpacingKey = 'darkSpacing';

const String darkHideScrollKey = 'darkHideScroll';

/// [margin, padding, spacing, hideScroll]
const Map<String, Type> darkLayoutKeys = <String, Type>{
  darkMarginKey: double,
  darkPaddingKey: double,
  darkSpacingKey: double,
  darkHideScrollKey: bool,
};

// Light theme //

const String lightMarginKey = 'lightMargin';
const String lightPaddingKey = 'lightPadding';
const String lightSpacingKey = 'lightSpacing';

const String lightHideScrollKey = 'lightHideScroll';

/// [margin, padding, spacing, hideScroll]
const Map<String, Type> lightLayoutKeys = <String, Type>{
  lightMarginKey: double,
  lightPaddingKey: double,
  lightSpacingKey: double,
  lightHideScrollKey: bool,
};

// Shared //

/// [dark, light]
///                X
/// [margin, padding, spacing, hideScroll]
const Map<String, Type> allLayoutKeys = <String, Type>{
  ...darkLayoutKeys,
  ...lightLayoutKeys,
};

//* Text settings' keys *//

// Dark theme //

// Display
const String darkDisplayFontFamilyKey = 'darkDisplayFontFamily';
const String darkDisplayFontSizeKey = 'darkDisplayFontSize';
const String darkDisplayBoldedKey = 'darkDisplayBolded';
const String darkDisplayItalicizedKey = 'darkDisplayItalicized';
const String darkDisplayUnderlinedKey = 'darkDisplayUnderlined';
const String darkDisplayLetterSpacingKey = 'darkDisplayLetterSpacing';
const String darkDisplayWordSpacingKey = 'darkDisplayWordSpacing';
const String darkDisplayFontHeightKey = 'darkDisplayFontHeight';

// Headline
const String darkHeadlineFontFamilyKey = 'darkHeadlineFontFamily';
const String darkHeadlineFontSizeKey = 'darkHeadlineFontSize';
const String darkHeadlineBoldedKey = 'darkHeadlineBolded';
const String darkHeadlineItalicizedKey = 'darkHeadlineItalicized';
const String darkHeadlineUnderlinedKey = 'darkHeadlineUnderlined';
const String darkHeadlineLetterSpacingKey = 'darkHeadlineLetterSpacing';
const String darkHeadlineWordSpacingKey = 'darkHeadlineWordSpacing';
const String darkHeadlineFontHeightKey = 'darkHeadlineFontHeight';

// Title
const String darkTitleFontFamilyKey = 'darkTitleFontFamily';
const String darkTitleFontSizeKey = 'darkTitleFontSize';
const String darkTitleBoldedKey = 'darkTitleBolded';
const String darkTitleItalicizedKey = 'darkTitleItalicized';
const String darkTitleUnderlinedKey = 'darkTitleUnderlined';
const String darkTitleLetterSpacingKey = 'darkTitleLetterSpacing';
const String darkTitleWordSpacingKey = 'darkTitleWordSpacing';
const String darkTitleFontHeightKey = 'darkTitleFontHeight';

// Body
const String darkBodyFontFamilyKey = 'darkBodyFontFamily';
const String darkBodyFontSizeKey = 'darkBodyFontSize';
const String darkBodyBoldedKey = 'darkBodyBolded';
const String darkBodyItalicizedKey = 'darkBodyItalicized';
const String darkBodyUnderlinedKey = 'darkBodyUnderlined';
const String darkBodyLetterSpacingKey = 'darkBodyLetterSpacing';
const String darkBodyWordSpacingKey = 'darkBodyWordSpacing';
const String darkBodyFontHeightKey = 'darkBodyFontHeight';

// Label
const String darkLabelFontFamilyKey = 'darkLabelFontFamily';
const String darkLabelFontSizeKey = 'darkLabelFontSize';
const String darkLabelBoldedKey = 'darkLabelBolded';
const String darkLabelItalicizedKey = 'darkLabelItalicized';
const String darkLabelUnderlinedKey = 'darkLabelUnderlined';
const String darkLabelLetterSpacingKey = 'darkLabelLetterSpacing';
const String darkLabelWordSpacingKey = 'darkLabelWordSpacing';
const String darkLabelFontHeightKey = 'darkLabelFontHeight';

// etc
const String darkTextBackgroundOpacityKey = 'darkTextBackgroundOpacity';
const String darkIconSizeKey = 'darkIconSize';

/// [display, headline, title, body, label]
///                 X
/// [FontFamily, FontSize, FontWeight, FontStyle, LetterSpacing, WordSpacing, FontHeight, FontDecoration]
/// &&
/// [backgroundOpacity, iconSize]
const Map<String, Type> darkTextKeys = <String, Type>{
  // Display
  darkDisplayFontFamilyKey: String,
  darkDisplayFontSizeKey: double,
  darkDisplayBoldedKey: bool,
  darkDisplayItalicizedKey: bool,
  darkDisplayUnderlinedKey: bool,
  darkDisplayLetterSpacingKey: double,
  darkDisplayWordSpacingKey: double,
  darkDisplayFontHeightKey: double,

  // Headline
  darkHeadlineFontFamilyKey: String,
  darkHeadlineFontSizeKey: double,
  darkHeadlineBoldedKey: bool,
  darkHeadlineItalicizedKey: bool,
  darkHeadlineUnderlinedKey: bool,
  darkHeadlineLetterSpacingKey: double,
  darkHeadlineWordSpacingKey: double,
  darkHeadlineFontHeightKey: double,

  // Title
  darkTitleFontFamilyKey: String,
  darkTitleFontSizeKey: double,
  darkTitleBoldedKey: bool,
  darkTitleItalicizedKey: bool,
  darkTitleUnderlinedKey: bool,
  darkTitleLetterSpacingKey: double,
  darkTitleWordSpacingKey: double,
  darkTitleFontHeightKey: double,

  // Body
  darkBodyFontFamilyKey: String,
  darkBodyFontSizeKey: double,
  darkBodyBoldedKey: bool,
  darkBodyItalicizedKey: bool,
  darkBodyUnderlinedKey: bool,
  darkBodyLetterSpacingKey: double,
  darkBodyWordSpacingKey: double,
  darkBodyFontHeightKey: double,

  // Label
  darkLabelFontFamilyKey: String,
  darkLabelFontSizeKey: double,
  darkLabelBoldedKey: bool,
  darkLabelItalicizedKey: bool,
  darkLabelUnderlinedKey: bool,
  darkLabelLetterSpacingKey: double,
  darkLabelWordSpacingKey: double,
  darkLabelFontHeightKey: double,

  // etc
  darkTextBackgroundOpacityKey: double,
  darkIconSizeKey: double,
};

// Light theme //

// Display
const String lightDisplayFontFamilyKey = 'lightDisplayFontFamily';
const String lightDisplayFontSizeKey = 'lightDisplayFontSize';
const String lightDisplayBoldedKey = 'lightDisplayBolded';
const String lightDisplayItalicizedKey = 'lightDisplayItalicized';
const String lightDisplayUnderlinedKey = 'lightDisplayUnderlined';
const String lightDisplayLetterSpacingKey = 'lightDisplayLetterSpacing';
const String lightDisplayWordSpacingKey = 'lightDisplayWordSpacing';
const String lightDisplayFontHeightKey = 'lightDisplayFontHeight';

// Headline
const String lightHeadlineFontFamilyKey = 'lightHeadlineFontFamily';
const String lightHeadlineFontSizeKey = 'lightHeadlineFontSize';
const String lightHeadlineBoldedKey = 'lightHeadlineBolded';
const String lightHeadlineItalicizedKey = 'lightHeadlineItalicized';
const String lightHeadlineUnderlinedKey = 'lightHeadlineUnderlined';
const String lightHeadlineLetterSpacingKey = 'lightHeadlineLetterSpacing';
const String lightHeadlineWordSpacingKey = 'lightHeadlineWordSpacing';
const String lightHeadlineFontHeightKey = 'lightHeadlineFontHeight';

// Title
const String lightTitleFontFamilyKey = 'lightTitleFontFamily';
const String lightTitleFontSizeKey = 'lightTitleFontSize';
const String lightTitleBoldedKey = 'lightTitleBolded';
const String lightTitleItalicizedKey = 'lightTitleItalicized';
const String lightTitleUnderlinedKey = 'lightTitleUnderlined';
const String lightTitleLetterSpacingKey = 'lightTitleLetterSpacing';
const String lightTitleWordSpacingKey = 'lightTitleWordSpacing';
const String lightTitleFontHeightKey = 'lightTitleFontHeight';

// Body
const String lightBodyFontFamilyKey = 'lightBodyFontFamily';
const String lightBodyFontSizeKey = 'lightBodyFontSize';
const String lightBodyBoldedKey = 'lightBodyBolded';
const String lightBodyItalicizedKey = 'lightBodyItalicized';
const String lightBodyUnderlinedKey = 'lightBodyUnderlined';
const String lightBodyLetterSpacingKey = 'lightBodyLetterSpacing';
const String lightBodyWordSpacingKey = 'lightBodyWordSpacing';
const String lightBodyFontHeightKey = 'lightBodyFontHeight';

// Label
const String lightLabelFontFamilyKey = 'lightLabelFontFamily';
const String lightLabelFontSizeKey = 'lightLabelFontSize';
const String lightLabelBoldedKey = 'lightLabelBolded';
const String lightLabelItalicizedKey = 'lightLabelItalicized';
const String lightLabelUnderlinedKey = 'lightLabelUnderlined';
const String lightLabelLetterSpacingKey = 'lightLabelLetterSpacing';
const String lightLabelWordSpacingKey = 'lightLabelWordSpacing';
const String lightLabelFontHeightKey = 'lightLabelFontHeight';

// etc
const String lightTextBackgroundOpacityKey = 'lightTextBackgroundOpacity';
const String lightIconSizeKey = 'lightIconSize';

/// [display, headline, title, body, label]
///                 X
/// [FontFamily, FontSize, FontWeight, FontStyle, LetterSpacing, WordSpacing, FontHeight, FontDecoration]
/// &&
/// [backgroundOpacity, iconSize]
const Map<String, Type> lightTextKeys = <String, Type>{
  // Display
  lightDisplayFontFamilyKey: String,
  lightDisplayFontSizeKey: double,
  lightDisplayBoldedKey: bool,
  lightDisplayItalicizedKey: bool,
  lightDisplayUnderlinedKey: bool,
  lightDisplayLetterSpacingKey: double,
  lightDisplayWordSpacingKey: double,
  lightDisplayFontHeightKey: double,

  // Headline
  lightHeadlineFontFamilyKey: String,
  lightHeadlineFontSizeKey: double,
  lightHeadlineBoldedKey: bool,
  lightHeadlineItalicizedKey: bool,
  lightHeadlineUnderlinedKey: bool,
  lightHeadlineLetterSpacingKey: double,
  lightHeadlineWordSpacingKey: double,
  lightHeadlineFontHeightKey: double,

  // Title
  lightTitleFontFamilyKey: String,
  lightTitleFontSizeKey: double,
  lightTitleBoldedKey: bool,
  lightTitleItalicizedKey: bool,
  lightTitleUnderlinedKey: bool,
  lightTitleLetterSpacingKey: double,
  lightTitleWordSpacingKey: double,
  lightTitleFontHeightKey: double,

  // Body
  lightBodyFontFamilyKey: String,
  lightBodyFontSizeKey: double,
  lightBodyBoldedKey: bool,
  lightBodyItalicizedKey: bool,
  lightBodyUnderlinedKey: bool,
  lightBodyLetterSpacingKey: double,
  lightBodyWordSpacingKey: double,
  lightBodyFontHeightKey: double,

  // Label
  lightLabelFontFamilyKey: String,
  lightLabelFontSizeKey: double,
  lightLabelBoldedKey: bool,
  lightLabelItalicizedKey: bool,
  lightLabelUnderlinedKey: bool,
  lightLabelLetterSpacingKey: double,
  lightLabelWordSpacingKey: double,
  lightLabelFontHeightKey: double,

  // etc
  lightTextBackgroundOpacityKey: double,
  lightIconSizeKey: double,
};

// Shared //

const String advancedTextKey = 'advancedText';

/// [light, dark]
///                 X
/// [[display, headline, title, body, label]
///                 X
/// [FontFamily, FontSize, FontWeight, FontStyle, LetterSpacing, WordSpacing, FontHeight, FontDecoration]
/// &&
/// [backgroundOpacity, iconSize]]
/// ...&& the selector
const Map<String, Type> allTextKeys = <String, Type>{
  advancedTextKey: bool,
  ...darkTextKeys,
  ...lightTextKeys,
};

//* Text settings' values *//

/// bold
const String bold = 'bold';

/// italic
const String italic = 'italic';

/// underlined
const String underlined = 'underlined';

/// -55.55
const String sampleString = '55.55';

//* Global trackers *//

/// [allGlobalKeys], [allTextKeys], [allLayoutKeys], [allColorKeys], [allImageKeys]
const Map<String, Type> allEZConfigKeys = <String, Type>{
  ...allGlobalKeys,
  ...allColorKeys,
  ...allDesignKeys,
  ...allLayoutKeys,
  ...allTextKeys,
};
