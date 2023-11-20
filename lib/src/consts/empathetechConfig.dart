/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

// Brand Colors //

const int EmpathEucalyptusHex = 0xFF20DAA5;
const Color EmpathEucalyptus = Color(EmpathEucalyptusHex);

const int EmpathPurpleHex = 0xFFA520DA;
const Color EmpathPurple = Color(EmpathPurpleHex);

const int EmpathGoldenrodHex = 0xFFDAA520;
const Color EmpathGoldenrod = Color(EmpathGoldenrodHex);

const int EmpathErrorRedHex = 0xFFDA2035;
const Color EmpathErrorRed = Color(EmpathErrorRedHex);

const int whiteHex = 0xFFFFFFFF;
const int offWhiteHex = 0xFFF5F5F5;
const Color offWhite = Color(offWhiteHex);

const int blackHex = 0xFF000000;
const int offBlackHex = 0xFF191919;
const Color offBlack = Color(offBlackHex);

const int greyPointHex = 0xFF878787;
const Color greyPoint = Color(greyPointHex);

// EzConfig base ///

/// Empathetech's base theme configuration for [EzConfig]
const Map<String, dynamic> empathetechConfig = {
  // Styling

  fontFamilyKey: roboto,

  marginKey: 15.0,
  paddingKey: 15.0,

  circleDiameterKey: 45.0,

  buttonSpacingKey: 30.0,
  textSpacingKey: 60.0,

  // Colors

  // Light

  lightPrimaryColorKey: EmpathPurpleHex,
  lightOnPrimaryColorKey: whiteHex,
  lightPrimaryContainerColorKey: EmpathPurpleHex,
  lightOnPrimaryContainerColorKey: whiteHex,

  lightSecondaryColorKey: EmpathGoldenrodHex,
  lightOnSecondaryColorKey: blackHex,
  lightSecondaryContainerColorKey: EmpathGoldenrodHex,
  lightOnSecondaryContainerColorKey: blackHex,

  lightTertiaryColorKey: EmpathEucalyptusHex,
  lightOnTertiaryColorKey: blackHex,
  lightTertiaryContainerColorKey: EmpathEucalyptusHex,
  lightOnTertiaryContainerColorKey: blackHex,

  lightErrorColorKey: EmpathErrorRedHex,
  lightOnErrorColorKey: whiteHex,
  lightErrorContainerColorKey: EmpathErrorRedHex,
  lightOnErrorContainerColorKey: whiteHex,

  lightBackgroundColorKey: offWhiteHex,
  lightOnBackgroundColorKey: blackHex,
  lightSurfaceColorKey: whiteHex,
  lightOnSurfaceColorKey: blackHex,

  lightOutlineColorKey: greyPointHex,

  // Dark

  darkPrimaryColorKey: EmpathEucalyptusHex,
  darkOnPrimaryColorKey: blackHex,
  darkPrimaryContainerColorKey: EmpathEucalyptus,
  darkOnPrimaryContainerColorKey: blackHex,

  darkSecondaryColorKey: EmpathGoldenrodHex,
  darkOnSecondaryColorKey: blackHex,
  darkSecondaryContainerColorKey: EmpathGoldenrodHex,
  darkOnSecondaryContainerColorKey: blackHex,

  darkTertiaryColorKey: EmpathPurpleHex,
  darkOnTertiaryColorKey: whiteHex,
  darkTertiaryContainerColorKey: EmpathPurpleHex,
  darkOnTertiaryContainerColorKey: whiteHex,

  darkErrorColorKey: EmpathErrorRedHex,
  darkOnErrorColorKey: whiteHex,
  darkErrorContainerColorKey: EmpathErrorRedHex,
  darkOnErrorContainerColorKey: whiteHex,

  darkBackgroundColorKey: blackHex,
  darkOnBackgroundColorKey: whiteHex,
  darkSurfaceColorKey: offBlackHex,
  darkOnSurfaceColorKey: whiteHex,

  darkOutlineColorKey: greyPointHex,

  // Images
  lightPageImageKey: noImageKey,
  darkPageImageKey: noImageKey,
};

// Public links //

/// One of us, one of us, one of us!
const String EmpathetechCommunity = 'community@empathetech.net';

/// If you need a hand
const String EmpathetechSupport = 'support@empathetech.net';

/// If you need two hands
const String EmpathetechAdmin = 'admin@empathetech.net';

/// See what we're up to!
const String EmpathetechLinkedIn =
    "https://linkedin.com/company/empathetech-llc";

/// See what we're up to!
const String EmpathetechMastodon = "https://mastodon.social/@empathetech";

/// Where the magic happens
const String EmpathetechGitHub = 'https://github.com/Empathetech-LLC';

/// One of us, one of us, one of us!
const String EmpathetechFoldingTeam =
    'https://stats.foldingathome.org/team/1063265';

/// If you want to show some love
const String EmpathetechPayPal =
    'https://www.paypal.com/donate/?hosted_button_id=NGEL6AB5A6KNL';

/// If you want to show some love
const String EmpathetechVenmo = 'https://venmo.com/empathetech';

/// If you want to show some love
const String EmpathetechCashApp = 'https://cash.app/\$empathetech';

/// If you want to show some love
const String EmpathetechPatreon = "https://patreon.com/empathetech";

/// If you want to show some love
const String EmpathetechCoffee = 'https://www.buymeacoffee.com/empathetech';

/// If you want to show some love
const String EmpathetechKofi = "https://ko-fi.com/empathetech";
