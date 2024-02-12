/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// Global values //

const String homeRoute = '/';

/// Allows for app images whose default is an asset to be "null"
const String noImageValue = 'noImage';

// Key prefixes //

// Text Style
const String display = 'display';
const String headline = 'headline';
const String title = 'title';
const String body = 'body';
const String label = 'label';

// Theme
const String light = 'light';
const String dark = 'dark';

final RegExp prefixesRegExp =
    RegExp('^($display|$headline|$title|$body|$label|$light|$dark)');

// Global settings' keys //

const String isLightThemeKey = 'isLightTheme';

const String userColorsKey = 'userColors';

const String localeKey = 'appLocale';

const String isRightHandKey = 'isRightHand';

/// [isLightThemeKey], [userColorsKey], [localeKey], [isRightHandKey]
const Map<String, Type> globalKeys = <String, Type>{
  isLightThemeKey: bool,
  userColorsKey: List<String>,
  localeKey: List<String>,
  isRightHandKey: bool,
};

// Text settings' keys //

const String fontFamilyKey = 'fontFamily';
const String fontSizeKey = 'fontSize';
const String fontWeightKey = 'fontWeight';
const String fontStyleKey = 'fontStyle';
const String letterSpacingKey = 'letterSpacing';
const String wordSpacingKey = 'wordSpacing';
const String fontHeightKey = 'fontHeight';
const String fontDecorationKey = 'fontDecoration';

const Map<String, Type> textStyleKeys = <String, Type>{
  fontFamilyKey: String,
  fontSizeKey: double,
  fontWeightKey: String,
  fontStyleKey: String,
  letterSpacingKey: double,
  wordSpacingKey: double,
  fontHeightKey: double,
  fontDecorationKey: String,
};

// Text settings' values //

const String thinWeight = 'thin';
const String extraLightWeight = 'extraLight';
const String normalWeight = 'normal';
const String boldWeight = 'bold';
const String blackWeight = 'black';

const String italicStyle = 'italic';
const String normalStyle = 'normal';

const String lineThroughDecoration = 'lineThrough';
const String noDecoration = 'none';
const String overlineDecoration = 'overline';
const String underlineDecoration = 'underline';

// Image settings' keys //

const String colorSchemeImageKey = 'colorSchemeImage';
const String pageImageKey = 'pageImage';

const Map<String, Type> imageKeys = <String, Type>{
  colorSchemeImageKey: String,
  pageImageKey: String,
};

// Color settings' keys //

const String textColorPrefix = 'On';

const String primaryKey = 'primary';
const String onPrimaryKey = 'onPrimary';
const String primaryContainerKey = 'primaryContainer';
const String onPrimaryContainerKey = 'onPrimaryContainer';

const String secondaryKey = 'secondary';
const String onSecondaryKey = 'onSecondary';
const String secondaryContainerKey = 'secondaryContainer';
const String onSecondaryContainerKey = 'onSecondaryContainer';

const String tertiaryKey = 'tertiary';
const String onTertiaryKey = 'onTertiary';
const String tertiaryContainerKey = 'tertiaryContainer';
const String onTertiaryContainerKey = 'onTertiaryContainer';

const String errorKey = 'error';
const String onErrorKey = 'onError';
const String errorContainerKey = 'errorContainer';
const String onErrorContainerKey = 'onErrorContainer';

const String outlineKey = 'outline';
const String outlineVariantKey = 'outlineVariant';

const String backgroundKey = 'background';
const String onBackgroundKey = 'onBackground';

const String surfaceKey = 'surface';
const String onSurfaceKey = 'onSurface';
const String surfaceVariantKey = 'surfaceVariant';
const String onSurfaceVariantKey = 'onSurfaceVariant';
const String inverseSurfaceKey = 'inverseSurface';
const String onInverseSurfaceKey = 'onInverseSurface';

const String inversePrimaryKey = 'inversePrimary';

const String shadowKey = 'shadow';
const String scrimKey = 'scrim';

const String surfaceTintKey = 'surfaceTint';

const Map<String, Type> colorKeys = <String, Type>{
  primaryKey: int,
  onPrimaryKey: int,
  primaryContainerKey: int,
  onPrimaryContainerKey: int,
  secondaryKey: int,
  onSecondaryKey: int,
  secondaryContainerKey: int,
  onSecondaryContainerKey: int,
  tertiaryKey: int,
  onTertiaryKey: int,
  tertiaryContainerKey: int,
  onTertiaryContainerKey: int,
  errorKey: int,
  onErrorKey: int,
  errorContainerKey: int,
  onErrorContainerKey: int,
  outlineKey: int,
  outlineVariantKey: int,
  backgroundKey: int,
  onBackgroundKey: int,
  surfaceKey: int,
  onSurfaceKey: int,
  surfaceVariantKey: int,
  onSurfaceVariantKey: int,
  inverseSurfaceKey: int,
  onInverseSurfaceKey: int,
  inversePrimaryKey: int,
  scrimKey: int,
  shadowKey: int,
  surfaceTintKey: int,
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

/// Ordered List for populating color setting screen(s)
const List<String> allColors = <String>[
  primaryKey,
  onPrimaryKey,
  primaryContainerKey,
  onPrimaryContainerKey,
  secondaryKey,
  onSecondaryKey,
  secondaryContainerKey,
  onSecondaryContainerKey,
  tertiaryKey,
  onTertiaryKey,
  tertiaryContainerKey,
  onTertiaryContainerKey,
  errorKey,
  onErrorKey,
  errorContainerKey,
  onErrorContainerKey,
  outlineKey,
  outlineVariantKey,
  backgroundKey,
  onBackgroundKey,
  surfaceKey,
  onSurfaceKey,
  surfaceVariantKey,
  onSurfaceVariantKey,
  inverseSurfaceKey,
  onInverseSurfaceKey,
  inversePrimaryKey,
  scrimKey,
  shadowKey,
  surfaceTintKey,
];
