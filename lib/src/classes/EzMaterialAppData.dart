library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzMaterialAppData extends MaterialAppData {
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
  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final List<Route<dynamic>> Function(String)? onGenerateInitialRoutes;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final bool? useInheritedMediaQuery;

  /// Default: [ezThemeData] -> light: true
  final ThemeData? theme;
  final bool? debugShowMaterialGrid;

  /// Default: [ezThemeData] -> light: false
  final ThemeData? darkTheme;

  /// Default: [EzConfig.themeMode]
  final ThemeMode? themeMode;

  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final Curve themeAnimationCurve;
  final Duration themeAnimationDuration;

  /// [MaterialAppData] wrapper that uses handles switching between
  /// [ezThemeData] light && dark
  EzMaterialAppData({
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
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales,
    this.showPerformanceOverlay,
    this.checkerboardRasterCacheImages,
    this.checkerboardOffscreenLayers,
    this.showSemanticsDebugger,
    this.debugShowCheckedModeBanner,
    this.shortcuts,
    this.actions,
    this.onGenerateInitialRoutes,
    this.restorationScopeId,
    this.scrollBehavior,
    this.useInheritedMediaQuery,
    this.theme,
    this.debugShowMaterialGrid,
    this.darkTheme,
    this.themeMode,
    this.scaffoldMessengerKey,
    this.themeAnimationCurve = Curves.linear,
    this.themeAnimationDuration = kThemeAnimationDuration,
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
          theme: theme ?? ezThemeData(light: true),
          debugShowMaterialGrid: debugShowMaterialGrid,
          darkTheme: darkTheme ?? ezThemeData(light: false),
          themeMode: themeMode ?? EzConfig.themeMode,
          scaffoldMessengerKey: scaffoldMessengerKey,
          themeAnimationCurve: themeAnimationCurve,
          themeAnimationDuration: themeAnimationDuration,
        );
}
