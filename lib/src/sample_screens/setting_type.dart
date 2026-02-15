/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// Shared //

const String _quick = 'quick';
const String _advanced = 'advanced';

// Color //

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

// Text //

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
