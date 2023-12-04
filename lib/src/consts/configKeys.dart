/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// Global settings //

const String isRightHandKey = 'isRightHand';

const String isLightThemeKey = 'isLightTheme';

const String localeKey = 'appLocale';

const Map<String, Type> globalKeys = {
  isRightHandKey: bool,
  isLightThemeKey: bool,
  localeKey: String,
};

// Image settings //

// Light

const String lightColorSchemeImageKey = 'lightColorSchemeImage';
const String lightPageImageKey = 'lightPageImage';

const Map<String, Type> lightImageKeys = {
  lightColorSchemeImageKey: String,
  lightPageImageKey: String,
};

// Dark

const String darkColorSchemeImageKey = 'darkColorSchemeImage';
const String darkPageImageKey = 'darkPageImage';

const Map<String, Type> darkImageKeys = {
  darkColorSchemeImageKey: String,
  darkPageImageKey: String,
};

// Color settings //
// https://api.flutter.dev/flutter/material/ColorScheme-class.html

// Light

const String lightPrimaryKey = 'lightPrimary'; // required
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

const Map<String, Type> lightColorKeys = {
  lightPrimaryKey: int, // required
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
};

// Dark

const String darkPrimaryKey = 'darkPrimary'; // required
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

const Map<String, Type> darkColorKeys = {
  darkPrimaryKey: int, // required
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

// Style settings //

const String fontFamilyKey = 'fontFamily';

const String marginKey = 'margin'; // required
const String paddingKey = 'padding'; // required

const String buttonSpacingKey = 'buttonSpacing'; // required
const String textSpacingKey = 'textSpacing'; // required

const Map<String, Type> styleKeys = {
  fontFamilyKey: String,
  marginKey: int, // required
  paddingKey: int, // required
  buttonSpacingKey: int, // required
  textSpacingKey: int, // required
};

const Map<String, Type> allKeys = {
  ...globalKeys,
  ...lightImageKeys,
  ...darkImageKeys,
  ...lightColorKeys,
  ...darkColorKeys,
  ...styleKeys
};
