/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

/// Empathetech's defaults for [EzConfig]
const Map<String, dynamic> defaultConfig = {
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

  lightBackgroundImageKey: null,
  lightBackgroundColorKey: offWhiteHex,
  lightBackgroundTextColorKey: blackHex,

  lightButtonColorKey: EmpathPurpleHex,
  lightButtonTextColorKey: whiteHex,

  lightAccentColorKey: EmpathGoldenrodHex,
  lightAccentTextColorKey: whiteHex,

  // Dark theme //
  darkThemeColorKey: blackHex,
  darkThemeTextColorKey: whiteHex,

  darkBackgroundImageKey: null,
  darkBackgroundColorKey: offBlackHex,
  darkBackgroundTextColorKey: whiteHex,

  darkButtonColorKey: EmpathEucalyptusHex,
  darkButtonTextColorKey: blackHex,

  darkAccentColorKey: EmpathGoldenrodHex,
  darkAccentTextColorKey: whiteHex,
};
