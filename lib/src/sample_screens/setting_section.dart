/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

import '../../empathetech_flutter_ui.dart';

// Shared //

class EzSettingsSection {
  /// Ordered position amongst the tabs ([ButtonSegment]s)
  final int position;

  /// What to display above the [SegmentedButton] in [EzSettingsHub]
  final String title;

  /// What to display on the [SegmentedButton] in [EzSettingsHub]
  final Widget icon;

  /// Page content for [EzSettingsHub]
  final Widget build;

  /// Wrapper/helper class for building [EzSettingsHub]
  const EzSettingsSection({
    required this.position,
    required this.title,
    required this.icon,
    required this.build,
  });
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
