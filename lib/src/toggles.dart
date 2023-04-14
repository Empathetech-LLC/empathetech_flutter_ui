library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Styles a [Checkbox] from [EzConfig.prefs]
Widget ezCheckBox({
  required bool value,
  required void Function(bool?)? onChanged,
}) {
  return Checkbox(
    value: value,
    onChanged: onChanged,
    checkColor: Color(EzConfig.prefs[buttonTextColorKey]),
    fillColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return Color(EzConfig.prefs[buttonColorKey]);
        } else {
          return Color(EzConfig.prefs[themeTextColorKey]);
        }
      },
    ),
  );
}
