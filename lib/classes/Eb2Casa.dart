library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Eb2Casa extends CupertinoActionSheetAction {
  final ElevatedButton from;

  /// Quickly convert an [ElevatedButton] into a [CupertinoActionSheetAction]
  Eb2Casa({required this.from})
      : super(
          onPressed: from.onPressed ?? () {},
          child: GestureDetector(
            onLongPress: from.onLongPress,
            child: from.child,
          ),
        );
}
