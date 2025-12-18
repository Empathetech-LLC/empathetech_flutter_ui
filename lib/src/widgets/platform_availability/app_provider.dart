/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/src/functions/helpers_io.dart';

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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

class EzThemeProvider extends ChangeNotifier {
  // Construct //

  bool _ltr;
  final bool _cupertino;
  late ThemeMode _initialMode;

  late ThemeData _darkMaterial;
  late ThemeData _lightMaterial;

  late CupertinoThemeData? _darkCupertino;
  late CupertinoThemeData? _lightCupertino;

  EzThemeProvider({required bool isLTR, required bool useCupertino})
      : _ltr = isLTR,
        _cupertino = useCupertino {
    final bool? savedDark = EzConfig.get(isDarkThemeKey);

    _initialMode = (savedDark == null)
        ? ThemeMode.system
        : (savedDark == true)
            ? ThemeMode.dark
            : ThemeMode.light;

    _darkMaterial = ezThemeData(Brightness.dark, isLTR);
    _lightMaterial = ezThemeData(Brightness.light, isLTR);

    if (useCupertino) {
      _darkCupertino =
          MaterialBasedCupertinoThemeData(materialTheme: _darkMaterial);
      _lightCupertino =
          MaterialBasedCupertinoThemeData(materialTheme: _lightMaterial);
    } else {
      _darkCupertino = null;
      _lightCupertino = null;
    }
  }

  // Get //

  bool get isLTR => _ltr;
  bool get isCupertino => _cupertino;
  ThemeMode get initialMode => _initialMode;

  ThemeData get darkMaterial => _darkMaterial;
  ThemeData get lightMaterial => _lightMaterial;

  CupertinoThemeData? get darkCupertino => _darkCupertino;
  CupertinoThemeData? get lightCupertino => _lightCupertino;

  // Set //

  void rebuildTheme({void Function()? onComplete}) {
    _darkMaterial = ezThemeData(Brightness.dark, _ltr);
    _lightMaterial = ezThemeData(Brightness.light, _ltr);

    if (_cupertino) {
      _darkCupertino =
          MaterialBasedCupertinoThemeData(materialTheme: _darkMaterial);
      _lightCupertino =
          MaterialBasedCupertinoThemeData(materialTheme: _lightMaterial);
    } else {
      _darkCupertino = null;
      _lightCupertino = null;
    }

    notifyListeners();
    onComplete?.call();
  }

  void setDirection(bool isLTR, {void Function()? onComplete}) {
    _ltr = isLTR;
    rebuildTheme(onComplete: onComplete);
  }
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

    return PlatformProvider(
      builder: (_) => PlatformTheme(
        builder: (_) => ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: app,
        ),
        themeMode: config.initialMode,
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
