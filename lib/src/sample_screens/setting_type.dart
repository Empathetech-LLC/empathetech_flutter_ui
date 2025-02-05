/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

/// [quick] || [advanced]
enum EzSettingType { quick, advanced }

/// [EzSettingType] path name
extension EST on EzSettingType {
  String get path {
    switch (this) {
      case EzSettingType.quick:
        return 'quick';
      case EzSettingType.advanced:
        return 'advanced';
    }
  }
}
