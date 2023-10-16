/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

// Define brand Colors //

const int EmpathEucalyptusHex = 0xFF20DAA5;
const Color EmpathEucalyptus = Color(EmpathEucalyptusHex);

const int EmpathPurpleHex = 0xFFA520DA;
const Color EmpathPurple = Color(EmpathPurpleHex);

const int EmpathGoldenrodHex = 0xFFDAA520;
const Color EmpathGoldenrod = Color(EmpathGoldenrodHex);

const int whiteHex = 0xFFFFFFFF;
const int offWhiteHex = 0xFFF5F5F5;
const Color offWhite = Color(offWhiteHex);

const int blackHex = 0xFF000000;
const int offBlackHex = 0xFF191919;
const Color offBlack = Color(offBlackHex);

// Define EzConfig base ///

/// Empathetech's base theme configuration for [EzConfig]
const Map<String, dynamic> empathetechConfig = {
  // App-wide //
  marginKey: 15.0,
  paddingKey: 12.5,

  buttonSpacingKey: 30.0,
  textSpacingKey: 35.0,

  circleDiameterKey: 45.0,

  fontFamilyKey: roboto,

  // Light theme //
  lightThemeColorKey: whiteHex,
  lightThemeTextColorKey: blackHex,

  lightPageImageKey: noImageKey,
  lightPageColorKey: offWhiteHex,
  lightPageTextColorKey: blackHex,

  lightButtonColorKey: EmpathPurpleHex,
  lightButtonTextColorKey: whiteHex,

  lightAccentColorKey: EmpathGoldenrodHex,
  lightAccentTextColorKey: whiteHex,

  // Dark theme //
  darkThemeColorKey: blackHex,
  darkThemeTextColorKey: whiteHex,

  darkPageImageKey: noImageKey,
  darkPageColorKey: offBlackHex,
  darkPageTextColorKey: whiteHex,

  darkButtonColorKey: EmpathEucalyptusHex,
  darkButtonTextColorKey: blackHex,

  darkAccentColorKey: EmpathGoldenrodHex,
  darkAccentTextColorKey: whiteHex,
};

// Define public links //

/// One of us, one of us, one of us!
const String EmpathetechCommunityContact = 'community@empathetech.net';

/// If you need to reach out
const String EmpathetechSupport = 'support@empathetech.net';

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
const String EmpathetechVenmo = 'https://venmo.com/empathetech-llc';

/// If you want to show some love
const String EmpathetechCashApp = 'https://cash.app/\$empathetech';
