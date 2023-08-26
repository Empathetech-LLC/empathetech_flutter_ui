/// empathetech_flutter_ui
/// Copyright (c) 2023 Empathetech LLC. All rights reserved.
/// See LICENSE for distribution and usage details.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EB2CASA extends CupertinoActionSheetAction {
  final ElevatedButton from;

  /// Quickly convert an [ElevatedButton] into a [CupertinoActionSheetAction]
  EB2CASA({required this.from})
      : super(
          onPressed: from.onPressed ?? () {},
          child: GestureDetector(
            onLongPress: from.onLongPress,
            child: from.child,
          ),
        );
}
