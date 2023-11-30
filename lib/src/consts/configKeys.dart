/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// Global settings //

const String isLightKey = 'isLight';

const String localeKey = 'appLocale';

const Set<String> globalKeys = {isLightKey, localeKey};

// Image settings //

// Light

const String lightPageImageKey = 'lightPageImage';
const String lightColorSchemeImageKey = 'lightColorSchemeImage';

const Set<String> lightImageKeys = {
  lightPageImageKey,
  lightColorSchemeImageKey,
};

// Dark

const String darkPageImageKey = 'darkPageImage';
const String darkColorSchemeImageKey = 'darkColorSchemeImage';

const Set<String> darkImageKeys = {
  darkPageImageKey,
  darkColorSchemeImageKey,
};

// Color settings //
// https://api.flutter.dev/flutter/material/ColorScheme-class.html

// Light

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

const Set<String> lightColorKeys = {
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
};

// Dark

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

const Set<String> darkColorKeys = {
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
};

// Layout settings //

const String isRightKey = 'isRight';

const String marginKey = 'margin';

const String textSpacingKey = 'textSpacing';
const String buttonSpacingKey = 'buttonSpacing';

const Set<String> layoutKeys = {
  isRightKey,
  marginKey,
  textSpacingKey,
  buttonSpacingKey,
};

// Style settings //

const String fontFamilyKey = 'fontFamily';

const String paddingKey = 'padding';

const String circleDiameterKey = 'circleDiameter';

const Set<String> styleKeys = {
  fontFamilyKey,
  paddingKey,
  circleDiameterKey,
};

const Set<String> allKeys = {
  ...globalKeys,
  ...lightImageKeys,
  ...darkImageKeys,
  ...lightColorKeys,
  ...darkColorKeys,
  ...layoutKeys,
  ...styleKeys
};
