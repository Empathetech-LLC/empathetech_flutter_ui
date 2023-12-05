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

  lightPrimaryKey: EmpathPurpleHex, // required
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

  darkPrimaryKey: EmpathEucalyptusHex, // required
  darkOnPrimaryKey: blackHex,

  darkSecondaryKey: EmpathGoldenrodHex,
  darkOnSecondaryKey: blackHex,

  darkTertiaryKey: EmpathPurpleHex,
  darkOnTertiaryKey: whiteHex,

  // Style settings //

  fontFamilyKey: roboto,

  marginKey: 20.0, // required
  paddingKey: 20.0, // required

  buttonSpacingKey: 40.0, // required
  textSpacingKey: 80.0, // required
};
