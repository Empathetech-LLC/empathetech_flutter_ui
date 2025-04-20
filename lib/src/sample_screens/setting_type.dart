/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

/// Text setting types
/// [quick] || [advanced]
enum EzTSType { quick, advanced }

/// [EzTSType] path name
extension TextPaths on EzTSType {
  String get path {
    switch (this) {
      case EzTSType.quick:
        return 'quick';
      case EzTSType.advanced:
        return 'advanced';
    }
  }
}

extension TextNames on EzTSType {
  String get name {
    switch (this) {
      case EzTSType.quick:
        return 'quick_text_settings';
      case EzTSType.advanced:
        return 'advanced_text_settings';
    }
  }
}

/// Color setting types
/// [quick] || [advanced]
enum EzCSType { quick, advanced }

/// [EzCSType] path name
extension ColorPaths on EzCSType {
  String get path {
    switch (this) {
      case EzCSType.quick:
        return 'quick';
      case EzCSType.advanced:
        return 'advanced';
    }
  }
}

/// [EzCSType] path name
extension ColorNames on EzCSType {
  String get name {
    switch (this) {
      case EzCSType.quick:
        return 'quick_color_settings';
      case EzCSType.advanced:
        return 'advanced_color_settings';
    }
  }
}
