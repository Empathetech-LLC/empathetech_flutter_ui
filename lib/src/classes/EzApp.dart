library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzApp extends PlatformProvider {
  // PlatformProvider parameters //

  final TargetPlatform? initialPlatform;

  /// Default: PlatformSettingsData(iosUsesMaterialWidgets: true)
  final PlatformSettingsData? settings;

  final Key? providerKey;
  final Key? providerWidgetKey;

  // PlatformApp parameters //

  final Key? appKey;
  final Key? appWidgetKey;
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

  /// Default false
  final bool? debugShowCheckedModeBanner;

  final Map<LogicalKeySet, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final List<Route<dynamic>> Function(String)? onGenerateInitialRoutes;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  final bool? useInheritedMediaQuery;

  /// Default [materialAppTheme]
  final MaterialAppData Function(BuildContext, PlatformTarget)? material;

  /// Default [cupertinoAppTheme]
  final CupertinoAppData Function(BuildContext, PlatformTarget)? cupertino;

  /// Quickly setup a [PlatformProvider] to pair with [EzConfig]
  /// Optionally overwrite all fields from [PlatformApp]
  EzApp({
    this.appKey,
    this.appWidgetKey,
    this.initialPlatform,
    this.providerKey,
    this.providerWidgetKey,
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
    this.material,
    this.cupertino,
    this.settings,
  }) : super(
          key: providerKey,
          initialPlatform: initialPlatform,
          settings: settings ?? PlatformSettingsData(iosUsesMaterialWidgets: true),
          builder: (context) => PlatformApp(
            key: appKey,
            widgetKey: appWidgetKey,
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
            material: material ?? (context, platform) => materialAppTheme(),
            cupertino: cupertino ?? (context, platform) => cupertinoAppTheme(),
          ),
        );
}
