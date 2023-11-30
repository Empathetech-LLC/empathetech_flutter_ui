/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

/// Empathetech's default configuration for [EzConfig]
const Map<String, dynamic> empathetechConfig = {
  // Color settings

  // Light
  lightBackgroundColorKey: offWhiteHex,
  lightOnBackgroundColorKey: blackHex,

  lightSurfaceColorKey: whiteHex,
  lightOnSurfaceColorKey: blackHex,

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

  lightOutlineColorKey: greyPointHex,

  // Dark
  darkBackgroundColorKey: offBlackHex,
  darkOnBackgroundColorKey: whiteHex,

  darkSurfaceColorKey: blackHex,
  darkOnSurfaceColorKey: whiteHex,

  darkPrimaryColorKey: EmpathEucalyptusHex,
  darkOnPrimaryColorKey: blackHex,
  darkPrimaryContainerColorKey: EmpathEucalyptusHex,
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

  darkOutlineColorKey: greyPointHex,

  // Layout settings

  marginKey: 15.0,

  textSpacingKey: 60.0,
  buttonSpacingKey: 30.0,

  // Style settings

  fontFamilyKey: roboto,

  paddingKey: 15.0,

  circleDiameterKey: 45.0,
};
