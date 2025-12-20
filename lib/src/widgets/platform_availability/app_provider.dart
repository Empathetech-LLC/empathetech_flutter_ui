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

  final bool _cupertino;
  bool _ltr;
  late ThemeMode _themeMode;

  late ThemeData _darkMaterial;
  late ThemeData _lightMaterial;

  late CupertinoThemeData? _darkCupertino;
  late CupertinoThemeData? _lightCupertino;

  late EzSpacer _spacer;
  late EzSeparator _separator;
  late EzDivider _divider;

  EzThemeProvider({required bool useCupertino, required bool isLTR})
      : _cupertino = useCupertino,
        _ltr = isLTR {
    _themeMode = _getMode;
    _buildTheme();
  }

  void _buildTheme() {
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

    _spacer = const EzSpacer();
    _separator = const EzSeparator();
    _divider = const EzDivider();
  }

  // Get //

  ThemeMode get _getMode {
    final bool? savedDark = EzConfig.get(isDarkThemeKey);

    return (savedDark == null)
        ? ThemeMode.system
        : (savedDark == true)
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  bool get isCupertino => _cupertino;
  bool get isLTR => _ltr;
  ThemeMode get themeMode => _themeMode;

  ThemeData get darkMaterial => _darkMaterial;
  ThemeData get lightMaterial => _lightMaterial;

  CupertinoThemeData? get darkCupertino => _darkCupertino;
  CupertinoThemeData? get lightCupertino => _lightCupertino;

  EzSpacer get spacer => _spacer;
  EzSeparator get separator => _separator;
  EzDivider get divider => _divider;

  // Set //

  void setTextDirection(bool isLTR, {void Function()? onComplete}) {
    _ltr = isLTR;
    rebuild(onComplete: onComplete);
  }

  void setThemeMode({void Function()? onComplete}) {
    _themeMode = _getMode;
    notifyListeners();
    onComplete?.call();
  }

  void rebuild({void Function()? onComplete}) {
    _themeMode = _getMode;
    _buildTheme();
    notifyListeners();
    onComplete?.call();
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
