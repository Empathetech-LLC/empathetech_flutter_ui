/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Enumerator for tracking which (horizontal) side of the screen touch points should be on
enum Hand {
  right,
  left,
}

/// Get the proper [String] name for [Hand]
String handName(BuildContext context, Hand hand) {
  switch (hand) {
    case Hand.left:
      return EFUILang.of(context)!.gLeft;
    case Hand.right:
      return EFUILang.of(context)!.gRight;
  }
}
