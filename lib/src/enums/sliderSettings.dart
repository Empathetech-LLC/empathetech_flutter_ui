/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Enumerator for selecting the type of setting that is being updated
/// This will determine the preview [Widget]s
enum SettingType {
  margin,
  padding,
  circleSize,
  buttonSpacing,
  textSpacing,
}

/// Enumerator extension for getting the proper [String] name for [EzSliderSetting.type]
extension SettingName on SettingType {
  String get name {
    switch (this) {
      case SettingType.margin:
        return "margin";
      case SettingType.padding:
        return "padding";
      case SettingType.circleSize:
        return "circle button size";
      case SettingType.buttonSpacing:
        return "button spacing";
      case SettingType.textSpacing:
        return "text spacing.";
    }
  }
}

/// Enumerator extension for getting the proper [Semantics] label for [EzSliderSetting.type]
extension SettingLabel on SettingType {
  String get label {
    switch (this) {
      case SettingType.margin:
        return "margin. Margin is the distance between the edge of a view and its contents. The app window or a dialog pop up, for example.";
      case SettingType.padding:
        return "padding. Padding is the distance between paired items. A title and its description or a button and its label, for example.";
      case SettingType.circleSize:
        return "circle button size.";
      case SettingType.buttonSpacing:
        return "button spacing.";
      case SettingType.textSpacing:
        return "text spacing.";
    }
  }
}
