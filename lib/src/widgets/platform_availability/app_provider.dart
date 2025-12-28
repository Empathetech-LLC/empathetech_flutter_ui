/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_transitions/go_transitions.dart';
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
          useCupertino: isApple(),
          localeFallback: EzConfig.localeFallback,
          l10nFallback: EzConfig.l10nFallback,
          isDark: isDarkTheme(context),
        ),
        child: Builder(
          builder: (BuildContext bContext) {
            EzConfig.initProvider(Provider.of<EzConfigProvider>(
              bContext,
              listen: false,
            ));

            return _ProviderSquared(
              initialPlatform: initialPlatform,
              settings: settings,
              app: app,
              scaffoldMessengerKey: scaffoldMessengerKey,
            );
          },
        ),
      );
}

class _ProviderSquared extends StatefulWidget {
  final TargetPlatform? initialPlatform;
  final PlatformSettingsData? settings;

  final Widget app;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  const _ProviderSquared({
    required this.initialPlatform,
    required this.settings,
    required this.app,
    required this.scaffoldMessengerKey,
  });

  @override
  State<_ProviderSquared> createState() => _ProviderSquaredState();
}

class _ProviderSquaredState extends State<_ProviderSquared>
    with WidgetsBindingObserver {
  // Init //

  @override
  void initState() {
    super.initState();

    GoTransition.defaultDuration =
        Duration(milliseconds: EzConfig.animDuration);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();

    EzConfig.provider.toggleTheme();
    GoTransition.defaultDuration =
        Duration(milliseconds: EzConfig.animDuration);
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
        themeMode: EzConfig.provider.themeMode,
        materialDarkTheme: EzConfig.provider.darkMaterial,
        materialLightTheme: EzConfig.provider.lightMaterial,
        cupertinoDarkTheme: EzConfig.provider.darkCupertino,
        cupertinoLightTheme: EzConfig.provider.lightCupertino,
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
