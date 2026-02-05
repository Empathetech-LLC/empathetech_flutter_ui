/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:web/web.dart';
import 'package:flutter/material.dart';

/// Checks the [window]'s userAgent for mobile devices
bool mobileCheck() {
  final String userAgent = window.navigator.userAgent;

  if (userAgent.contains('Android') ||
      userAgent.contains('iPhone') ||
      userAgent.contains('iPad') ||
      userAgent.contains('iPod')) {
    return true;
  } else {
    return false;
  }
}

/// Get the current [TargetPlatform] the slow (and reliable) way
/// via the [window]'s userAgent
/// [TargetPlatform.fuchsia] is currently absorbed by [TargetPlatform.linux]
TargetPlatform getHostPlatform() {
  final String userAgent = window.navigator.userAgent;

  if (userAgent.contains('Android')) {
    return TargetPlatform.android;
  } else if (userAgent.contains('iPhone') ||
      userAgent.contains('iPad') ||
      userAgent.contains('iPod')) {
    return TargetPlatform.iOS;
  } else if (userAgent.contains('Mac OS')) {
    return TargetPlatform.macOS;
  } else if (userAgent.contains('Windows')) {
    return TargetPlatform.windows;
  } else {
    return TargetPlatform.linux;
  }
}

/// Request/exit a fullscreen window
Future<void> toggleFullscreen(bool isFull) async {
  if (isFull) {
    document.exitFullscreen();
  } else {
    document.documentElement?.requestFullscreen();
  }
}
