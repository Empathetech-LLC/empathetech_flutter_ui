library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/cupertino.dart';

/// Overrides defaults with [EzConfig]
CupertinoTextThemeData cupertinoTextTheme(Color color) {
  return CupertinoTextThemeData(
    primaryColor: color,
    textStyle: buildBodyLarge(color),
    actionTextStyle: buildLabelLarge(color),
    tabLabelTextStyle: buildLabelLarge(color),
    navTitleTextStyle: buildTitleMedium(color),
    navLargeTitleTextStyle: buildTitleLarge(color),
    navActionTextStyle: buildLabelLarge(color),
    pickerTextStyle: buildBodyLarge(color),
    dateTimePickerTextStyle: buildBodyLarge(color),
  );
}
