/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EzConfigurableApp extends StatelessWidget {
  /// LocaleNamesLocalizationsDelegate(), etc.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// Languages/locales the app supports
  final Iterable<Locale> supportedLocales;

  /// Initial locale
  /// Recommended to use [ezStoredL10n]
  final Locale locale;

  /// Initial EFUILang
  /// Recommended to use [ezStoredL10n]
  final EFUILang el10n;

  /// Sets [EzConfigProvider.appCache]
  final EzAppCache? appCache;

  /// App name (window title, etc.)
  final String appName;

  /// Router/page config
  final RouterConfig<Object>? routerConfig;

  /// [MaterialApp.router] wrapper with a [ChangeNotifierProvider] for live configuration
  const EzConfigurableApp({
    super.key,
    this.localizationsDelegates,
    required this.supportedLocales,
    required this.locale,
    required this.el10n,
    this.appCache,
    required this.appName,
    this.routerConfig,
  });

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<EzConfigProvider>(
        create: (_) => EzConfigProvider(
          locale: locale,
          el10n: el10n,
          isDark: isDarkTheme(context),
          appCache: appCache,
        ),
        child: _DevXLayer(
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          appName: appName,
          routerConfig: routerConfig,
        ),
      );
}

class _DevXLayer extends StatelessWidget {
  /// LocaleNamesLocalizationsDelegate(), etc.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// Languages/locales the app supports
  final Iterable<Locale> supportedLocales;

  /// App name (window title, etc.)
  final String appName;

  /// Router/page config
  final RouterConfig<Object>? routerConfig;

  /// A [Widget] layer that may seem redundant, but it makes developers lives a whole lot easier
  const _DevXLayer({
    required this.localizationsDelegates,
    required this.supportedLocales,
    required this.appName,
    required this.routerConfig,
  });

  @override
  Widget build(BuildContext context) {
    EzConfig.initProvider(Provider.of<EzConfigProvider>(context));

    return _AppDrawer(
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      appName: appName,
      routerConfig: routerConfig,
    );
  }
}

class _AppDrawer extends StatefulWidget {
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale> supportedLocales;
  final String appName;
  final RouterConfig<Object>? routerConfig;

  const _AppDrawer({
    required this.localizationsDelegates,
    required this.supportedLocales,
    required this.appName,
    required this.routerConfig,
  });

  @override
  State<_AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<_AppDrawer> with WidgetsBindingObserver {
  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    EzConfig.provider.setThemeMode();
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => Consumer<EzConfigProvider>(
        builder: (_, EzConfigProvider config, __) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: widget.localizationsDelegates,
          supportedLocales: widget.supportedLocales,
          locale: config.locale,
          title: widget.appName,
          themeMode: config.themeMode,
          darkTheme: config.darkTheme,
          theme: config.lightTheme,
          routerConfig: widget.routerConfig,
        ),
      );

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
