/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

//// Brand names ////

/// Short == EFUI
const String efuiS = 'EFUI';

/// Long == Empathetech Flutter UI
const String efuiL = 'Empathetech Flutter UI';

/// Empathetic Flutter UI
const String efuiLFix = 'Empathetic Flutter UI';

//// Brand links ////

// Code //

/// Where the magic happens
/// https://github.com/Empathetech-LLC
const String empathGitHub = 'https://github.com/Empathetech-LLC';

/// EFUI source
/// https://github.com/Empathetech-LLC/empathetech_flutter_ui
const String efuiGitHub =
    'https://github.com/Empathetech-LLC/empathetech_flutter_ui';

/// [https://m3.material.io/styles/color/roles]
const String materialColorRoles = 'https://m3.material.io/styles/color/roles';

// Internal links //

/// Where we rep the goods
/// 'https://www.empathetech.net/#/products/open-ui'
const String openUIProdPage = 'https://www.empathetech.net/#/products/open-ui';

/// Where new journeys begin
/// 'https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases'
const String openUIReleases =
    'https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases';

// Emails //

/// If you want to lend a hand
/// community@empathetech.net
const String empathCommunity = 'community@empathetech.net';

/// If you need a hand
/// support@empathetech.net
const String empathSupport = 'support@empathetech.net';

/// If you want to say hi
/// mwaldron@empathetech.net
const String empathFounder = 'mwaldron@empathetech.net';

// Socials //

/// If you want to stay informed
/// http://eepurl.com/iHe_I2
const String empathNewsletter = 'http://eepurl.com/iHe_I2';

/// If you want to get in touch
/// https://mastodon.social/@empathetech
const String empathMastodon = 'https://mastodon.social/@empathetech';

/// If you want to get in touch
/// https://bsky.app/profile/empathetech.net
const String empathBluesky = 'https://bsky.app/profile/empathetech.net';

/// If you want to get in touch
/// https://linkedin.com/company/empathetech-llc
const String empathLinkedIn = 'https://linkedin.com/company/empathetech-llc';

// Community //

/// One of us, one of us, one of us!
/// https://stats.foldingathome.org/team/1063265
const String empathFoldingTeam = 'https://stats.foldingathome.org/team/1063265';

// Crowdfunding //

/// If you want to show some love
/// https://gofund.me/c047d07e
const String empathGoFundMe = 'https://gofund.me/c047d07e';

/// If you want to show some love
/// https://patreon.com/empathetech
const String empathPatreon = 'https://patreon.com/empathetech';

/// If you want to show some love
/// https://www.buymeacoffee.com/empathetech
const String empathCoffee = 'https://www.buymeacoffee.com/empathetech';

/// If you want to show some love
/// https://ko-fi.com/empathetech
const String empathKofi = 'https://ko-fi.com/empathetech';

/// If you want to show some love
/// https://www.paypal.com/donate/?hosted_button_id=NGEL6AB5A6KNL
const String empathPayPal =
    'https://www.paypal.com/donate/?hosted_button_id=NGEL6AB5A6KNL';

/// If you want to show some love
/// https://venmo.com/empathetech
const String empathVenmo = 'https://venmo.com/empathetech';

/// If you want to show some love
/// https://cash.app/$empathetech
const String empathCashApp = 'https://cash.app/\$empathetech';

//// Brand config ////

// Text theme //

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

/// 0.0
const double defaultTextOpacity = 0.0;

/// 20.0
const double defaultIconSize = 20.0;

/// 1.5
const double defaultFontHeight = 1.5;

/// 0.25
const double defaultLetterSpacing = 0.25;

/// 1.0
const double defaultWordSpacing = 1.0;

// Layout //

/// 10.0
const double defaultMargin = 10.0;

/// 20.0
const double defaultPadding = 20.0;

/// 25.0
const double defaultSpacing = 25.0;

// Color scheme //

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

// Map //

/// Empathetech [EzConfig.defaults]
const Map<String, Object> empathetechConfig = <String, Object>{
  // Global settings //

  isLeftyKey: false,

  // Text settings //

  // Display
  displayFontFamilyKey: roboto,
  displayFontSizeKey: defaultDisplaySize,
  displayBoldedKey: false,
  displayItalicizedKey: false,
  displayUnderlinedKey: false,
  displayFontHeightKey: defaultFontHeight,
  displayLetterSpacingKey: defaultLetterSpacing,
  displayWordSpacingKey: defaultWordSpacing,

  // Headline
  headlineFontFamilyKey: roboto,
  headlineFontSizeKey: defaultHeadlineSize,
  headlineBoldedKey: false,
  headlineItalicizedKey: false,
  headlineUnderlinedKey: false,
  headlineFontHeightKey: defaultFontHeight,
  headlineLetterSpacingKey: defaultLetterSpacing,
  headlineWordSpacingKey: defaultWordSpacing,

  // Title
  titleFontFamilyKey: roboto,
  titleFontSizeKey: defaultTitleSize,
  titleBoldedKey: true,
  titleItalicizedKey: false,
  titleUnderlinedKey: false,
  titleFontHeightKey: defaultFontHeight,
  titleLetterSpacingKey: defaultLetterSpacing,
  titleWordSpacingKey: defaultWordSpacing,

  // Body
  bodyFontFamilyKey: roboto,
  bodyFontSizeKey: defaultBodySize,
  bodyBoldedKey: false,
  bodyItalicizedKey: false,
  bodyUnderlinedKey: false,
  bodyFontHeightKey: defaultFontHeight,
  bodyLetterSpacingKey: defaultLetterSpacing,
  bodyWordSpacingKey: defaultWordSpacing,

  // Label
  labelFontFamilyKey: roboto,
  labelFontSizeKey: defaultLabelSize,
  labelBoldedKey: false,
  labelItalicizedKey: false,
  labelUnderlinedKey: false,
  labelFontHeightKey: defaultFontHeight,
  labelLetterSpacingKey: defaultLetterSpacing,
  labelWordSpacingKey: defaultWordSpacing,

  // Background opacity
  darkTextBackgroundOpacityKey: defaultTextOpacity,
  lightTextBackgroundOpacityKey: defaultTextOpacity,

  // Icon size
  iconSizeKey: defaultIconSize,

  // Layout settings //

  marginKey: defaultMargin,
  paddingKey: defaultPadding,
  spacingKey: defaultSpacing,

  hideScrollKey: false,

  // Color settings //

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

  lightSurfaceKey: whiteHex,
  lightOnSurfaceKey: blackHex,
  lightSurfaceContainerKey: offWhiteHex,
  lightInversePrimaryKey: empathPurpleHex,
  lightSurfaceTintKey: transparentHex,

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
