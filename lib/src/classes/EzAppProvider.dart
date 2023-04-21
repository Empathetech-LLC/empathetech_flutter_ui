library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAppProvider extends PlatformProvider {
  final Key? key;
  final TargetPlatform? initialPlatform;

  /// Default: PlatformSettingsData(iosUsesMaterialWidgets: true)
  final PlatformSettingsData? settings;

  final EzApp app;

  /// Quickly setup a [PlatformProvider] to pair with [EzApp]
  EzAppProvider({
    this.key,
    this.initialPlatform,
    this.settings,
    required this.app,
  }) : super(
          key: key,
          initialPlatform: initialPlatform,
          settings:
              settings ?? PlatformSettingsData(iosUsesMaterialWidgets: true),
          builder: (context) => app,
        );
}
