/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EzConfigProvider extends ChangeNotifier {
  // Construct //

  final bool _cupertino;
  bool _ltr;

  int _seed;

  late Locale _locale;
  late EFUILang _l10n;

  late ThemeMode _themeMode;
  late EzLayoutWidgets _layout;

  late ThemeData _darkMaterial;
  late ThemeData _lightMaterial;

  late CupertinoThemeData? _darkCupertino;
  late CupertinoThemeData? _lightCupertino;

  EzConfigProvider({
    required bool useCupertino,
    required bool isLTR,
    required Locale localeFallback,
    required EFUILang l10nFallback,
  })  : _cupertino = useCupertino,
        _ltr = isLTR,
        _seed = Random().nextInt(rMax),
        _locale = localeFallback,
        _l10n = l10nFallback {
    _themeMode = _getMode;
    _buildTheme();
  }

  Future<EFUILang> _buildL10n() async {
    try {
      final Locale locale = getStoredLocale();
      final EFUILang toReturn = await EFUILang.delegate.load(locale);
      _locale = locale;
      return toReturn;
    } catch (_) {
      return EzConfig.l10nFallback;
    }
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

    _layout = EzLayoutWidgets(
      margin: EzMargin(),
      rowMargin: EzMargin(vertical: false),
      spacer: const EzSpacer(),
      rowSpacer: const EzSpacer(vertical: false),
      separator: const EzSeparator(),
      divider: const EzDivider(),
    );
  }

  // Get //

  bool get isCupertino => _cupertino;
  bool get isLTR => _ltr;

  int get seed => _seed;

  Locale get locale => _locale;
  EFUILang get l10n => _l10n;

  ThemeMode get _getMode {
    final bool? savedDark = EzConfig.get(isDarkThemeKey);

    return (savedDark == null)
        ? ThemeMode.system
        : (savedDark == true)
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  ThemeMode get themeMode => _themeMode;
  EzLayoutWidgets get layout => _layout;

  ThemeData get darkMaterial => _darkMaterial;
  ThemeData get lightMaterial => _lightMaterial;

  CupertinoThemeData? get darkCupertino => _darkCupertino;
  CupertinoThemeData? get lightCupertino => _lightCupertino;

  // Set //

  void redraw({void Function()? onComplete}) {
    _seed = Random().nextInt(rMax);
    notifyListeners();
    onComplete?.call();
  }

  void rebuild({void Function()? onComplete}) {
    _themeMode = _getMode;
    _buildTheme();
    redraw(onComplete: onComplete);
  }

  void setTextDirection(bool isLTR, {void Function()? onComplete}) {
    _ltr = isLTR;
    rebuild(onComplete: onComplete);
  }

  void setThemeMode({void Function()? onComplete}) {
    _themeMode = _getMode;
    redraw(onComplete: onComplete);
  }

  Future<void> setLocale({void Function()? onComplete}) async {
    _l10n = await _buildL10n();
    redraw(onComplete: onComplete);
  }
}

class EzLayoutWidgets {
  final EzMargin margin;
  final EzMargin rowMargin;
  final EzSpacer spacer;
  final EzSpacer rowSpacer;
  final EzSeparator separator;
  final EzDivider divider;

  EzLayoutWidgets({
    required this.margin,
    required this.rowMargin,
    required this.spacer,
    required this.rowSpacer,
    required this.separator,
    required this.divider,
  });
}
