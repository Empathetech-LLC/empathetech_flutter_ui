/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

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
