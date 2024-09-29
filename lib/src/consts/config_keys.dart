/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// Global settings' keys //

const String isLeftyKey = 'isLefty';

const String isDarkThemeKey = 'isDarkTheme';

const String localeKey = 'appLocale';

///  [isLeftyKey], [isDarkThemeKey], [localeKey]
const Map<String, Type> globalKeys = <String, Type>{
  isLeftyKey: bool,
  isDarkThemeKey: bool,
  localeKey: List<String>,
};

// Text settings' keys //

// Display
const String displayFontFamilyKey = 'displayFontFamily';
const String displayFontSizeKey = 'displayFontSize';
const String displayBoldKey = 'displayBolded';
const String displayItalicsKey = 'displayItalicized';
const String displayUnderlinedKey = 'displayUnderlined';
const String displayFontHeightKey = 'displayFontHeight';
const String displayLetterSpacingKey = 'displayLetterSpacing';
const String displayWordSpacingKey = 'displayWordSpacing';

// Headline
const String headlineFontFamilyKey = 'headlineFontFamily';
const String headlineFontSizeKey = 'headlineFontSize';
const String headlineBoldKey = 'headlineBolded';
const String headlineItalicsKey = 'headlineItalicized';
const String headlineUnderlinedKey = 'headlineUnderlined';
const String headlineFontHeightKey = 'headlineFontHeight';
const String headlineLetterSpacingKey = 'headlineLetterSpacing';
const String headlineWordSpacingKey = 'headlineWordSpacing';

// Title
const String titleFontFamilyKey = 'titleFontFamily';
const String titleFontSizeKey = 'titleFontSize';
const String titleBoldKey = 'titleBolded';
const String titleItalicsKey = 'titleItalicized';
const String titleUnderlinedKey = 'titleUnderlined';
const String titleFontHeightKey = 'titleFontHeight';
const String titleLetterSpacingKey = 'titleLetterSpacing';
const String titleWordSpacingKey = 'titleWordSpacing';

// Body
const String bodyFontFamilyKey = 'bodyFontFamily';
const String bodyFontSizeKey = 'bodyFontSize';
const String bodyBoldKey = 'bodyBolded';
const String bodyItalicsKey = 'bodyItalicized';
const String bodyUnderlinedKey = 'bodyUnderlined';
const String bodyFontHeightKey = 'bodyFontHeight';
const String bodyLetterSpacingKey = 'bodyLetterSpacing';
const String bodyWordSpacingKey = 'bodyWordSpacing';

// Label
const String labelFontFamilyKey = 'labelFontFamily';
const String labelFontSizeKey = 'labelFontSize';
const String labelBoldKey = 'labelBolded';
const String labelItalicsKey = 'labelItalicized';
const String labelUnderlinedKey = 'labelUnderlined';
const String labelFontHeightKey = 'labelFontHeight';
const String labelLetterSpacingKey = 'labelLetterSpacing';
const String labelWordSpacingKey = 'labelWordSpacing';

// Background opacity
const String darkTextBackgroundOKey = 'darkTextBackgroundOpacity';
const String lightTextBackgroundOKey = 'lightTextBackgroundOpacity';

/// [display, headline, title, body, label]
///                 X
/// [FontFamily, FontSize, FontWeight, FontStyle, LetterSpacing, WordSpacing, FontHeight, FontDecoration]
const Map<String, Type> textStyleKeys = <String, Type>{
  // Display
  displayFontFamilyKey: String,
  displayFontSizeKey: double,
  displayBoldKey: String,
  displayItalicsKey: String,
  displayLetterSpacingKey: double,
  displayWordSpacingKey: double,
  displayFontHeightKey: double,
  displayUnderlinedKey: String,

  // Headline
  headlineFontFamilyKey: String,
  headlineFontSizeKey: double,
  headlineBoldKey: String,
  headlineItalicsKey: String,
  headlineLetterSpacingKey: double,
  headlineWordSpacingKey: double,
  headlineFontHeightKey: double,
  headlineUnderlinedKey: String,

  // Title
  titleFontFamilyKey: String,
  titleFontSizeKey: double,
  titleBoldKey: String,
  titleItalicsKey: String,
  titleLetterSpacingKey: double,
  titleWordSpacingKey: double,
  titleFontHeightKey: double,
  titleUnderlinedKey: String,

  // Body
  bodyFontFamilyKey: String,
  bodyFontSizeKey: double,
  bodyBoldKey: String,
  bodyItalicsKey: String,
  bodyLetterSpacingKey: double,
  bodyWordSpacingKey: double,
  bodyFontHeightKey: double,
  bodyUnderlinedKey: String,

  // Label
  labelFontFamilyKey: String,
  labelFontSizeKey: double,
  labelBoldKey: String,
  labelItalicsKey: String,
  labelLetterSpacingKey: double,
  labelWordSpacingKey: double,
  labelFontHeightKey: double,
  labelUnderlinedKey: String,

  // Background opacity
  darkTextBackgroundOKey: double,
  lightTextBackgroundOKey: double,
};

