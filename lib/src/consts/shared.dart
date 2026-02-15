/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

//* Assets *//

// For config //

/// assets/nebula-jeremy-müller.jpg
/// https://www.pexels.com/@jmueller/
const String nebulaPath = 'assets/nebula-jeremy-müller.jpg';

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

/// A *required* [NavigatorState] key for your router config
/// UI redraws/rebuilds assume it is present
/// If you're migrating your existing app to EFUI, please find and replace any current navigator state key with this one
final GlobalKey<NavigatorState> ezRootNav = GlobalKey<NavigatorState>();

/// /
const String homePath = '/';

/// SUCCESS
const String success = 'SUCCESS';

/// example.com/image.jpg
const String webImgHint = 'example.com/image.jpg';

//* Localization *//

/// Non-conclusive set containing...
/// ar, fa, he, ur
const Set<String> rtlLanguageCodes = <String>{
  'ar', // Arabic
  'fa', // Persian (Farsi)
  'he', // Hebrew
  'ur', // Urdu
};

//* Theme Data *//

/// Fit
const String boxFitSuffix = 'Fit';

/// Opacity for highlight effects; on hover, on focus, etc
/// Doubles as opacity minimum for crucial elements
/// Some things are too important to be broken by user settings
/// 0.12
const double focusOpacity = 0.125;

/// Allows for app images whose default is an asset to be "null"
const String noImageValue = 'noImage';

/// Ein bit und nicht mehr
/// 255
const int rMax = 255;

/// Sample string for sizing double input boxes
/// -55.55
const String sampleString = '-55.55';

/// Opacity for text selection highlighting
/// 0.25
const double selectionOpacity = 0.25;

/// 0.333
/// Shadow opacity should be "faster" than surface
/// 1:1 looks foggy
const double shadowMod = 0.333;

/// 0xFF264941
const Color chalkboardGreen = Color(0xFF264941);
