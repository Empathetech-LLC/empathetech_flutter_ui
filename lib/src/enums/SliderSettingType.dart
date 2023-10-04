/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Enumerator for selecting the type of setting that is being updated
/// This will determine the preview [Widget]s
enum SliderSettingType {
  margin,
  padding,
  circleSize,
  buttonSpacing,
  textSpacing,
}

/// Enumerator extension for getting the proper [String] name for [EzSliderSetting.type]
extension SettingName on SliderSettingType {
  String get name {
    switch (this) {
      case SliderSettingType.margin:
        return "margin";
      case SliderSettingType.padding:
        return "padding";
      case SliderSettingType.circleSize:
        return "circle button size";
      case SliderSettingType.buttonSpacing:
        return "button spacing";
      case SliderSettingType.textSpacing:
        return "text spacing.";
    }
  }
}

/// Enumerator extension for getting the proper button [Icon] for [EzSliderSetting.type]
extension SettingIcon on SliderSettingType {
  Icon get icon {
    switch (this) {
      case SliderSettingType.margin:
        return const Icon(Icons.margin);
      case SliderSettingType.padding:
        return const Icon(Icons.padding);
      case SliderSettingType.circleSize:
        return const Icon(Icons.circle);
      case SliderSettingType.buttonSpacing:
        return const Icon(Icons.space_bar);
      case SliderSettingType.textSpacing:
        return const Icon(Icons.space_bar);
    }
  }
}
