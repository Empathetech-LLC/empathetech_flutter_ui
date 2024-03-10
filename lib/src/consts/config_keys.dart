/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// Global values //

/// '/'
const String homePath = '/';

/// '/'
const String homeRoute = '/';

/// Allows for app images whose default is an asset to be "null"
const String noImageValue = 'noImage';

// Global settings' keys //

const String isLeftyKey = 'isLefty';

const String isDarkThemeKey = 'isDarkTheme';

const String localeKey = 'appLocale';

const String userColorsKey = 'userColors';

///  [isLeftyKey], [isDarkThemeKey], [localeKey],  [userColorsKey],
const Map<String, Type> globalKeys = <String, Type>{
  isLeftyKey: bool,
  isDarkThemeKey: bool,
  localeKey: List<String>,
  userColorsKey: List<String>,
};

// Text settings' keys //

// Display
const String displayFontFamilyKey = 'displayFontFamily';
const String displayFontSizeKey = 'displayFontSize';
const String displayFontWeightKey = 'displayFontWeight';
const String displayFontStyleKey = 'displayFontStyle';
const String displayLetterSpacingKey = 'displayLetterSpacing';
const String displayWordSpacingKey = 'displayWordSpacing';
const String displayFontHeightKey = 'displayFontHeight';
const String displayFontDecorationKey = 'displayFontDecoration';

// Headline
const String headlineFontFamilyKey = 'headlineFontFamily';
const String headlineFontSizeKey = 'headlineFontSize';
const String headlineFontWeightKey = 'headlineFontWeight';
const String headlineFontStyleKey = 'headlineFontStyle';
const String headlineLetterSpacingKey = 'headlineLetterSpacing';
const String headlineWordSpacingKey = 'headlineWordSpacing';
const String headlineFontHeightKey = 'headlineFontHeight';
const String headlineFontDecorationKey = 'headlineFontDecoration';

// Title
const String titleFontFamilyKey = 'titleFontFamily';
const String titleFontSizeKey = 'titleFontSize';
const String titleFontWeightKey = 'titleFontWeight';
const String titleFontStyleKey = 'titleFontStyle';
const String titleLetterSpacingKey = 'titleLetterSpacing';
const String titleWordSpacingKey = 'titleWordSpacing';
const String titleFontHeightKey = 'titleFontHeight';
const String titleFontDecorationKey = 'titleFontDecoration';

// Body
const String bodyFontFamilyKey = 'bodyFontFamily';
const String bodyFontSizeKey = 'bodyFontSize';
const String bodyFontWeightKey = 'bodyFontWeight';
const String bodyFontStyleKey = 'bodyFontStyle';
const String bodyLetterSpacingKey = 'bodyLetterSpacing';
const String bodyWordSpacingKey = 'bodyWordSpacing';
const String bodyFontHeightKey = 'bodyFontHeight';
const String bodyFontDecorationKey = 'bodyFontDecoration';

// Label
const String labelFontFamilyKey = 'labelFontFamily';
const String labelFontSizeKey = 'labelFontSize';
const String labelFontWeightKey = 'labelFontWeight';
const String labelFontStyleKey = 'labelFontStyle';
const String labelLetterSpacingKey = 'labelLetterSpacing';
const String labelWordSpacingKey = 'labelWordSpacing';
const String labelFontHeightKey = 'labelFontHeight';
const String labelFontDecorationKey = 'labelFontDecoration';

/// [display, headline, title, body, label]
///                 X
/// [FontFamily, FontSize, FontWeight, FontStyle, LetterSpacing, WordSpacing, FontHeight, FontDecoration]
const Map<String, Type> textStyleKeys = <String, Type>{
  // Display
  displayFontFamilyKey: String,
  displayFontSizeKey: double,
  displayFontWeightKey: String,
  displayFontStyleKey: String,
  displayLetterSpacingKey: double,
  displayWordSpacingKey: double,
  displayFontHeightKey: double,
  displayFontDecorationKey: String,

  // Headline
  headlineFontFamilyKey: String,
  headlineFontSizeKey: double,
  headlineFontWeightKey: String,
  headlineFontStyleKey: String,
  headlineLetterSpacingKey: double,
  headlineWordSpacingKey: double,
  headlineFontHeightKey: double,
  headlineFontDecorationKey: String,

  // Title
  titleFontFamilyKey: String,
  titleFontSizeKey: double,
  titleFontWeightKey: String,
  titleFontStyleKey: String,
  titleLetterSpacingKey: double,
  titleWordSpacingKey: double,
  titleFontHeightKey: double,
  titleFontDecorationKey: String,

  // Body
  bodyFontFamilyKey: String,
  bodyFontSizeKey: double,
  bodyFontWeightKey: String,
  bodyFontStyleKey: String,
  bodyLetterSpacingKey: double,
  bodyWordSpacingKey: double,
  bodyFontHeightKey: double,
  bodyFontDecorationKey: String,

  // Label
  labelFontFamilyKey: String,
  labelFontSizeKey: double,
  labelFontWeightKey: String,
  labelFontStyleKey: String,
  labelLetterSpacingKey: double,
  labelWordSpacingKey: double,
  labelFontHeightKey: double,
  labelFontDecorationKey: String,
};

