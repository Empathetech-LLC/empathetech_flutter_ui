/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

//* Global settings' keys *//

const String isLeftyKey = 'isLefty';

const String isDarkThemeKey = 'isDarkTheme';

const String appLocaleKey = 'appLocale';

///  [isLeftyKey], [isDarkThemeKey], [appLocaleKey]
const Map<String, Type> globalKeys = <String, Type>{
  isLeftyKey: bool,
  isDarkThemeKey: bool,
  appLocaleKey: List<String>,
};

//* Text settings' keys *//

// Display
const String displayFontFamilyKey = 'displayFontFamily';
const String displayFontSizeKey = 'displayFontSize';
const String displayBoldedKey = 'displayBolded';
const String displayItalicizedKey = 'displayItalicized';
const String displayUnderlinedKey = 'displayUnderlined';
const String displayLetterSpacingKey = 'displayLetterSpacing';
const String displayWordSpacingKey = 'displayWordSpacing';
const String displayFontHeightKey = 'displayFontHeight';

// Headline
const String headlineFontFamilyKey = 'headlineFontFamily';
const String headlineFontSizeKey = 'headlineFontSize';
const String headlineBoldedKey = 'headlineBolded';
const String headlineItalicizedKey = 'headlineItalicized';
const String headlineUnderlinedKey = 'headlineUnderlined';
const String headlineLetterSpacingKey = 'headlineLetterSpacing';
const String headlineWordSpacingKey = 'headlineWordSpacing';
const String headlineFontHeightKey = 'headlineFontHeight';

// Title
const String titleFontFamilyKey = 'titleFontFamily';
const String titleFontSizeKey = 'titleFontSize';
const String titleBoldedKey = 'titleBolded';
const String titleItalicizedKey = 'titleItalicized';
const String titleUnderlinedKey = 'titleUnderlined';
const String titleLetterSpacingKey = 'titleLetterSpacing';
const String titleWordSpacingKey = 'titleWordSpacing';
const String titleFontHeightKey = 'titleFontHeight';

// Body
const String bodyFontFamilyKey = 'bodyFontFamily';
const String bodyFontSizeKey = 'bodyFontSize';
const String bodyBoldedKey = 'bodyBolded';
const String bodyItalicizedKey = 'bodyItalicized';
const String bodyUnderlinedKey = 'bodyUnderlined';
const String bodyLetterSpacingKey = 'bodyLetterSpacing';
const String bodyWordSpacingKey = 'bodyWordSpacing';
const String bodyFontHeightKey = 'bodyFontHeight';

// Label
const String labelFontFamilyKey = 'labelFontFamily';
const String labelFontSizeKey = 'labelFontSize';
const String labelBoldedKey = 'labelBolded';
const String labelItalicizedKey = 'labelItalicized';
const String labelUnderlinedKey = 'labelUnderlined';
const String labelLetterSpacingKey = 'labelLetterSpacing';
const String labelWordSpacingKey = 'labelWordSpacing';
const String labelFontHeightKey = 'labelFontHeight';

// Background opacity
const String darkTextBackgroundOpacityKey = 'darkTextBackgroundOpacity';
const String lightTextBackgroundOpacityKey = 'lightTextBackgroundOpacity';

// Icons
const String iconSizeKey = 'iconSize'; // Required

// Selector
const String advancedTextKey = 'advancedText';

/// [display, headline, title, body, label]
///                 X
/// [FontFamily, FontSize, FontWeight, FontStyle, LetterSpacing, WordSpacing, FontHeight, FontDecoration]
/// y
/// [darkTextBackgroundOpacity, lightTextBackgroundOpacity, iconSize]
const Map<String, Type> textStyleKeys = <String, Type>{
  // Display
  displayFontFamilyKey: String,
  displayFontSizeKey: double,
  displayBoldedKey: bool,
  displayItalicizedKey: bool,
  displayUnderlinedKey: bool,
  displayLetterSpacingKey: double,
  displayWordSpacingKey: double,
  displayFontHeightKey: double,

  // Headline
  headlineFontFamilyKey: String,
  headlineFontSizeKey: double,
  headlineBoldedKey: bool,
  headlineItalicizedKey: bool,
  headlineUnderlinedKey: bool,
  headlineLetterSpacingKey: double,
  headlineWordSpacingKey: double,
  headlineFontHeightKey: double,

  // Title
  titleFontFamilyKey: String,
  titleFontSizeKey: double,
  titleBoldedKey: bool,
  titleItalicizedKey: bool,
  titleUnderlinedKey: bool,
  titleLetterSpacingKey: double,
  titleWordSpacingKey: double,
  titleFontHeightKey: double,

  // Body
  bodyFontFamilyKey: String,
  bodyFontSizeKey: double,
  bodyBoldedKey: bool,
  bodyItalicizedKey: bool,
  bodyUnderlinedKey: bool,
  bodyLetterSpacingKey: double,
  bodyWordSpacingKey: double,
  bodyFontHeightKey: double,

  // Label
  labelFontFamilyKey: String,
  labelFontSizeKey: double,
  labelBoldedKey: bool,
  labelItalicizedKey: bool,
  labelUnderlinedKey: bool,
  labelLetterSpacingKey: double,
  labelWordSpacingKey: double,
  labelFontHeightKey: double,

  // Background opacity
  darkTextBackgroundOpacityKey: double,
  lightTextBackgroundOpacityKey: double,

  // Icons
  iconSizeKey: double, // Required

  // Selector
  advancedTextKey: bool,
};

