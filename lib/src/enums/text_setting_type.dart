/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

enum TextSettingType { display, headline, title, body, label }

extension Keys on TextSettingType {
  String get familyKey {
    switch (this) {
      case TextSettingType.display:
        return displayFontFamilyKey;
      case TextSettingType.headline:
        return headlineFontFamilyKey;
      case TextSettingType.title:
        return titleFontFamilyKey;
      case TextSettingType.body:
        return bodyFontFamilyKey;
      case TextSettingType.label:
        return labelFontFamilyKey;
    }
  }

  String get sizeKey {
    switch (this) {
      case TextSettingType.display:
        return displayFontSizeKey;
      case TextSettingType.headline:
        return headlineFontSizeKey;
      case TextSettingType.title:
        return titleFontSizeKey;
      case TextSettingType.body:
        return bodyFontSizeKey;
      case TextSettingType.label:
        return labelFontSizeKey;
    }
  }

  String get weightKey {
    switch (this) {
      case TextSettingType.display:
        return displayFontWeightKey;
      case TextSettingType.headline:
        return headlineFontWeightKey;
      case TextSettingType.title:
        return titleFontWeightKey;
      case TextSettingType.body:
        return bodyFontWeightKey;
      case TextSettingType.label:
        return labelFontWeightKey;
    }
  }

  String get styleKey {
    switch (this) {
      case TextSettingType.display:
        return displayFontStyleKey;
      case TextSettingType.headline:
        return headlineFontStyleKey;
      case TextSettingType.title:
        return titleFontStyleKey;
      case TextSettingType.body:
        return bodyFontStyleKey;
      case TextSettingType.label:
        return labelFontStyleKey;
    }
  }

  String get letterSpacingKey {
    switch (this) {
      case TextSettingType.display:
        return displayLetterSpacingKey;
      case TextSettingType.headline:
        return headlineLetterSpacingKey;
      case TextSettingType.title:
        return titleLetterSpacingKey;
      case TextSettingType.body:
        return bodyLetterSpacingKey;
      case TextSettingType.label:
        return labelLetterSpacingKey;
    }
  }

  String get wordSpacingKey {
    switch (this) {
      case TextSettingType.display:
        return displayWordSpacingKey;
      case TextSettingType.headline:
        return headlineWordSpacingKey;
      case TextSettingType.title:
        return titleWordSpacingKey;
      case TextSettingType.body:
        return bodyWordSpacingKey;
      case TextSettingType.label:
        return labelWordSpacingKey;
    }
  }

  String get heightKey {
    switch (this) {
      case TextSettingType.display:
        return displayFontHeightKey;
      case TextSettingType.headline:
        return headlineFontHeightKey;
      case TextSettingType.title:
        return titleFontHeightKey;
      case TextSettingType.body:
        return bodyFontHeightKey;
      case TextSettingType.label:
        return labelFontHeightKey;
    }
  }

  String get decorationKey {
    switch (this) {
      case TextSettingType.display:
        return displayFontDecorationKey;
      case TextSettingType.headline:
        return headlineFontDecorationKey;
      case TextSettingType.title:
        return titleFontDecorationKey;
      case TextSettingType.body:
        return bodyFontDecorationKey;
      case TextSettingType.label:
        return labelFontDecorationKey;
    }
  }
}
