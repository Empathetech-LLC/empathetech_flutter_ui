/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzConfigProvider extends ChangeNotifier {
  // Construct //

  final TargetPlatform _platform;
  int _seed;

  late Locale _locale;
  late EFUILang _l10n;
  bool _ltr;

  late ThemeMode _themeMode;
  late bool _isDark;

  late EzDesignCache _design;
  late EzLayoutCache _layout;
  late EzTextCache _text;
  final EzAppCache? _appCache;

  late ThemeData _currTheme;
  late ThemeData _darkTheme;
  late ThemeData _lightTheme;

  EzConfigProvider({
    required Locale localeFallback,
    required EFUILang l10nFallback,
    required bool isLTR,
    required bool isDark,
    EzAppCache? appCache,
  })  : _platform = getBasePlatform(),
        _seed = Random().nextInt(rMax),
        _locale = localeFallback,
        _l10n = l10nFallback,
        _ltr = isLTR,
        _isDark = isDark,
        _appCache = appCache {
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

      _currTheme = _darkTheme;
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

      _currTheme = _lightTheme;
    }
  }

  // Get //

  /// Track [redraw] and [rebuild] (randomized on each call)
  int get seed => _seed;

  /// Current [TargetPlatform]
  TargetPlatform get platform => _platform;

  /// Current language for the app
  Locale get locale => _locale;

  /// EFUI localizations for the [locale]
  EFUILang get l10n => _l10n;

  /// Text direction for the [locale]
  bool get isLTR => _ltr;

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

  /// Cache for external values that should track [seed] changes
  /// Most helpful for external localizations, but the possibilities are endless!
  EzAppCache? get appCache => _appCache;

  /// Current, [ThemeMode] aware, [ThemeData]
  ThemeData get theme => _currTheme;

  /// Current [ThemeData] for [ThemeMode.dark]/[Brightness.dark]
  ThemeData get darkTheme => _darkTheme;

  /// Current [ThemeData] for [ThemeMode.light]/[Brightness.light]
  ThemeData get lightTheme => _lightTheme;

  // Set // TODO: check all calls to the functions here. they should be awaited now

  /// Randomizes the [seed] and notifies listeners
  /// Optionally calls [onComplete] after notifying
  /// HIGHLY recommended to wrap [Scaffold] Widgets in a [Consumer] for [EzConfigProvider]
  /// Simply set the [Scaffold.key] to an int [ValueKey] of the consumed [EzConfigProvider.seed] and all [EzConfig] updates will be live!
  Future<void> redraw({void Function()? onComplete}) async {
    _seed = Random().nextInt(rMax);
    if (_appCache != null) await _appCache.redraw();
    notifyListeners();
    onComplete?.call();
  }

  /// Rebuilds the apps [ThemeData] and updates the config caches
  /// Then calls [redraw] with [onComplete]
  /// HIGHLY recommended to wrap [Scaffold] Widgets in a [Consumer] for [EzConfigProvider]
  /// Simply set the [Scaffold.key] to an int [ValueKey] of the consumed [EzConfigProvider.seed] and all [EzConfig] updates will be live!
  Future<void> rebuild({void Function()? onComplete}) async {
    _buildMode();
    _buildTheme();
    await redraw(onComplete: onComplete);
  }

  /// Set the text direction for the app and [rebuild] with [onComplete]
  Future<void> setTextDirection(
    bool isLTR, {
    void Function()? onComplete,
  }) async {
    _ltr = isLTR;
    await rebuild(onComplete: onComplete);
  }

  /// Toggle between dark/light themes and [redraw] with [onComplete]
  Future<void> toggleTheme({void Function()? onComplete}) async {
    _isDark = !_isDark;
    _currTheme = _isDark ? _darkTheme : _lightTheme;
    await redraw(onComplete: onComplete);
  }

  /// Set the apps [ThemeMode] from storage and [redraw] with [onComplete]
  Future<void> buildThemeMode({void Function()? onComplete}) async {
    _buildMode();
    _currTheme = _isDark ? _darkTheme : _lightTheme;
    await redraw(onComplete: onComplete);
  }

  /// Set the apps [Locale] from storage and load corresponding localizations
  Future<void> buildLocale({void Function()? onComplete}) async {
    final Locale locale = ezStoredLocale();
    _locale = locale;

    try {
      final EFUILang localization = await EFUILang.delegate.load(locale);
      _l10n = localization;
    } catch (_) {
      _l10n = EzConfig.l10nFallback;
    }

    await redraw(onComplete: onComplete);
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

abstract class EzAppCache {
  /// Will run on any [EzConfig] redraw
  /// AKA when [EzConfig.seed] changes
  Future<void> redraw();
}