// Text settings' values //

const String bold = 'bold';
const String italic = 'italic';
const String underlined = 'underlined';

/// '-5.5'
const String sampleString = '55.55';

// Text settings' recommended parameters //

/// 84.0
const double maxDisplay = 84.0;

/// 21.0
const double minDisplay = 21.0;

/// 64.0
const double maxHeadline = 64.0;

/// 16.0
const double minHeadline = 16.0;

/// 42.0
const double maxTitle = 42.0;

/// 11.0
const double minTitle = 11.0;

/// 32.0
const double maxBody = 32.0;

/// 8.0
const double minBody = 8.0;

/// 28.0
const double maxLabel = 28.0;

/// 7.0
const double minLabel = 7.0;

const Map<String, double> fontSizeMaxes = <String, double>{
  displayFontSizeKey: maxDisplay,
  headlineFontSizeKey: maxHeadline,
  titleFontSizeKey: maxTitle,
  bodyFontSizeKey: maxBody,
  labelFontSizeKey: maxLabel,
};

const Map<String, double> fontSizeMins = <String, double>{
  displayFontSizeKey: minDisplay,
  headlineFontSizeKey: minHeadline,
  titleFontSizeKey: minTitle,
  bodyFontSizeKey: minBody,
  labelFontSizeKey: minLabel,
};

/// 0.0
const double minOpacity = 0.0;

/// 1.0
const double maxOpacity = 1.0;

/// -1.0
const double minFontLetterSpacing = -1.0;

/// 1.0
const double maxFontLetterSpacing = 1.0;

/// -3.0
const double minFontWordSpacing = -3.0;

/// 3.0
const double maxFontWordSpacing = 3.0;

/// 1.0
const double minFontHeight = 1.0;

/// 2.0
const double maxFontHeight = 2.0;

// Layout keys //

const String marginKey = 'margin'; // Required key
const String paddingKey = 'padding'; // Required key
const String spacingKey = 'spacing'; // Required key

const String hideScrollKey = 'hideScroll';

/// [marginKey], [paddingKey], [spacingKey], [hideScrollKey]
const Map<String, Type> layoutKeys = <String, Type>{
  marginKey: double,
  paddingKey: double,
  spacingKey: double,
  hideScrollKey: bool,
};

// Layout settings recommended parameters //

/// 5.0
const double minMargin = 5.0;

/// 20.0
const double maxMargin = 20.0;

/// 10.0
const double minPadding = 10.0;

/// 40.0
const double maxPadding = 40.0;

/// 10.0
const double minSpacing = 10.0;

/// 50.0
const double maxSpacing = 75.0;

// Color settings' keys //

const String textColorPrefix = 'On';

// Light theme
const String lightPrimaryKey = 'lightPrimary'; // Required key
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

// Dark theme
const String darkPrimaryKey = 'darkPrimary'; // Required key
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
const List<String> lightColors = <String>[
  lightPrimaryKey, // Required key
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
  lightOutlineKey,
  lightOutlineVariantKey,
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
  lightInverseSurfaceKey,
  lightOnInverseSurfaceKey,
  lightInversePrimaryKey,
  lightScrimKey,
  lightShadowKey,
  lightSurfaceTintKey,
];

/// Ordered [List] for populating color setting screen(s)
const List<String> darkColors = <String>[
  darkPrimaryKey, // Required key
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
  darkOutlineKey,
  darkOutlineVariantKey,
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
  darkInverseSurfaceKey,
  darkOnInverseSurfaceKey,
  darkInversePrimaryKey,
  darkScrimKey,
  darkShadowKey,
  darkSurfaceTintKey,
];

const String userColorsKey = 'userColors';

/// [light, dark] X all 26 material color scheme keys
const Map<String, Type> colorKeys = <String, Type>{
  userColorsKey: List<String>,

  // Light theme
  lightPrimaryKey: int, // Required key
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

  // Dark theme
  darkPrimaryKey: int, // Required key
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
};

// Image settings' keys //

const String lightColorSchemeImageKey = 'lightColorSchemeImage';
const String lightBackgroundImageKey = 'lightBackgroundImage';

const String darkColorSchemeImageKey = 'darkColorSchemeImage';
const String darkBackgroundImageKey = 'darkBackgroundImage';

/// [light, dark]
///      X
/// [colorSchemeImageKey, pageImageKey]
const Map<String, Type> imageKeys = <String, Type>{
  // Light theme
  lightColorSchemeImageKey: String,
  lightBackgroundImageKey: String,

  // Dark theme
  darkColorSchemeImageKey: String,
  darkBackgroundImageKey: String,
};

/// Allows for app images whose default is an asset to be "null"
const String noImageValue = 'noImage';

// Global trackers //

const Map<String, Type> allKeys = <String, Type>{
  ...globalKeys,
  ...textStyleKeys,
  ...layoutKeys,
  ...colorKeys,
  ...imageKeys,
};
