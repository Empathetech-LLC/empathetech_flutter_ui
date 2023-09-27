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

/// Enumerator extension for getting the proper [Semantics] label for [EzSliderSetting.type]
extension SettingLabel on SliderSettingType {
  String get label {
    switch (this) {
      case SliderSettingType.margin:
        return "margin. Margin is the distance between the edge of a view and its contents. The app window or a dialog pop up, for example.";
      case SliderSettingType.padding:
        return "padding. Padding is the distance between paired items. A title and its description or a button and its label, for example.";
      case SliderSettingType.circleSize:
        return "circle button size.";
      case SliderSettingType.buttonSpacing:
        return "button spacing.";
      case SliderSettingType.textSpacing:
        return "text spacing.";
    }
  }
}
