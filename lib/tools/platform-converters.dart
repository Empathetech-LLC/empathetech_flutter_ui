library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Builds a [CupertinoActionSheetAction] from this an [ElevatedButton]
CupertinoActionSheetAction toAction(ElevatedButton from) {
  return CupertinoActionSheetAction(
    onPressed: from.onPressed ?? () {},
    child: GestureDetector(
      onLongPress: from.onLongPress,
      child: from.child,
    ),
  );
}
