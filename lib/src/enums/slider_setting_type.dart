/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Enumerator for selecting the type of setting that is being updated
/// This will determine the preview [Widget]s
enum SliderSettingType {
  // Text
  fontSize,
  fontWeight,
  fontStyle,
  letterSpacing,
  wordSpacing,
  fontHeight,
  fontDecoration,

  // Layout
  margin,
  padding,
  spacing,
}

/// Get the proper [String] name for [EzSliderSetting.type]
String sstName(BuildContext context, SliderSettingType settingType) {
  switch (settingType) {
    case SliderSettingType.fontSize:
      return EFUILang.of(context)!.tsFontSize;
    case SliderSettingType.fontWeight:
      return EFUILang.of(context)!.tsFontWeight;
    case SliderSettingType.fontStyle:
      return EFUILang.of(context)!.tsFontStyle;
    case SliderSettingType.letterSpacing:
      return EFUILang.of(context)!.tsLetterSpacing;
    case SliderSettingType.wordSpacing:
      return EFUILang.of(context)!.tsWordSpacing;
    case SliderSettingType.fontHeight:
      return EFUILang.of(context)!.tsFontHeight;
    case SliderSettingType.fontDecoration:
      return EFUILang.of(context)!.tsFontDecoration;
    case SliderSettingType.margin:
      return EFUILang.of(context)!.lsMargin;
    case SliderSettingType.padding:
      return EFUILang.of(context)!.lsPadding;
    case SliderSettingType.spacing:
      return EFUILang.of(context)!.lsSpacing;
  }
}

/// Enumerator extension for getting the proper button [Icon] for [EzSliderSetting.type]
extension SettingIcon on SliderSettingType {
  Icon get icon {
    switch (this) {
      case SliderSettingType.fontSize:
        return const Icon(Icons.text_fields);
      case SliderSettingType.fontWeight:
        return const Icon(Icons.format_bold);
      case SliderSettingType.fontStyle:
        return const Icon(Icons.format_italic);
      case SliderSettingType.fontHeight:
        return const Icon(Icons.format_line_spacing);
      case SliderSettingType.fontDecoration:
        return const Icon(Icons.format_underline);
      case SliderSettingType.margin:
        return const Icon(Icons.margin);
      case SliderSettingType.padding:
        return const Icon(Icons.padding);
      case SliderSettingType.letterSpacing:
      case SliderSettingType.wordSpacing:
      case SliderSettingType.spacing:
        return const Icon(Icons.space_bar);
    }
  }
}
