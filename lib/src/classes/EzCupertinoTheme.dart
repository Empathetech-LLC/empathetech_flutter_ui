library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzCupertinoTheme extends CupertinoAppData {
  EzCupertinoTheme({
    Key? widgetKey,
    GlobalKey<NavigatorState>? navigatorKey,
    Widget? home,
    Map<String, Widget Function(BuildContext)>? routes,
    String? initialRoute,
    Route<dynamic>? Function(RouteSettings)? onGenerateRoute,
    Route<dynamic>? Function(RouteSettings)? onUnknownRoute,
    List<NavigatorObserver>? navigatorObservers,
    String? title,
    String Function(BuildContext)? onGenerateTitle,
    Color? color,
    Locale? locale,
    Map<LogicalKeySet, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
    List<Route<dynamic>> Function(String)? onGenerateInitialRoutes,
    Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    Locale? Function(List<Locale>?, Iterable<Locale>)? localeListResolutionCallback,
    Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback,
    Iterable<Locale>? supportedLocales,
    bool? showPerformanceOverlay,
    bool? checkerboardRasterCacheImages,
    bool? checkerboardOffscreenLayers,
    bool? showSemanticsDebugger,
    bool? debugShowCheckedModeBanner,
    ScrollBehavior? scrollBehavior,
    bool? useInheritedMediaQuery,
    CupertinoThemeData? theme,
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
          theme: theme ?? _buildCupertinoThemeData(),
        );

  static CupertinoThemeData _buildCupertinoThemeData() {
    Color themeColor = Color(EzConfig.prefs[themeColorKey]);
    Color themeTextColor = Color(EzConfig.prefs[themeTextColorKey]);

    return CupertinoThemeData(
      primaryColor: themeColor,
      primaryContrastingColor: themeTextColor,
      textTheme: cupertinoTextTheme(),
    );
  }
}