// Text settings' values //

const String normal = 'normal';
const String bold = 'bold';
const String italic = 'italic';
const String underlined = 'underlined';

// Image settings' keys //

const String lightColorSchemeImageKey = 'lightColorSchemeImage';
const String lightPageImageKey = 'lightPageImage';

const String darkColorSchemeImageKey = 'darkColorSchemeImage';
const String darkPageImageKey = 'darkPageImage';

/// [light, dark]
///      X
/// [colorSchemeImageKey, pageImageKey]
const Map<String, Type> imageKeys = <String, Type>{
  // Light theme
  lightColorSchemeImageKey: String,
  lightPageImageKey: String,

  // Dark theme
  darkColorSchemeImageKey: String,
  darkPageImageKey: String,
};

// Color settings' keys //

const String textColorPrefix = 'On';

// Light theme
const String lightPrimaryKey = 'lightPrimary';
const String lightOnPrimaryKey = 'lightOnPrimary';
const String lightPrimaryContainerKey = 'lightPrimaryContainer';
const String lightOnPrimaryContainerKey = 'lightOnPrimaryContainer';

const String lightSecondaryKey = 'lightSecondary';
const String lightOnSecondaryKey = 'lightOnSecondary';
const String lightSecondaryContainerKey = 'lightSecondaryContainer';
const String lightOnSecondaryContainerKey = 'lightOnSecondaryContainer';

const String lightTertiaryKey = 'lightTertiary';
const String lightOnTertiaryKey = 'lightOnTertiary';
const String lightTertiaryContainerKey = 'lightTertiaryContainer';
const String lightOnTertiaryContainerKey = 'lightOnTertiaryContainer';

const String lightErrorKey = 'lightError';
const String lightOnErrorKey = 'lightOnError';
const String lightErrorContainerKey = 'lightErrorContainer';
const String lightOnErrorContainerKey = 'lightOnErrorContainer';

const String lightOutlineKey = 'lightOutline';
const String lightOutlineVariantKey = 'lightOutlineVariant';

const String lightBackgroundKey = 'lightBackground';
const String lightOnBackgroundKey = 'lightOnBackground';

const String lightSurfaceKey = 'lightSurface';
const String lightOnSurfaceKey = 'lightOnSurface';
const String lightSurfaceVariantKey = 'lightSurfaceVariant';
const String lightOnSurfaceVariantKey = 'lightOnSurfaceVariant';
const String lightInverseSurfaceKey = 'lightInverseSurface';
const String lightOnInverseSurfaceKey = 'lightOnInverseSurface';

const String lightInversePrimaryKey = 'lightInversePrimary';

const String lightShadowKey = 'lightShadow';
const String lightScrimKey = 'lightScrim';

const String lightSurfaceTintKey = 'lightSurfaceTint';

// Dark theme
const String darkPrimaryKey = 'darkPrimary';
const String darkOnPrimaryKey = 'darkOnPrimary';
const String darkPrimaryContainerKey = 'darkPrimaryContainer';
const String darkOnPrimaryContainerKey = 'darkOnPrimaryContainer';

const String darkSecondaryKey = 'darkSecondary';
const String darkOnSecondaryKey = 'darkOnSecondary';
const String darkSecondaryContainerKey = 'darkSecondaryContainer';
const String darkOnSecondaryContainerKey = 'darkOnSecondaryContainer';

const String darkTertiaryKey = 'darkTertiary';
const String darkOnTertiaryKey = 'darkOnTertiary';
const String darkTertiaryContainerKey = 'darkTertiaryContainer';
const String darkOnTertiaryContainerKey = 'darkOnTertiaryContainer';

const String darkErrorKey = 'darkError';
const String darkOnErrorKey = 'darkOnError';
const String darkErrorContainerKey = 'darkErrorContainer';
const String darkOnErrorContainerKey = 'darkOnErrorContainer';

const String darkOutlineKey = 'darkOutline';
const String darkOutlineVariantKey = 'darkOutlineVariant';

const String darkBackgroundKey = 'darkBackground';
const String darkOnBackgroundKey = 'darkOnBackground';

const String darkSurfaceKey = 'darkSurface';
const String darkOnSurfaceKey = 'darkOnSurface';
const String darkSurfaceVariantKey = 'darkSurfaceVariant';
const String darkOnSurfaceVariantKey = 'darkOnSurfaceVariant';
const String darkInverseSurfaceKey = 'darkInverseSurface';
const String darkOnInverseSurfaceKey = 'darkOnInverseSurface';

const String darkInversePrimaryKey = 'darkInversePrimary';

const String darkShadowKey = 'darkShadow';
const String darkScrimKey = 'darkScrim';

const String darkSurfaceTintKey = 'darkSurfaceTint';

