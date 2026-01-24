/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzConfigProvider extends ChangeNotifier {
  // Construct //

  int _seed;
  bool _ltr;

  late Locale _locale;
  late EFUILang _l10n;

  late ThemeMode _themeMode;
  late bool _isDark;

  late EzDesignCache _design;
  late EzLayoutCache _layout;
  late EzTextCache _text;

  late ThemeData _darkTheme;
  late ThemeData _lightTheme;

  EzConfigProvider({
    required bool isLTR,
    required Locale localeFallback,
    required EFUILang l10nFallback,
    required bool isDark,
  })  : _seed = Random().nextInt(rMax),
        _ltr = isLTR,
        _locale = localeFallback,
        _l10n = l10nFallback,
        _isDark = isDark {
    _buildMode();
    _buildTheme();
  }

  void _buildMode() {
    final bool? savedDark = EzConfig.get(isDarkThemeKey);

    _themeMode = (savedDark == null)
        ? ThemeMode.system
        : (savedDark == true)
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  void _buildTheme() {
    _darkTheme = ezThemeData(Brightness.dark, _ltr);
    _lightTheme = ezThemeData(Brightness.light, _ltr);

    if (isDark) {
      _design = EzDesignCache(animDur: EzConfig.get(darkAnimationDurationKey));

      _layout = EzLayoutCache(
        marginVal: EzConfig.get(darkMarginKey),
        padding: EzConfig.get(darkPaddingKey),
        spacing: EzConfig.get(darkSpacingKey),
        margin: EzMargin(isDark: true),
        rowMargin: EzMargin(isDark: true, vertical: false),
        spacer: const EzSpacer(isDark: true),
        rowSpacer: const EzSpacer(isDark: true, vertical: false),
        separator: const EzSeparator(isDark: true),
        divider: const EzDivider(),
        hideScroll: EzConfig.get(darkHideScrollKey),
      );

      _text = EzTextCache(iconSize: EzConfig.get(darkIconSizeKey));
    } else {
      _design = EzDesignCache(animDur: EzConfig.get(lightAnimationDurationKey));

      _layout = EzLayoutCache(
        marginVal: EzConfig.get(lightMarginKey),
        padding: EzConfig.get(lightPaddingKey),
        spacing: EzConfig.get(lightSpacingKey),
        margin: EzMargin(isDark: false),
        rowMargin: EzMargin(isDark: false, vertical: false),
        spacer: const EzSpacer(isDark: false),
        rowSpacer: const EzSpacer(isDark: false, vertical: false),
        separator: const EzSeparator(isDark: false),
        divider: const EzDivider(),
        hideScroll: EzConfig.get(lightHideScrollKey),
      );

      _text = EzTextCache(iconSize: EzConfig.get(lightIconSizeKey));
    }
  }

  // Get //

  int get seed => _seed;
  bool get isLTR => _ltr;

  Locale get locale => _locale;
  EFUILang get l10n => _l10n;

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _isDark;

  EzDesignCache get design => _design;
  EzLayoutCache get layout => _layout;
  EzTextCache get text => _text;

  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;

  // Set //

  void redraw({void Function()? onComplete}) {
    _seed = Random().nextInt(rMax);
    notifyListeners();
    onComplete?.call();
  }

  void rebuild({void Function()? onComplete}) {
    _buildMode();
    _buildTheme();
    redraw(onComplete: onComplete);
  }

  void setTextDirection(bool isLTR, {void Function()? onComplete}) {
    _ltr = isLTR;
    rebuild(onComplete: onComplete);
  }

  void toggleTheme({void Function()? onComplete}) {
    _isDark = !_isDark;
    redraw(onComplete: onComplete);
  }

  void setThemeMode({void Function()? onComplete}) {
    _buildMode();
    redraw(onComplete: onComplete);
  }

  Future<void> setLocale({void Function()? onComplete}) async {
    try {
      final Locale locale = getStoredLocale();
      final EFUILang localization = await EFUILang.delegate.load(locale);

      _locale = locale;
      _l10n = localization;
    } catch (_) {
      _l10n = EzConfig.l10nFallback;
    }

    redraw(onComplete: onComplete);
  }
}

class EzDesignCache {
  final int animDur;

  EzDesignCache({required this.animDur});
}

class EzLayoutCache {
  final double marginVal;
  final double padding;
  final double spacing;

  final EzMargin margin;
  final EzMargin rowMargin;
  final EzSpacer spacer;
  final EzSpacer rowSpacer;
  final EzSeparator separator;
  final EzDivider divider;

  final bool hideScroll;

  EzLayoutCache({
    required this.marginVal,
    required this.padding,
    required this.spacing,
    required this.margin,
    required this.rowMargin,
    required this.spacer,
    required this.rowSpacer,
    required this.separator,
    required this.divider,
    required this.hideScroll,
  });
}

class EzTextCache {
  final double iconSize;

  EzTextCache({required this.iconSize});
}
