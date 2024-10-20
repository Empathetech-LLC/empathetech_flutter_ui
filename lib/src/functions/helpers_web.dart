/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// Get the current [TargetPlatform] when [kIsWeb]
TargetPlatform getWebHostPlatform(BuildContext context) {
  final String userAgent = html.window.navigator.userAgent;

  if (userAgent.contains('Android')) {
    return TargetPlatform.android;
  } else if (userAgent.contains('iPhone') || userAgent.contains('iPad')) {
    return TargetPlatform.iOS;
  } else if (userAgent.contains('Mac OS')) {
    return TargetPlatform.macOS;
  } else if (userAgent.contains('Windows')) {
    return TargetPlatform.windows;
  } else {
    return TargetPlatform.linux;
  }
}
