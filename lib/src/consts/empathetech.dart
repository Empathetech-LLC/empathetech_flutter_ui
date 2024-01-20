/* empathetech_flutter_ui
 * Copyright (c) 2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

// Brand names //

/// Short == EFUI
const String efuiS = "EFUI";

/// Long == Empathetech Flutter UI
const String efuiL = "Empathetech Flutter UI";

/// Empathetic Flutter UI
const String efuiLFix = "Empathetic Flutter UI";

// Brand Colors //

/// 0xFF20DAA5
const int EmpathEucalyptusHex = 0xFF20DAA5;

/// 0xFFA520DA
const int EmpathPurpleHex = 0xFFA520DA;

/// 0xFFDAA520
const int EmpathGoldenrodHex = 0xFFDAA520;

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
const String EmpathetechCommunity = 'community@empathetech.net';

/// If you need a hand
/// support@empathetech.net
const String EmpathetechSupport = 'support@empathetech.net';

/// If you need two hands
/// admin@empathetech.net
const String EmpathetechAdmin = 'admin@empathetech.net';

/// If you want to stay informed
/// http://eepurl.com/iHe_I2
const String EmpathetechNewsletter = 'http://eepurl.com/iHe_I2';

/// If you want to get in touch
/// https://linkedin.com/company/empathetech-llc
const String EmpathetechLinkedIn = "https://linkedin.com/company/empathetech-llc";

/// If you want to get in touch
/// https://mastodon.social/@empathetech
const String EmpathetechMastodon = "https://mastodon.social/@empathetech";

/// Where the magic happens
/// https://github.com/Empathetech-LLC
const String EmpathetechGitHub = 'https://github.com/Empathetech-LLC';

/// One of us, one of us, one of us!
/// https://stats.foldingathome.org/team/1063265
const String EmpathetechFoldingTeam = 'https://stats.foldingathome.org/team/1063265';

/// If you want to show some love
/// https://www.paypal.com/donate/?hosted_button_id=NGEL6AB5A6KNL
const String EmpathetechPayPal = 'https://www.paypal.com/donate/?hosted_button_id=NGEL6AB5A6KNL';

/// If you want to show some love
/// https://venmo.com/empathetech
const String EmpathetechVenmo = 'https://venmo.com/empathetech';

/// If you want to show some love
/// https://cash.app/\$empathetech
const String EmpathetechCashApp = 'https://cash.app/\$empathetech';

/// If you want to show some love
/// https://patreon.com/empathetech
const String EmpathetechPatreon = "https://patreon.com/empathetech";

/// If you want to show some love
/// https://www.buymeacoffee.com/empathetech
const String EmpathetechCoffee = 'https://www.buymeacoffee.com/empathetech';

/// If you want to show some love
/// https://ko-fi.com/empathetech
const String EmpathetechKofi = "https://ko-fi.com/empathetech";

// Documentation links //

/// [https://m3.material.io/styles/color/roles]
const String materialColorRoles = 'https://m3.material.io/styles/color/roles';

/// [https://m3.material.io/foundations/layout/understanding-layout/spacing]
const String understandingLayout =
    'https://m3.material.io/foundations/layout/understanding-layout/spacing';

// EzConfig base //

/// Empathetech's default configuration for [EzConfig]
const Map<String, dynamic> empathetechConfig = {
  // Color settings //

  // Light
  lightPrimaryKey: EmpathPurpleHex, // required
  lightOnPrimaryKey: whiteHex,

  lightSecondaryKey: EmpathGoldenrodHex,
  lightOnSecondaryKey: blackHex,

  lightTertiaryKey: EmpathEucalyptusHex,
  lightOnTertiaryKey: blackHex,

  lightBackgroundKey: offWhiteHex,
  lightOnBackgroundKey: blackHex,

  lightSurfaceKey: whiteHex,
  lightOnSurfaceKey: blackHex,

  lightSurfaceTintKey: transparentHex,

  // Dark
  darkPrimaryKey: EmpathEucalyptusHex, // required
  darkOnPrimaryKey: blackHex,

  darkSecondaryKey: EmpathGoldenrodHex,
  darkOnSecondaryKey: blackHex,

  darkTertiaryKey: EmpathPurpleHex,
  darkOnTertiaryKey: whiteHex,

  darkBackgroundKey: offBlackHex,
  darkOnBackgroundKey: whiteHex,

  darkSurfaceKey: blackHex,
  darkOnSurfaceKey: whiteHex,

  darkSurfaceTintKey: transparentHex,

  // Style settings //

  fontFamilyKey: roboto,

  marginKey: 20.0, // required
  paddingKey: 20.0, // required

  buttonSpacingKey: 20.0, // required
  textSpacingKey: 40.0, // required
};