/// [light, dark] X all 26 material color scheme keys
const Map<String, Type> colorKeys = <String, Type>{
  // Light theme
  lightPrimaryKey: int,
  lightOnPrimaryKey: int,
  lightPrimaryContainerKey: int,
  lightOnPrimaryContainerKey: int,
  lightSecondaryKey: int,
  lightOnSecondaryKey: int,
  lightSecondaryContainerKey: int,
  lightOnSecondaryContainerKey: int,
  lightTertiaryKey: int,
  lightOnTertiaryKey: int,
  lightTertiaryContainerKey: int,
  lightOnTertiaryContainerKey: int,
  lightErrorKey: int,
  lightOnErrorKey: int,
  lightErrorContainerKey: int,
  lightOnErrorContainerKey: int,
  lightOutlineKey: int,
  lightOutlineVariantKey: int,
  lightBackgroundKey: int,
  lightOnBackgroundKey: int,
  lightSurfaceKey: int,
  lightOnSurfaceKey: int,
  lightSurfaceVariantKey: int,
  lightOnSurfaceVariantKey: int,
  lightInverseSurfaceKey: int,
  lightOnInverseSurfaceKey: int,
  lightInversePrimaryKey: int,
  lightScrimKey: int,
  lightShadowKey: int,
  lightSurfaceTintKey: int,

  // Dark theme
  darkPrimaryKey: int,
  darkOnPrimaryKey: int,
  darkPrimaryContainerKey: int,
  darkOnPrimaryContainerKey: int,
  darkSecondaryKey: int,
  darkOnSecondaryKey: int,
  darkSecondaryContainerKey: int,
  darkOnSecondaryContainerKey: int,
  darkTertiaryKey: int,
  darkOnTertiaryKey: int,
  darkTertiaryContainerKey: int,
  darkOnTertiaryContainerKey: int,
  darkErrorKey: int,
  darkOnErrorKey: int,
  darkErrorContainerKey: int,
  darkOnErrorContainerKey: int,
  darkOutlineKey: int,
  darkOutlineVariantKey: int,
  darkBackgroundKey: int,
  darkOnBackgroundKey: int,
  darkSurfaceKey: int,
  darkOnSurfaceKey: int,
  darkSurfaceVariantKey: int,
  darkOnSurfaceVariantKey: int,
  darkInverseSurfaceKey: int,
  darkOnInverseSurfaceKey: int,
  darkInversePrimaryKey: int,
  darkScrimKey: int,
  darkShadowKey: int,
  darkSurfaceTintKey: int,
};

// Layout keys //

const String marginKey = 'margin';
const String paddingKey = 'padding';
const String spacingKey = 'spacing';

const Map<String, Type> layoutKeys = <String, Type>{
  marginKey: double,
  paddingKey: double,
  spacingKey: double,
};

// Global trackers //

const Map<String, Type> allKeys = <String, Type>{
  ...globalKeys,
  ...textStyleKeys,
  ...imageKeys,
  ...colorKeys,
  ...layoutKeys,
};

/// Ordered [List] for populating color setting screen(s)
const List<String> lightColors = <String>[
  lightPrimaryKey,
  lightOnPrimaryKey,
  lightPrimaryContainerKey,
  lightOnPrimaryContainerKey,
  lightSecondaryKey,
  lightOnSecondaryKey,
  lightSecondaryContainerKey,
  lightOnSecondaryContainerKey,
  lightTertiaryKey,
  lightOnTertiaryKey,
  lightTertiaryContainerKey,
  lightOnTertiaryContainerKey,
  lightErrorKey,
  lightOnErrorKey,
  lightErrorContainerKey,
  lightOnErrorContainerKey,
  lightOutlineKey,
  lightOutlineVariantKey,
  lightBackgroundKey,
  lightOnBackgroundKey,
  lightSurfaceKey,
  lightOnSurfaceKey,
  lightSurfaceVariantKey,
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
  darkPrimaryKey,
  darkOnPrimaryKey,
  darkPrimaryContainerKey,
  darkOnPrimaryContainerKey,
  darkSecondaryKey,
  darkOnSecondaryKey,
  darkSecondaryContainerKey,
  darkOnSecondaryContainerKey,
  darkTertiaryKey,
  darkOnTertiaryKey,
  darkTertiaryContainerKey,
  darkOnTertiaryContainerKey,
  darkErrorKey,
  darkOnErrorKey,
  darkErrorContainerKey,
  darkOnErrorContainerKey,
  darkOutlineKey,
  darkOutlineVariantKey,
  darkBackgroundKey,
  darkOnBackgroundKey,
  darkSurfaceKey,
  darkOnSurfaceKey,
  darkSurfaceVariantKey,
  darkOnSurfaceVariantKey,
  darkInverseSurfaceKey,
  darkOnInverseSurfaceKey,
  darkInversePrimaryKey,
  darkScrimKey,
  darkShadowKey,
  darkSurfaceTintKey,
];
