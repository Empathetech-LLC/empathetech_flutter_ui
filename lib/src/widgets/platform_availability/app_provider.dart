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
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<EzConfigProvider>(
        create: (_) => EzConfigProvider(
          isLTR: ltrCheck(context),
          useCupertino: cupertinoCheck(),
          localeFallback: EzConfig.localeFallback,
          l10nFallback: EzConfig.l10nFallback,
          isDark: isDarkTheme(context),
        ),
        child: _ProviderSquared(
          app: app,
          initialPlatform: initialPlatform,
          settings: settings,
          scaffoldMessengerKey: scaffoldMessengerKey,
        ),
      );
}

class _ProviderSquared extends StatefulWidget {
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
  State<_ProviderSquared> createState() => _ProviderSquaredState();
}

class _ProviderSquaredState extends State<_ProviderSquared>
    with WidgetsBindingObserver {
  late final EzConfigProvider config = Provider.of<EzConfigProvider>(context);

  // Init //

  @override
  void initState() {
    super.initState();
    EzConfig.initProvider(config);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    config.toggleTheme();
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder: (_) => PlatformTheme(
        builder: (_) => ScaffoldMessenger(
          key: widget.scaffoldMessengerKey,
          child: widget.app,
        ),
        themeMode: config.themeMode,
        materialDarkTheme: config.darkMaterial,
        materialLightTheme: config.lightMaterial,
        cupertinoDarkTheme: config.darkCupertino,
        cupertinoLightTheme: config.lightCupertino,
        matchCupertinoSystemChromeBrightness: true,
      ),
      initialPlatform: widget.initialPlatform,
      settings: widget.settings ??
          PlatformSettingsData(
            iosUsesMaterialWidgets: true,
            legacyIosUsesMaterialWidgets: true,
            iosUseZeroPaddingForAppbarPlatformIcon: true,
          ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
