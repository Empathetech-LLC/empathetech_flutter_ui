/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../empathetech_flutter_ui.dart';

import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

class EzConfigProvider extends ChangeNotifier {
  // Construct //

  final TargetPlatform _platform;
  final bool _onMobile;
  int _seed;
  bool _needsRebuild;

  late Locale _locale;
  late EFUILang _l10n;
  bool _ltr;

  late ThemeMode _themeMode;
  late bool _isDark;

  late EzColorCache _color;
  late EzDesignCache _design;
  late EzLayoutCache _layout;
  late EzTextCache _text;

  final EzAppCache _appCache;

  late ThemeData _currTheme;
  late ThemeData _darkTheme;
  late ThemeData _lightTheme;

  EzConfigProvider({
    required Locale locale,
    required EFUILang el10n,
    required bool isDark,
    required EzAppCache appCache,
  })  : _platform = getBasePlatform(),
        _onMobile = isMobile(),
        _seed = Random().nextInt(rMax),
        _needsRebuild = false,
        _locale = locale,
        _l10n = el10n,
        _ltr = !rtlLanguageCodes.contains(locale.languageCode),
        _isDark = isDark,
        _appCache = appCache {
    _buildThemeMode();
    _buildThemeData();
    _appCache.init(isDark);
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
      _color = EzColorCache(EzConfig.get(darkColorSchemeImageKey));
      _design = EzDesignCache(
        padding: EzConfig.get(darkPaddingKey),
        buttonShape: EBSConfig.lookup(EzConfig.get(darkButtonShapeKey)),
        borderWidth: EzConfig.get(darkBorderWidthKey),
        buttonOpacity: EzConfig.get(darkButtonOpacityKey),
        borderOpacity: EzConfig.get(darkBorderOpacityKey),
        lineLinks: EzConfig.get(darkLineLinksKey),
        showBackFAB: EzConfig.get(darkShowBackFABKey),
        margin: EzConfig.get(darkMarginKey),
        spacing: EzConfig.get(darkSpacingKey),
        animDur: EzConfig.get(darkAnimationDurationKey),
        transitionType: ETTConfig.lookup(EzConfig.get(darkTransitionTypeKey)),
        fadedTransition: EzConfig.get(darkTransitionFadeKey),
        backgroundImagePath: EzConfig.get(darkBackgroundImageKey),
        backgroundImageFit: boxFitLookup[EzConfig.get(darkBackgroundImageKey + boxFitSuffix)],
        showScroll: EzConfig.get(darkShowScrollKey),
      );
      _layout = EzLayoutCache(
        margin: EzMargin(isDark: true),
        rowMargin: EzMargin(isDark: true, vertical: false),
        spacer: const EzSpacer(isDark: true),
        rowSpacer: const EzSpacer(isDark: true, vertical: false),
        separator: const EzSeparator(isDark: true),
        divider: const EzDivider(),
        startLine: const EzNewLine(textAlign: TextAlign.start),
        centerLine: const EzNewLine(),
        endLine: const EzNewLine(textAlign: TextAlign.end),
      );
      _text = EzTextCache(
        backgroundOpacity: EzConfig.get(darkTextBackgroundOpacityKey),
        iconSize: EzConfig.get(darkIconSizeKey),
      );

      // Update the curr theme pointer
      _currTheme = _darkTheme;
    } else {
      // Build new caches
      _color = EzColorCache(EzConfig.get(lightColorSchemeImageKey));
      _design = EzDesignCache(
        padding: EzConfig.get(lightPaddingKey),
        buttonShape: EBSConfig.lookup(EzConfig.get(lightButtonShapeKey)),
        borderWidth: EzConfig.get(lightBorderWidthKey),
        buttonOpacity: EzConfig.get(lightButtonOpacityKey),
        borderOpacity: EzConfig.get(lightBorderOpacityKey),
        lineLinks: EzConfig.get(lightLineLinksKey),
        showBackFAB: EzConfig.get(lightShowBackFABKey),
        margin: EzConfig.get(lightMarginKey),
        spacing: EzConfig.get(lightSpacingKey),
        animDur: EzConfig.get(lightAnimationDurationKey),
        transitionType: ETTConfig.lookup(EzConfig.get(lightTransitionTypeKey)),
        fadedTransition: EzConfig.get(lightTransitionFadeKey),
        backgroundImagePath: EzConfig.get(lightBackgroundImageKey),
        backgroundImageFit: boxFitLookup[EzConfig.get(lightBackgroundImageKey + boxFitSuffix)],
        showScroll: EzConfig.get(lightShowScrollKey),
      );
      _layout = EzLayoutCache(
        margin: EzMargin(isDark: false),
        rowMargin: EzMargin(isDark: false, vertical: false),
        spacer: const EzSpacer(isDark: false),
        rowSpacer: const EzSpacer(isDark: false, vertical: false),
        separator: const EzSeparator(isDark: false),
        divider: const EzDivider(),
        startLine: const EzNewLine(textAlign: TextAlign.start),
        centerLine: const EzNewLine(),
        endLine: const EzNewLine(textAlign: TextAlign.end),
      );
      _text = EzTextCache(
        backgroundOpacity: EzConfig.get(lightTextBackgroundOpacityKey),
        iconSize: EzConfig.get(lightIconSizeKey),
      );

      // Update the curr theme pointer
      _currTheme = _lightTheme;
    }
  }

  // Get //

  /// Current [TargetPlatform]
  TargetPlatform get platform => _platform;

  /// Whether the app is running on a mobile device
  bool get onMobile => _onMobile;

  /// Track [redrawUI] and [rebuildUI] (randomized on each call)
  int get seed => _seed;

  /// Toggleable bool for alerting the user to rebuild the UI
  /// Some settings would be too expensive to rebuild on every change, so they update locally and [pingRebuild]
  /// Example: [EzIconSizeSetting]
  bool get needsRebuild => _needsRebuild;

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

  /// Cache of frequently used color config values
  EzColorCache get color => _color;

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

  /// Set [needsRebuild] to [status]
  void pingRebuild(bool status) {
    if (_needsRebuild != status) {
      _needsRebuild = status;
      notifyListeners();
    }
  }

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
        if (WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark) {
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
    unawaited(ezRootNav.currentState!.push(
      // Open progress layer
      PageRouteBuilder<Widget>(
        opaque: false,
        transitionsBuilder: (_, __, ___, Widget child) => child,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => const Center(child: CircularProgressIndicator()),
      ),
    ));

    final ThemeMode newMode = _buildThemeMode();

    switch (newMode) {
      case ThemeMode.dark:
        _isDark = true;
        break;
      case ThemeMode.light:
        _isDark = false;
        break;
      case ThemeMode.system:
        WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark
            ? _isDark = true
            : _isDark = false;
        break;
    }
    _buildThemeData();

    _needsRebuild = false;
    await redrawUI(onComplete);

    // Close progress layer
    ezRootNav.currentState!.pop();
    ezCloseAll(); // redraw's version is "blocked" by the progress layer
  }

  /// Randomizes the [seed] and notifies listeners
  /// Optionally calls [onComplete] after notifying
  /// If unsure, we recommend [onComplete] to be setState((){})
  /// Or [doNothing] for [StatelessWidget]s
  Future<void> redrawUI(void Function() onComplete) async {
    _seed = Random().nextInt(rMax);
    await _appCache.rebuild();

    ezCloseAll();
    notifyListeners();
    onComplete.call();
  }

  /// Trigger [redrawUI] if/when the [ThemeMode] brightness changes
  /// Used in [EzConfigurableApp], not normally called manually
  /// For that reason, there is no passthrough for [redrawUI]
  Future<void> redrawTheme() async {
    final bool newIsDark =
        (WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);

    if (newIsDark != _isDark) {
      _isDark = newIsDark;
      _currTheme = newIsDark ? _darkTheme : _lightTheme;
      await redrawUI(doNothing);
    }
  }
}

