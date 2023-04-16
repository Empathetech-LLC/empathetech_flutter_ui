/// Styles a [PlatformSwitch] from [EzConfig.prefs]
library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzSwitch extends PlatformSwitch {
  final Key? key;
  final Key? widgetKey;
  final bool value;
  final void Function(bool)? onChanged;

  /// Default:
  /// [EzConfig.prefs] -> buttonColorKey
  final Color? activeColor;
  final MaterialSwitchData Function(BuildContext, PlatformTarget)? material;
  final CupertinoSwitchData Function(BuildContext, PlatformTarget)? cupertino;

  /// Styles a [PlatformSwitch] with [EzConfig.prefs]
  EzSwitch({
    this.key,
    this.widgetKey,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.material,
    this.cupertino,
  }) : super(
          key: key,
          widgetKey: widgetKey,
          value: value,
          onChanged: onChanged,
          activeColor: activeColor ?? Color(EzConfig.prefs[buttonColorKey]),
          material: material,
          cupertino: cupertino,
        );
}
