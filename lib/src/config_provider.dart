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
  final bool _onMobile;
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
    required Locale locale,
    required EFUILang el10n,
    required bool isDark,
    EzAppCache? appCache,
  })  : _platform = getBasePlatform(),
        _onMobile = isMobile(),
        _seed = Random().nextInt(rMax),
        _locale = locale,
        _l10n = el10n,
        _ltr = !rtlLanguageCodes.contains(locale.languageCode),
        _isDark = isDark,
        _appCache = appCache {
    _buildThemeMode();
    _buildThemeData();
  }

  /// Gather and set [_themeMode] from storage
  ThemeMode _buildThemeMode() {
    final bool? savedDark = EzConfig.get(isDarkThemeKey);

    final ThemeMode newMode = (savedDark == null)
        ? ThemeMode.system
        : (savedDark == true)
            ? ThemeMode.dark
            : ThemeMode.light;

    _themeMode = newMode;
    return newMode;
  }

  /// Builds fresh themes and config caches
  void _buildThemeData() {
    // Build new themes
    _darkTheme = ezThemeData(Brightness.dark, _ltr);
    _lightTheme = ezThemeData(Brightness.light, _ltr);

    if (_isDark) {
      // Build new caches
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

      // Update the curr theme pointer
      _currTheme = _darkTheme;
    } else {
      // Ditto
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

  /// Track [redrawUI] and [rebuildUI] (randomized on each call)
  int get seed => _seed;

  /// Current [TargetPlatform]
  TargetPlatform get platform => _platform;

  /// Whether the app is running on a mobile device
  bool get onMobile => _onMobile;

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

  // Set //

  /// Set the apps [Locale] from storage and load corresponding localizations
  /// If unsure, we recommend [onComplete] to be setState((){})
  /// Or [doNothing] for [StatelessWidget]s
  Future<void> rebuildLocale(void Function() onComplete) async {
    final (Locale, EFUILang) result = await ezStoredL10n();
    _locale = result.$1;
    _l10n = result.$2;

    final bool newLTR = !rtlLanguageCodes.contains(_locale.languageCode);

    if (newLTR == _ltr) {
      await redrawUI(onComplete);
    } else {
      _ltr = newLTR;
      await rebuildUI(onComplete);
    }
  }

  /// Reconfigure [ThemeMode] et al. from storage and [redrawUI] with [onComplete]
  /// If unsure, we recommend [onComplete] to be setState((){})
  /// Or [doNothing] for [StatelessWidget]s
  Future<void> rebuildThemeMode(void Function() onComplete) async {
    final ThemeMode newMode = _buildThemeMode();

    switch (newMode) {
      case ThemeMode.dark:
        _isDark = true;
        _currTheme = _darkTheme;
        break;
      case ThemeMode.light:
        _isDark = false;
        _currTheme = _lightTheme;
        break;
      case ThemeMode.system:
        if (WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark) {
          _isDark = true;
          _currTheme = _darkTheme;
        } else {
          _isDark = false;
          _currTheme = _lightTheme;
        }
        break;
    }

    await redrawUI(onComplete);
  }

  /// Rebuilds the apps [ThemeMode], [ThemeData], and updates the config caches
  /// Then calls [redrawUI] with [onComplete]
  /// If unsure, we recommend [onComplete] to be setState((){})
  /// Or [doNothing] for [StatelessWidget]s
  Future<void> rebuildUI(void Function() onComplete) async {
    final ThemeMode newMode = _buildThemeMode();

    switch (newMode) {
      case ThemeMode.dark:
        _isDark = true;
        break;
      case ThemeMode.light:
        _isDark = false;
        break;
      case ThemeMode.system:
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark
            ? _isDark = true
            : _isDark = false;
        break;
    }
    _buildThemeData();

    await redrawUI(onComplete);
  }

  /// Randomizes the [seed] and notifies listeners
  /// Optionally calls [onComplete] after notifying
  /// If unsure, we recommend [onComplete] to be setState((){})
  /// Or [doNothing] for [StatelessWidget]s
  Future<void> redrawUI(void Function() onComplete) async {
    _seed = Random().nextInt(rMax);
    if (_appCache != null) await _appCache.rebuild();
    notifyListeners();
    onComplete.call();
  }

  /// Trigger [redrawUI] if/when the [ThemeMode] brightness changes
  /// Used in [EzConfigurableApp], not normally called manually
  /// For that reason, there is no passthrough for [redrawUI]
  Future<void> redrawTheme() async {
    final bool newIsDark =
        (WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark);

    if (newIsDark != _isDark) {
      _isDark = newIsDark;
      _currTheme = newIsDark ? _darkTheme : _lightTheme;
      await redrawUI(doNothing);
    }
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
  /// Both their [EzConfig] values and default [Widget]s
  /// ...and hideScroll
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
  /// Icon size
  EzTextCache({required this.iconSize});
}

abstract class EzAppCache {
  /// Will run on every call to [EzConfigProvider.redrawUI]
  /// AKA when [EzConfig.seed] changes
  Future<void> rebuild();
}