// Build //

class EzColorCache {
  final String schemeImagePath;

  /// Theme aware tracker for frequently used color values...
  /// (dark|light)ColorSchemeImageKey
  EzColorCache(this.schemeImagePath);
}

class EzDesignCache {
  // Button //

  final double padding;

  final EzButtonShape buttonShape;
  final double borderWidth;
  final double buttonOpacity;
  final double borderOpacity;

  final bool lineLinks;
  final bool showBackFAB;

  // Page //

  final double margin;
  final double spacing;

  final int animDur;
  final EzTransitionType transitionType;
  final bool fadedTransition;

  final String backgroundImagePath;
  final BoxFit? backgroundImageFit;

  final bool showScroll;

  /// Theme aware tracker for frequently used design values...
  /// Animation duration
  EzDesignCache({
    required this.padding,
    required this.buttonShape,
    required this.borderWidth,
    required this.buttonOpacity,
    required this.borderOpacity,
    required this.lineLinks,
    required this.showBackFAB,
    required this.margin,
    required this.spacing,
    required this.animDur,
    required this.transitionType,
    required this.fadedTransition,
    required this.backgroundImagePath,
    required this.backgroundImageFit,
    required this.showScroll,
  });
}

class EzLayoutCache {
  final EzMargin margin;
  final EzMargin rowMargin;
  final EzSpacer spacer;
  final EzSpacer rowSpacer;
  final EzSeparator separator;
  final EzDivider divider;

  final EzNewLine startLine;
  final EzNewLine centerLine;
  final EzNewLine endLine;

  /// Theme aware tracker for frequently used layout [Widget]s
  EzLayoutCache({
    required this.margin,
    required this.rowMargin,
    required this.spacer,
    required this.rowSpacer,
    required this.separator,
    required this.divider,
    required this.startLine,
    required this.centerLine,
    required this.endLine,
  });
}

class EzTextCache {
  final double backgroundOpacity;
  final double iconSize;

  /// Theme aware tracker for frequently used text values...
  /// Icon size, frequently used [EzNewLine]s
  EzTextCache({
    required this.backgroundOpacity,
    required this.iconSize,
  });
}

abstract class EzAppCache {
  /// Will run on app setup
  void init(bool isDark);

  /// Will run on every call to [EzConfigProvider.redrawUI]
  /// AKA when [EzConfig.seed] changes
  Future<void> rebuild();
}
