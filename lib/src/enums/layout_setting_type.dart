/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Enumerator for selecting which piece of the layout is being updated
/// This will determine the preview [Widget]s
enum LayoutSettingType {
  margin,
  padding,
  spacing,
}

/// Get the proper [String] name for [EzLayoutSetting.type]
String lstName(BuildContext context, LayoutSettingType settingType) {
  switch (settingType) {
    case LayoutSettingType.margin:
      return EFUILang.of(context)!.lsMargin;
    case LayoutSettingType.padding:
      return EFUILang.of(context)!.lsPadding;
    case LayoutSettingType.spacing:
      return EFUILang.of(context)!.lsSpacing;
  }
}

/// Enumerator extension for getting the proper button [Icon] for [EzLayoutSetting.type]
extension SettingIcon on LayoutSettingType {
  Icon get icon {
    switch (this) {
      case LayoutSettingType.margin:
        return const Icon(Icons.margin);
      case LayoutSettingType.padding:
        return const Icon(Icons.padding);
      case LayoutSettingType.spacing:
        return const Icon(Icons.space_bar);
    }
  }
}
