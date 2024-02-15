/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

enum TextStyleType { display, headline, title, body, label }

extension Keys on TextStyleType {
  String get familyKey {
    switch (this) {
      case TextStyleType.display:
        return displayFontFamilyKey;
      case TextStyleType.headline:
        return headlineFontFamilyKey;
      case TextStyleType.title:
        return titleFontFamilyKey;
      case TextStyleType.body:
        return bodyFontFamilyKey;
      case TextStyleType.label:
        return labelFontFamilyKey;
    }
  }

  String get sizeKey {
    switch (this) {
      case TextStyleType.display:
        return displayFontSizeKey;
      case TextStyleType.headline:
        return headlineFontSizeKey;
      case TextStyleType.title:
        return titleFontSizeKey;
      case TextStyleType.body:
        return bodyFontSizeKey;
      case TextStyleType.label:
        return labelFontSizeKey;
    }
  }

  String get weightKey {
    switch (this) {
      case TextStyleType.display:
        return displayFontWeightKey;
      case TextStyleType.headline:
        return headlineFontWeightKey;
      case TextStyleType.title:
        return titleFontWeightKey;
      case TextStyleType.body:
        return bodyFontWeightKey;
      case TextStyleType.label:
        return labelFontWeightKey;
    }
  }

  String get styleKey {
    switch (this) {
      case TextStyleType.display:
        return displayFontStyleKey;
      case TextStyleType.headline:
        return headlineFontStyleKey;
      case TextStyleType.title:
        return titleFontStyleKey;
      case TextStyleType.body:
        return bodyFontStyleKey;
      case TextStyleType.label:
        return labelFontStyleKey;
    }
  }

  String get letterSpacingKey {
    switch (this) {
      case TextStyleType.display:
        return displayLetterSpacingKey;
      case TextStyleType.headline:
        return headlineLetterSpacingKey;
      case TextStyleType.title:
        return titleLetterSpacingKey;
      case TextStyleType.body:
        return bodyLetterSpacingKey;
      case TextStyleType.label:
        return labelLetterSpacingKey;
    }
  }

  String get wordSpacingKey {
    switch (this) {
      case TextStyleType.display:
        return displayWordSpacingKey;
      case TextStyleType.headline:
        return headlineWordSpacingKey;
      case TextStyleType.title:
        return titleWordSpacingKey;
      case TextStyleType.body:
        return bodyWordSpacingKey;
      case TextStyleType.label:
        return labelWordSpacingKey;
    }
  }

  String get heightKey {
    switch (this) {
      case TextStyleType.display:
        return displayFontHeightKey;
      case TextStyleType.headline:
        return headlineFontHeightKey;
      case TextStyleType.title:
        return titleFontHeightKey;
      case TextStyleType.body:
        return bodyFontHeightKey;
      case TextStyleType.label:
        return labelFontHeightKey;
    }
  }

  String get decorationKey {
    switch (this) {
      case TextStyleType.display:
        return displayFontDecorationKey;
      case TextStyleType.headline:
        return headlineFontDecorationKey;
      case TextStyleType.title:
        return titleFontDecorationKey;
      case TextStyleType.body:
        return bodyFontDecorationKey;
      case TextStyleType.label:
        return labelFontDecorationKey;
    }
  }
}
