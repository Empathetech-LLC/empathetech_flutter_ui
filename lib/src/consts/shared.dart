/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

//* Assets *//

// For config //

/// assets/nebula-jeremy-muller.jpg
/// https://www.pexels.com/@jmueller/
const String nebulaPath = 'assets/nebula-jeremy-muller.jpg';

/// [nebulaPath]
const Set<String> efuiAssetPaths = <String>{nebulaPath};

/// [nebulaPath]
const Map<String, String> efuiAssetCredits = <String, String>{
  nebulaPath: 'https://www.pexels.com/@jmueller/',
};

// For use //

/// [AssetImage] for [nebulaPath]
const AssetImage nebulaAsset =
    AssetImage(nebulaPath, package: 'empathetech_flutter_ui');

/// [nebulaPath]
const Map<String, AssetImage> efuiImageLookup = <String, AssetImage>{
  nebulaPath: nebulaAsset,
};

//* BTS *//

/// /
const String homePath = '/';

/// SUCCESS
const String success = 'SUCCESS';

/// example.com/image.jpg
const String webImgHint = 'example.com/image.jpg';

//* Theme Data *//

/// Fit
const String boxFitSuffix = 'Fit';

/// Crucial opacity threshold; some things are too important to be broken by user settings
/// 0.25
const double crucialOT = 0.25;

/// 0.12
const double focusOpacity = 0.12;

/// 0.08
const double highlightOpacity = 0.08;

/// Allows for app images whose default is an asset to be "null"
const String noImageValue = 'noImage';

/// 255
const int rMax = 255;

/// -55.55
const String sampleString = '55.55';

/// 0.25
const double selectionOpacity = 0.25;

/// 0.333
/// Shadow opacity should be "faster" than surface
/// 1:1 looks foggy
const double shadowMod = 0.333;

/// 0xFF264941
const Color chalkboardGreen = Color(0xFF264941);

//* Localization *//

/// Non-conclusive set containing...
/// ar, fa, he, ur
const Set<String> rtlLanguageCodes = <String>{
  'ar', // Arabic
  'fa', // Persian (Farsi)
  'he', // Hebrew
  'ur', // Urdu
};
