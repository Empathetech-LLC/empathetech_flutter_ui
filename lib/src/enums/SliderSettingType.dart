/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

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

/// Get the proper [String] name for [EzSliderSetting.type]
String getSettingName(BuildContext context, SliderSettingType settingType) {
  switch (settingType) {
    case SliderSettingType.margin:
      return EFUIPhrases.of(context)!.margin;
    case SliderSettingType.padding:
      return EFUIPhrases.of(context)!.padding;
    case SliderSettingType.circleSize:
      return EFUIPhrases.of(context)!.circleSize;
    case SliderSettingType.buttonSpacing:
      return EFUIPhrases.of(context)!.buttonSpacing;
    case SliderSettingType.textSpacing:
      return EFUIPhrases.of(context)!.textSpacing;
    default:
      throw Exception("Invalid SliderSettingType: $settingType");
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
