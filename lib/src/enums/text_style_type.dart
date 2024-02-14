/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

enum TextStyleType { display, headline, title, body, label }

String tstName(BuildContext context, TextStyleType style) {
  switch (style) {
    case TextStyleType.display:
      return EFUILang.of(context)!.tsDisplay;
    case TextStyleType.headline:
      return EFUILang.of(context)!.tsHeadline;
    case TextStyleType.title:
      return EFUILang.of(context)!.tsTitle;
    case TextStyleType.body:
      return EFUILang.of(context)!.tsBody;
    case TextStyleType.label:
      return EFUILang.of(context)!.tsLabel;
  }
}
