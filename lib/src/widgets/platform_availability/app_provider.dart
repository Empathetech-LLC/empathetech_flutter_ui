/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/src/functions/helpers_io.dart';

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAppProvider extends StatelessWidget {
  /// Provided to [PlatformProvider] with a [ScaffoldMessenger] layer
  final Widget app;

  /// [PlatformProvider.initialPlatform] passthrough
  final TargetPlatform? initialPlatform;

  /// [PlatformProvider.settings] passthrough
  final PlatformSettingsData? settings;

  /// Optionally provide a [ScaffoldMessengerState] typed [GlobalKey]
  /// To track [SnackBar]s, [MaterialBanner]s, etc.
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  /// [PlatformProvider] wrapper with [ezThemeData] defaults
  const EzAppProvider({
    super.key,
    required this.app,
    this.initialPlatform,
    this.settings,
    this.scaffoldMessengerKey,
  });

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<EzThemeProvider>(
        create: (_) => EzThemeProvider(
          isLTR: ltrCheck(context),
          useCupertino: cupertinoCheck(),
        ),
        child: _ProviderSquared(
          app: app,
          initialPlatform: initialPlatform,
          settings: settings,
          scaffoldMessengerKey: scaffoldMessengerKey,
        ),
      );
}

class _ProviderSquared extends StatelessWidget {
  final Widget app;
  final TargetPlatform? initialPlatform;
  final PlatformSettingsData? settings;

  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  const _ProviderSquared({
    required this.app,
    required this.initialPlatform,
    required this.settings,
    required this.scaffoldMessengerKey,
  });

  @override
  Widget build(BuildContext context) {
    final EzThemeProvider config = Provider.of<EzThemeProvider>(context);
    EzConfig.setThemeProvider(config);

    return PlatformProvider(
      builder: (_) => PlatformTheme(
        builder: (_) => ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: app,
        ),
        themeMode: config.themeMode,
        materialDarkTheme: config.darkMaterial,
        materialLightTheme: config.lightMaterial,
        cupertinoDarkTheme: config.darkCupertino,
        cupertinoLightTheme: config.lightCupertino,
        matchCupertinoSystemChromeBrightness: true,
      ),
      initialPlatform: initialPlatform,
      settings: settings ??
          PlatformSettingsData(
            iosUsesMaterialWidgets: true,
            legacyIosUsesMaterialWidgets: true,
            iosUseZeroPaddingForAppbarPlatformIcon: true,
          ),
    );
  }
}
