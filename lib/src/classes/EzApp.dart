library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzApp extends PlatformApp {
  final Key? key;
  final Key? widgetKey;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Widget? home;
  final Map<String, Widget Function(BuildContext)>? routes;
  final String? initialRoute;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;
  final Route<dynamic>? Function(RouteSettings)? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final String? title;
  final String Function(BuildContext)? onGenerateTitle;
  final Color? color;
  final Locale? locale;

  /// Default:
  /// <LocalizationsDelegate<dynamic>>[
  ///   DefaultMaterialLocalizations.delegate,
  ///   DefaultWidgetsLocalizations.delegate,
  ///   DefaultCupertinoLocalizations.delegate,
  /// ],
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  final Locale? Function(List<Locale>?, Iterable<Locale>)? localeListResolutionCallback;
  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;
  final Iterable<Locale>? supportedLocales;
  final bool? showPerformanceOverlay;
  final bool? checkerboardRasterCacheImages;
  final bool? checkerboardOffscreenLayers;
  final bool? showSemanticsDebugger;

  /// Default: false
  final bool? debugShowCheckedModeBanner;

  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final List<Route<dynamic>> Function(String)? onGenerateInitialRoutes;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final bool? useInheritedMediaQuery;

  /// Default: [EzMaterialAppData]
  final MaterialAppData? materialData;

  /// Default: [EzCupertinoAppData]
  final CupertinoAppData? cupertinoData;

  /// Quickly setup a [PlatformApp] that uses [EzConfig] themes
  /// via [EzMaterialAppData] -> [EzThemeData]
  /// && [EzCupertinoAppData] -> [EzCupertinoThemeData]
  EzApp({
    this.key,
    this.widgetKey,
    this.navigatorKey,
    this.home,
    required this.title,
    required this.routes,
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers,
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates = const <LocalizationsDelegate<dynamic>>[
      DefaultMaterialLocalizations.delegate,
      DefaultWidgetsLocalizations.delegate,
      DefaultCupertinoLocalizations.delegate,
    ],
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales,
    this.showPerformanceOverlay,
    this.checkerboardRasterCacheImages,
    this.checkerboardOffscreenLayers,
    this.showSemanticsDebugger,
    this.debugShowCheckedModeBanner = false,
    this.shortcuts,
    this.actions,
    this.onGenerateInitialRoutes,
    this.restorationScopeId,
    this.scrollBehavior,
    this.useInheritedMediaQuery,
    this.materialData,
    this.cupertinoData,
  }) : super(
          key: key,
          widgetKey: widgetKey,
          navigatorKey: navigatorKey,
          home: home,
          routes: routes,
          initialRoute: initialRoute,
          onGenerateRoute: onGenerateRoute,
          onUnknownRoute: onUnknownRoute,
          navigatorObservers: navigatorObservers,
          title: title,
          onGenerateTitle: onGenerateTitle,
          color: color,
          locale: locale,
          localizationsDelegates: localizationsDelegates,
          localeListResolutionCallback: localeListResolutionCallback,
          localeResolutionCallback: localeResolutionCallback,
          supportedLocales: supportedLocales,
          showPerformanceOverlay: showPerformanceOverlay,
          checkerboardRasterCacheImages: checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: checkerboardOffscreenLayers,
          showSemanticsDebugger: showSemanticsDebugger,
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
          shortcuts: shortcuts,
          actions: actions,
          onGenerateInitialRoutes: onGenerateInitialRoutes,
          restorationScopeId: restorationScopeId,
          scrollBehavior: scrollBehavior,
          useInheritedMediaQuery: useInheritedMediaQuery,
          material: (context, platform) => materialData ?? EzMaterialAppData(),
          cupertino: (context, platform) => cupertinoData ?? EzCupertinoAppData(),
        );
}
