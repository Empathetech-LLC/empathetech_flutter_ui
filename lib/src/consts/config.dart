/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

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

/// EFUI source
/// https://github.com/Empathetech-LLC/empathetech_flutter_ui
const String efuiGitHub =
    'https://github.com/Empathetech-LLC/empathetech_flutter_ui';

/// One of us, one of us, one of us!
/// https://stats.foldingathome.org/team/1063265
const String empathFoldingTeam = 'https://stats.foldingathome.org/team/1063265';

/// If you want to show some love
/// https://gofund.me/c047d07e
const String empathGoFundMe = 'https://gofund.me/c047d07e';

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

// EzConfig base //

/// Empathetech's default configuration for [EzConfig]
const Map<String, Object> empathetechConfig = <String, Object>{
  // Global settings //

  isLeftyKey: false,

  // Text settings //

  // Display
  displayFontFamilyKey: roboto,
  displayFontSizeKey: 42.0,
  displayBoldKey: false,
  displayItalicsKey: false,
  displayUnderlinedKey: false,
  displayFontHeightKey: 1.5,
  displayLetterSpacingKey: 0.25,
  displayWordSpacingKey: 1.0,

  // Headline
  headlineFontFamilyKey: roboto,
  headlineFontSizeKey: 32.0,
  headlineBoldKey: false,
  headlineItalicsKey: false,
  headlineUnderlinedKey: false,
  headlineFontHeightKey: 1.5,
  headlineLetterSpacingKey: 0.25,
  headlineWordSpacingKey: 1.0,

  // Title
  titleFontFamilyKey: roboto,
  titleFontSizeKey: 22.0,
  titleBoldKey: true,
  titleItalicsKey: false,
  titleUnderlinedKey: false,
  titleFontHeightKey: 1.5,
  titleLetterSpacingKey: 0.25,
  titleWordSpacingKey: 1.0,

  // Body
  bodyFontFamilyKey: roboto,
  bodyFontSizeKey: 16.0,
  bodyBoldKey: false,
  bodyItalicsKey: false,
  bodyUnderlinedKey: false,
  bodyFontHeightKey: 1.5,
  bodyLetterSpacingKey: 0.25,
  bodyWordSpacingKey: 1.0,

  // Label
  labelFontFamilyKey: roboto,
  labelFontSizeKey: 14.0,
  labelBoldKey: false,
  labelItalicsKey: false,
  labelUnderlinedKey: false,
  labelFontHeightKey: 1.5,
  labelLetterSpacingKey: 0.25,
  labelWordSpacingKey: 1.0,

  // Background opacity
  darkTextBackgroundOKey: 0.0,
  lightTextBackgroundOKey: 0.0,

  // Layout settings //

  marginKey: 10.0, // required key
  paddingKey: 20.0, // required key
  spacingKey: 25.0, // required key

  hideScrollKey: false,

  // Color settings //

  // Light
  lightPrimaryKey: empathPurpleHex, // required key
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
  darkPrimaryKey: empathEucalyptusHex, // required key
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
