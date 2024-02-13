/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

// Brand names //

/// Short == EFUI
const String efuiS = 'EFUI';

/// Long == Empathetech Flutter UI
const String efuiL = 'Empathetech Flutter UI';

/// Empathetic Flutter UI
const String efuiLFix = 'Empathetic Flutter UI';

// Brand Colors //

/// 0xFF20DAA5
const int empathEucalyptusHex = 0xFF20DAA5;

/// 0xFFA520DA
const int empathPurpleHex = 0xFFA520DA;

/// 0xFFDAA520
const int empathGoldenrodHex = 0xFFDAA520;

/// 0xFFFFFFFF
const int whiteHex = 0xFFFFFFFF;

/// 0xFFF5F5F5
const int offWhiteHex = 0xFFF5F5F5;

/// 0xFF000000
const int blackHex = 0xFF000000;

/// 0xFF191919
const int offBlackHex = 0xFF191919;

/// 0xFF000000
const int transparentHex = 0x00000000;

// Brand links //

/// If you want to lend a hand
/// community@empathetech.net
const String empathCommunity = 'community@empathetech.net';

/// If you need a hand
/// support@empathetech.net
const String empathSupport = 'support@empathetech.net';

/// If you need two hands
/// admin@empathetech.net
const String empathAdmin = 'admin@empathetech.net';

/// If you want to stay informed
/// http://eepurl.com/iHe_I2
const String empathNewsletter = 'http://eepurl.com/iHe_I2';

/// If you want to get in touch
/// https://linkedin.com/company/empathetech-llc
const String empathLinkedIn = 'https://linkedin.com/company/empathetech-llc';

/// If you want to get in touch
/// https://mastodon.social/@empathetech
const String empathMastodon = 'https://mastodon.social/@empathetech';

/// Where the magic happens
/// https://github.com/Empathetech-LLC
const String empathGitHub = 'https://github.com/Empathetech-LLC';

/// One of us, one of us, one of us!
/// https://stats.foldingathome.org/team/1063265
const String empathFoldingTeam = 'https://stats.foldingathome.org/team/1063265';

/// If you want to show some love
/// https://www.paypal.com/donate/?hosted_button_id=NGEL6AB5A6KNL
const String empathPayPal =
    'https://www.paypal.com/donate/?hosted_button_id=NGEL6AB5A6KNL';

/// If you want to show some love
/// https://venmo.com/empathetech
const String empathVenmo = 'https://venmo.com/empathetech';

/// If you want to show some love
/// https://cash.app/\$empathetech
const String empathCashApp = 'https://cash.app/\$empathetech';

/// If you want to show some love
/// https://patreon.com/empathetech
const String empathPatreon = 'https://patreon.com/empathetech';

/// If you want to show some love
/// https://www.buymeacoffee.com/empathetech
const String empathCoffee = 'https://www.buymeacoffee.com/empathetech';

/// If you want to show some love
/// https://ko-fi.com/empathetech
const String empathKofi = 'https://ko-fi.com/empathetech';

// Documentation links //

/// [https://m3.material.io/styles/color/roles]
const String materialColorRoles = 'https://m3.material.io/styles/color/roles';

/// [https://m3.material.io/foundations/layout/understanding-layout/spacing]
const String understandingLayout =
    'https://m3.material.io/foundations/layout/understanding-layout/spacing';

// EzConfig base //

/// Empathetech's default configuration for [EzConfig]
const Map<String, dynamic> empathetechConfig = <String, dynamic>{
  // Text settings //

  // Display
  displayFontFamilyKey: roboto,
  displayFontSizeKey: 57,
  displayFontWeightKey: normalWeight,
  displayFontStyleKey: normalStyle,
  displayLetterSpacingKey: 0.0,
  displayWordSpacingKey: 1.0,
  displayFontHeightKey: 1.5,
  displayFontDecorationKey: noDecoration,

  // Headline
  headlineFontFamilyKey: roboto,
  headlineFontSizeKey: 32,
  headlineFontWeightKey: normalWeight,
  headlineFontStyleKey: normalStyle,
  headlineLetterSpacingKey: 0.0,
  headlineWordSpacingKey: 1.0,
  headlineFontHeightKey: 1.5,
  headlineFontDecorationKey: noDecoration,

  // Title
  titleFontFamilyKey: roboto,
  titleFontSizeKey: 22,
  titleFontWeightKey: normalWeight,
  titleFontStyleKey: normalStyle,
  titleLetterSpacingKey: 0.0,
  titleWordSpacingKey: 1.0,
  titleFontHeightKey: 1.5,
  titleFontDecorationKey: noDecoration,

  // Body
  bodyFontFamilyKey: roboto,
  bodyFontSizeKey: 16,
  bodyFontWeightKey: normalWeight,
  bodyFontStyleKey: normalStyle,
  bodyLetterSpacingKey: 0.0,
  bodyWordSpacingKey: 1.0,
  bodyFontHeightKey: 1.5,
  bodyFontDecorationKey: noDecoration,

  // Label
  labelFontFamilyKey: roboto,
  labelFontSizeKey: 14,
  labelFontWeightKey: normalWeight,
  labelFontStyleKey: normalStyle,
  labelLetterSpacingKey: 0.0,
  labelWordSpacingKey: 1.0,
  labelFontHeightKey: 1.5,
  labelFontDecorationKey: noDecoration,

  // No default image settings //

  // Color settings //

  // Light
  lightPrimaryKey: empathPurpleHex, // required
  lightOnPrimaryKey: whiteHex,
  lightSecondaryKey: empathGoldenrodHex,
  lightOnSecondaryKey: blackHex,
  lightTertiaryKey: empathEucalyptusHex,
  lightOnTertiaryKey: blackHex,
  lightBackgroundKey: offWhiteHex,
  lightOnBackgroundKey: blackHex,
  lightSurfaceKey: whiteHex,
  lightOnSurfaceKey: blackHex,
  lightSurfaceTintKey: transparentHex,

  // Dark
  darkPrimaryKey: empathEucalyptusHex, // required
  darkOnPrimaryKey: blackHex,
  darkSecondaryKey: empathGoldenrodHex,
  darkOnSecondaryKey: blackHex,
  darkTertiaryKey: empathPurpleHex,
  darkOnTertiaryKey: whiteHex,
  darkBackgroundKey: offBlackHex,
  darkOnBackgroundKey: whiteHex,
  darkSurfaceKey: blackHex,
  darkOnSurfaceKey: whiteHex,
  darkSurfaceTintKey: transparentHex,

  // Layout settings //

  marginKey: 20.0, // required
  paddingKey: 20.0, // required
  spacingKey: 20.0, // required
};