//* Text settings' values *//

/// bold
const String bold = 'bold';

/// italic
const String italic = 'italic';

/// underlined
const String underlined = 'underlined';

/// '-55.55'
const String sampleString = '55.55';

//* Layout settings' keys *//

const String marginKey = 'margin'; // Required
const String paddingKey = 'padding'; // Required
const String spacingKey = 'spacing'; // Required

const String hideScrollKey = 'hideScroll';

/// [marginKey], [paddingKey], [spacingKey], [hideScrollKey]
const Map<String, Type> layoutKeys = <String, Type>{
  marginKey: double, // Required
  paddingKey: double, // Required
  spacingKey: double, // Required
  hideScrollKey: bool,
};

//* Color settings' keys *//

// Dark theme //

const String darkPrimaryKey = 'darkPrimary'; // Required
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
const List<String> darkColorKeys = <String>[
  darkPrimaryKey, // Required
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
const String userDarkColorsKey = 'userDarkColors';

// Light theme //

const String lightPrimaryKey = 'lightPrimary'; // Required
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
const List<String> lightColorKeys = <String>[
  lightPrimaryKey, // Required
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
const String userLightColorsKey = 'userLightColors';

// Shared //

/// 'On'
const String textColorPrefix = 'On';

/// For segmented button; 'advancedColors'
const String advancedColorsKey = 'advancedColors';

/// [light, dark] X all 26 material color scheme keys
/// the user color keys
/// && the settings selector key
const Map<String, Type> allColorKeys = <String, Type>{
  // Dark theme
  darkPrimaryKey: int, // Required
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
  userDarkColorsKey: List<String>,

  // Light theme
  lightPrimaryKey: int, // Required
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
  userLightColorsKey: List<String>,

  // Selector
  advancedColorsKey: bool,
};

//* Color settings' values *//

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

//* Image settings' keys *//

// Dark theme //

const String darkColorSchemeImageKey = 'darkColorSchemeImage';
const String darkBackgroundImageKey = 'darkBackgroundImage';

const Set<String> darkImageKeys = <String>{
  darkColorSchemeImageKey,
  darkBackgroundImageKey,
  '$darkBackgroundImageKey$boxFitSuffix',
};

// Light theme //

const String lightColorSchemeImageKey = 'lightColorSchemeImage';
const String lightBackgroundImageKey = 'lightBackgroundImage';

const Set<String> lightImageKeys = <String>{
  lightColorSchemeImageKey,
  lightBackgroundImageKey,
  '$lightBackgroundImageKey$boxFitSuffix',
};

// Shared //

/// [light, dark]
///      X
/// [ColorSchemeImageKey, BackgroundImageKey, BackgroundImageKeyFit]
const Map<String, Type> allImageKeys = <String, Type>{
  // Light theme
  lightColorSchemeImageKey: String,
  lightBackgroundImageKey: String,
  '$lightBackgroundImageKey$boxFitSuffix': String,

  // Dark theme
  darkColorSchemeImageKey: String,
  darkBackgroundImageKey: String,
  '$darkBackgroundImageKey$boxFitSuffix': String,
};

//* Image settings' values *//

/// Allows for app images whose default is an asset to be "null"
const String noImageValue = 'noImage';

/// 'Fit'
const String boxFitSuffix = 'Fit';

/// 'contain'
const String contain = 'contain';

/// 'cover'
const String cover = 'cover';

/// 'fill'
const String fill = 'fill';

/// 'fitWidth'
const String fitWidth = 'fitWidth';

/// 'fitHeight'
const String fitHeight = 'fitHeight';

/// 'none'
const String none = 'none';

/// 'scaleDown'
const String scaleDown = 'scaleDown';

//* Global trackers *//

/// [globalKeys], [textStyleKeys], [layoutKeys], [allColorKeys], [allImageKeys]
const Map<String, Type> allKeys = <String, Type>{
  ...globalKeys,
  ...textStyleKeys,
  ...layoutKeys,
  ...allColorKeys,
  ...allImageKeys,
};
