library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// iOS (Cupertino) app data built from [AppConfig.prefs]
CupertinoAppData iosAppTheme() {
  return CupertinoAppData();
}

/// iOS (Cupertino) elevated button theme built from [AppConfig.prefs]
CupertinoElevatedButtonData iosButtonTheme() {
  return CupertinoElevatedButtonData(color: AppConfig.prefs[buttonColorKey]);
}
