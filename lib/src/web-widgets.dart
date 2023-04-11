library empathetech_flutter_ui;

import 'package:flutter/material.dart';

/// Quick [MouseRegion] && [GestureDetector] combo
Widget ezClickable({
  required Widget child,
  void Function()? onTap,
  void Function()? onLongPress,
}) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: child,
    ),
  );
}
