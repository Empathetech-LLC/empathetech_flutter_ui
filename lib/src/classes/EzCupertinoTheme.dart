library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// (iOS) [CupertinoAppData] data built [from] the passed in [MaterialAppData]
CupertinoAppData EzCupertinoTheme() {
  Color themeColor = Color(EzConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(EzConfig.prefs[themeTextColorKey]);

  return CupertinoAppData(
    color: themeColor,
    theme: CupertinoThemeData(
      primaryColor: themeColor,
      primaryContrastingColor: themeTextColor,
      textTheme: cupertinoTextTheme(),
    ),
  );
}
