/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../empathetech_flutter_ui.dart';

// Shared //

enum EzSettingSection { global, color, design, layout, text }

extension ESSConfig on EzSettingSection {
  Icon get icon {
    switch (this) {
      case EzSettingSection.global:
        return EzConfig.onMobile
            ? Icon(EzConfig.platform == TargetPlatform.iOS
                ? Icons.phone_iphone
                : Icons.phone_android)
            : const Icon(Icons.computer);
      case EzSettingSection.color:
        return const Icon(Icons.palette);
      case EzSettingSection.design:
        return const Icon(Icons.design_services);
      case EzSettingSection.layout:
        return const Icon(Icons.grid_3x3);
      case EzSettingSection.text:
        return const Icon(Icons.text_format);
    }
  }
}

const String _quick = 'quick';
const String _advanced = 'advanced';

// Color settings //

/// Color setting types
/// [quick] || [advanced]
enum EzCSType { quick, advanced }

/// [EzCSType] path name
extension CSConfig on EzCSType {
  String get path {
    switch (this) {
      case EzCSType.quick:
        return _quick;
      case EzCSType.advanced:
        return _advanced;
    }
  }

  String get name {
    switch (this) {
      case EzCSType.quick:
        return 'quick_color_settings';
      case EzCSType.advanced:
        return 'advanced_color_settings';
    }
  }
}

// Text settings //

/// Text setting types
/// [quick] || [advanced]
enum EzTSType { quick, advanced }

/// [EzTSType] path name
extension TSConfig on EzTSType {
  String get path {
    switch (this) {
      case EzTSType.quick:
        return _quick;
      case EzTSType.advanced:
        return _advanced;
    }
  }

  String get name {
    switch (this) {
      case EzTSType.quick:
        return 'quick_text_settings';
      case EzTSType.advanced:
        return 'advanced_text_settings';
    }
  }
}
