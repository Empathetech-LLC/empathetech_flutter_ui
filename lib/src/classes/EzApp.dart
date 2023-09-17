/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzApp extends PlatformApp {
  final Key? key;
  final Key? widgetKey;

  /// App title
  final String title;

  /// Optionally paint a debug banner on all screens
  final bool? debugShowCheckedModeBanner;

  /// Starting screen for mobile and desktop apps
  /// Provide [routerConfig] OR [homeScreenWidget]
  final Widget? homeScreenWidget;

  /// [GoRouter] config for apps with a web deployment
  /// Provide [routerConfig] OR [homeScreenWidget]
  final GoRouter? routerConfig;

  /// Used for internationalizing your app
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// Used for internationalizing your app
  final Locale? locale;

  /// Used for internationalizing your app
  final LocaleListResolutionCallback? localeListResolutionCallback;

  /// Used for internationalizing your app
  final LocaleResolutionCallback? localeResolutionCallback;

  /// Used for internationalizing your app
  final Iterable<Locale>? supportedLocales;

  final bool? showPerformanceOverlay;
  final bool? checkerboardRasterCacheImages;
  final bool? checkerboardOffscreenLayers;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;

  /// [PlatformApp] wrapper with some recommended defaults
  /// Automatically returns a [PlatformApp.router] when [routerConfig] is provided
  /// [routerConfig] enable deep linking (ideal for web apss)
  /// Otherwise, provide a [homeScreenWidget]
  /// Pair with [EzAppProvider] to enable [EzConfig] theming!
  EzApp({
    this.key,
    this.widgetKey,
    required this.title,
    this.debugShowCheckedModeBanner = false,
    this.homeScreenWidget,
    this.routerConfig,
    this.localizationsDelegates,
    this.locale,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales,
    this.showPerformanceOverlay,
    this.checkerboardRasterCacheImages,
    this.checkerboardOffscreenLayers,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
  }) : assert(routerConfig != null || homeScreenWidget != null);

  @override
  Widget build(BuildContext context) {
    // Use default localizations if none were provided
    final localizations = localizationsDelegates == null
        ? <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ]
        : localizationsDelegates;

    return (routerConfig == null)
        ? PlatformApp(
            key: key,
            widgetKey: widgetKey,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner,
            title: title,
            home: homeScreenWidget,
            localizationsDelegates: localizations,
            locale: locale,
            localeListResolutionCallback: localeListResolutionCallback,
            localeResolutionCallback: localeResolutionCallback,
            supportedLocales: supportedLocales,
            showPerformanceOverlay: showPerformanceOverlay,
            checkerboardRasterCacheImages: checkerboardRasterCacheImages,
            checkerboardOffscreenLayers: checkerboardOffscreenLayers,
            shortcuts: shortcuts,
            actions: actions,
            restorationScopeId: restorationScopeId,
          )
        : PlatformApp.router(
            key: key,
            widgetKey: widgetKey,
            debugShowCheckedModeBanner: debugShowCheckedModeBanner,
            title: title,
            routerConfig: routerConfig,
            localizationsDelegates: localizations,
            locale: locale,
            localeListResolutionCallback: localeListResolutionCallback,
            localeResolutionCallback: localeResolutionCallback,
            supportedLocales: supportedLocales,
            showPerformanceOverlay: showPerformanceOverlay,
            checkerboardRasterCacheImages: checkerboardRasterCacheImages,
            checkerboardOffscreenLayers: checkerboardOffscreenLayers,
            shortcuts: shortcuts,
            actions: actions,
            restorationScopeId: restorationScopeId,
          );
  }
}
