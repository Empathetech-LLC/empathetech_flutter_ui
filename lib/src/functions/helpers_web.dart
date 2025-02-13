/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:web/web.dart';
import 'package:flutter/material.dart';

/// Get the host [TargetPlatform] on web
/// via the [window]'s userAgent
TargetPlatform getHostPlatform(BuildContext context) {
  final String userAgent = window.navigator.userAgent;

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
