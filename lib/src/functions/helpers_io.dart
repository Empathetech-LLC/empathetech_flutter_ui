/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/services.dart';

/// True if [Platform.isAndroid] or [Platform.isIOS]
bool mobileCheck() => Platform.isAndroid || Platform.isIOS;

/// Get the current [TargetPlatform] the slow (and reliable) way
/// Checking each [Platform].is
/// [TargetPlatform.fuchsia] is currently absorbed by [TargetPlatform.linux]
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

/// Request/exit a fullscreen window
Future<void> toggleFullscreen(bool isFull) async {
  switch (EzConfig.platform) {
    case TargetPlatform.android:
    case TargetPlatform.iOS:
    case TargetPlatform.fuchsia:
      isFull
          ? await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge)
          : await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      break;

    case TargetPlatform.linux:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
      if (isFull) {
        // REPLACE: await windowManager.setFullScreen(true);
      } else {
        // REPLACE: await windowManager.setFullScreen(false);
      }
      break;
  }
}
