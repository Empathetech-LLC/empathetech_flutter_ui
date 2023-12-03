/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

/// Empathetech's default configuration for [EzConfig]
const Map<String, dynamic> empathetechConfig = {
  // Color settings //

  // Light
  lightBackgroundKey: offWhiteHex,
  lightOnBackgroundKey: blackHex,

  lightSurfaceKey: whiteHex,
  lightOnSurfaceKey: blackHex,

  lightPrimaryKey: EmpathPurpleHex,
  lightOnPrimaryKey: whiteHex,

  lightSecondaryKey: EmpathGoldenrodHex,
  lightOnSecondaryKey: blackHex,

  lightTertiaryKey: EmpathEucalyptusHex,
  lightOnTertiaryKey: blackHex,

  // Dark
  darkBackgroundKey: offBlackHex,
  darkOnBackgroundKey: whiteHex,

  darkSurfaceKey: blackHex,
  darkOnSurfaceKey: whiteHex,

  darkPrimaryKey: EmpathEucalyptusHex,
  darkOnPrimaryKey: blackHex,

  darkSecondaryKey: EmpathGoldenrodHex,
  darkOnSecondaryKey: blackHex,

  darkTertiaryKey: EmpathPurpleHex,
  darkOnTertiaryKey: whiteHex,

  // Style settings //

  fontFamilyKey: roboto,

  marginKey: 15.0,
  paddingKey: 15.0,

  buttonSpacingKey: 30.0,
  textSpacingKey: 60.0,
};
