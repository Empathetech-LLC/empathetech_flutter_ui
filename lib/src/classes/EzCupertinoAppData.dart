library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzCupertinoAppData extends CupertinoAppData {
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
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final List<Route<dynamic>> Function(String)? onGenerateInitialRoutes;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Locale? Function(List<Locale>?, Iterable<Locale>)?
      localeListResolutionCallback;
  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;
  final Iterable<Locale>? supportedLocales;
  final bool? showPerformanceOverlay;
  final bool? checkerboardRasterCacheImages;
  final bool? checkerboardOffscreenLayers;
  final bool? showSemanticsDebugger;
  final bool? debugShowCheckedModeBanner;
  final ScrollBehavior? scrollBehavior;
  final bool? useInheritedMediaQuery;

  /// Default:
  /// ezCupertinoThemeData(
  ///   light: (EzConfig.themeMode == ThemeMode.light),
  /// )
  final CupertinoThemeData? theme;

  /// [CupertinoAppData] wrapper that uses [ezCupertinoThemeData] by default
  EzCupertinoAppData({
    this.widgetKey,
    this.navigatorKey,
    this.home,
    this.routes,
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers,
    this.title,
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.shortcuts,
    this.actions,
    this.onGenerateInitialRoutes,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales,
    this.showPerformanceOverlay,
    this.checkerboardRasterCacheImages,
    this.checkerboardOffscreenLayers,
    this.showSemanticsDebugger,
    this.debugShowCheckedModeBanner,
    this.scrollBehavior,
    this.useInheritedMediaQuery,
    this.theme,
  }) : super(
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
          shortcuts: shortcuts,
          actions: actions,
          onGenerateInitialRoutes: onGenerateInitialRoutes,
          localizationsDelegates: localizationsDelegates,
          localeListResolutionCallback: localeListResolutionCallback,
          localeResolutionCallback: localeResolutionCallback,
          supportedLocales: supportedLocales,
          showPerformanceOverlay: showPerformanceOverlay,
          checkerboardRasterCacheImages: checkerboardRasterCacheImages,
          checkerboardOffscreenLayers: checkerboardOffscreenLayers,
          showSemanticsDebugger: showSemanticsDebugger,
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
          scrollBehavior: scrollBehavior,
          useInheritedMediaQuery: useInheritedMediaQuery,
          theme: theme ??
              ezCupertinoThemeData(
                light: (EzConfig.themeMode == ThemeMode.light),
              ),
        );
}
