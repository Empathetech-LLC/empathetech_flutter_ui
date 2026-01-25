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

  /// Gather and set [_themeMode] from storage
  void _buildMode() {
    final bool? savedDark = EzConfig.get(isDarkThemeKey);

    _themeMode = (savedDark == null)
        ? ThemeMode.system
        : (savedDark == true)
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  /// Builds fresh themes and config caches
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

  /// Track [redraw] and [rebuild] (randomized on each call)
  int get seed => _seed;

  /// Text direction for the [locale]
  bool get isLTR => _ltr;

  /// Current language for the app
  Locale get locale => _locale;

  /// EFUI localizations for the [locale]
  EFUILang get l10n => _l10n;

  /// Current [ThemeMode]
  ThemeMode get themeMode => _themeMode;

  /// Whether the current [themeMode] uses [Brightness.dark]
  bool get isDark => _isDark;

  /// Cache of frequently used design config values
  EzDesignCache get design => _design;

  /// Cache of frequently used layout config values
  EzLayoutCache get layout => _layout;

  /// Cache of frequently used text config values
  EzTextCache get text => _text;

  /// Current dark theme
  ThemeData get darkTheme => _darkTheme;

  /// Current light theme
  ThemeData get lightTheme => _lightTheme;

  // Set //

  /// Randomizes the [seed] and notifies listeners
  /// Optionally calls [onComplete] after notifying
  /// HIGHLY recommended to wrap [Scaffold] Widgets in a [Consumer] for [EzConfigProvider]
  /// Simply set the [Scaffold.key] to an int [ValueKey] of the consumed [EzConfigProvider.seed] and all [EzConfig] updates will be live!
  void redraw({void Function()? onComplete}) {
    _seed = Random().nextInt(rMax);
    notifyListeners();
    onComplete?.call();
  }

  /// Rebuilds the apps [ThemeData] and updates the config caches
  /// Then calls [redraw] with [onComplete]
  /// HIGHLY recommended to wrap [Scaffold] Widgets in a [Consumer] for [EzConfigProvider]
  /// Simply set the [Scaffold.key] to an int [ValueKey] of the consumed [EzConfigProvider.seed] and all [EzConfig] updates will be live!
  void rebuild({void Function()? onComplete}) {
    _buildMode();
    _buildTheme();
    redraw(onComplete: onComplete);
  }

  /// Set the text direction for the app and [rebuild] with [onComplete]
  void setTextDirection(bool isLTR, {void Function()? onComplete}) {
    _ltr = isLTR;
    rebuild(onComplete: onComplete);
  }

  /// Toggle between dark/light themes and [redraw] with [onComplete]
  void toggleTheme({void Function()? onComplete}) {
    _isDark = !_isDark;
    redraw(onComplete: onComplete);
  }

  /// Set the apps [ThemeMode] from storage and [redraw] with [onComplete]
  void buildThemeMode({void Function()? onComplete}) {
    _buildMode();
    redraw(onComplete: onComplete);
  }

  /// Set the apps [Locale] from storage and load corresponding localizations
  Future<void> buildLocale({void Function()? onComplete}) async {
    final Locale locale = getStoredLocale();
    _locale = locale;

    try {
      final EFUILang localization = await EFUILang.delegate.load(locale);
      _l10n = localization;
    } catch (_) {
      _l10n = EzConfig.l10nFallback;
    }

    redraw(onComplete: onComplete);
  }
}

class EzDesignCache {
  final int animDur;

  /// Theme aware tracker for frequently used design values...
  /// Animation duration
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

  /// Theme aware tracker for frequently used layout values...
  /// Margin, padding, and spacing
  /// Config values and default Widgets
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

  /// Theme aware tracker for frequently used text values...
  /// Margin, padding, and spacing
  /// Icon size
  EzTextCache({required this.iconSize});
}
