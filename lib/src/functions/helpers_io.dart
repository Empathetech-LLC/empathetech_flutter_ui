/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:io';
import 'package:flutter/services.dart';

/// True if [Platform.isIOS] or [Platform.isMacOS]
bool cupertinoCheck() => Platform.isIOS || Platform.isMacOS;

/// True if [Platform.isAndroid] or [Platform.isIOS]
bool mobileCheck() => Platform.isAndroid || Platform.isIOS;

/// True if [Platform.isMacOS], [Platform.isWindows], or [Platform.isLinux]
/// [Platform.isFuchsia] is currently skipped
bool desktopCheck() =>
    Platform.isMacOS || Platform.isWindows || Platform.isLinux;

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
Future<void> toggleFullscreen(TargetPlatform platform, bool isFull) async {
  switch (platform) {
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
