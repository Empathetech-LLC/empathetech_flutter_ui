library empathetech_flutter_ui;

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAppProvider extends PlatformProvider {
  final StatelessWidget app;

  /// [PlatformProvider] wrapper with
  /// [PlatformSettingsData] -> iosUsesMaterialWidgets: true
  EzAppProvider({required this.app})
      : super(
          settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
          builder: (context) => app,
        );
}
