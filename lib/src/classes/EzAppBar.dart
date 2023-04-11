library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAppBar extends PlatformAppBar {
  final Key? key;
  final Key? widgetKey;
  final bool? automaticallyImplyLeading;
  final Widget? leading;
  final Widget title;
  final dynamic trailing;

  /// Styles a [PlatformAppBar] with [EzConfig.prefs]
  EzAppBar({
    this.key,
    this.widgetKey,
    this.automaticallyImplyLeading,
    this.leading,
    required this.title,
    this.trailing,
  }) : super(
          // Widgets
          automaticallyImplyLeading: automaticallyImplyLeading,
          leading: leading,
          title: title,
          trailingActions: (trailing is List<Widget>) ? trailing : null,

          // Color
          backgroundColor: Color(EzConfig.prefs[themeColorKey]),

          // Platform configs
          // Material is handled in EzScaffold.dart
          cupertino: (context, platform) => CupertinoNavigationBarData(
            trailing: (trailing is Widget) ? trailing : null,
          ),
        );
}
