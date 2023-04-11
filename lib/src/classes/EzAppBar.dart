library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

PlatformAppBar EzAppBar({
  bool? automaticallyImplyLeading,
  Widget? leading,
  required Widget title,
  List<Widget>? trailingActions,
  EzDrawer? endDrawer,
}) {
  return PlatformAppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    leading: leading,
    title: title,
    trailingActions: trailingActions,
    cupertino: (context, platform) => CupertinoNavigationBarData(
      trailing: endDrawer,
    ),
  );
}
