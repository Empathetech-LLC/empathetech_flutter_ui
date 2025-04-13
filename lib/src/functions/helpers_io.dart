/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:io';
import 'package:flutter/material.dart';

/// Get the current [TargetPlatform] the slow (and reliable) way
/// Checking each [Platform].is
TargetPlatform getHostPlatform() {
  if (Platform.isAndroid) {
    return TargetPlatform.android;
  } else if (Platform.isIOS) {
    return TargetPlatform.iOS;
  } else if (Platform.isMacOS) {
    return TargetPlatform.macOS;
  } else if (Platform.isWindows) {
    return TargetPlatform.windows;
  } else {
    return TargetPlatform.linux;
  }
}
