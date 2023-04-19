library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzMaterialTheme extends MaterialAppData {
  EzMaterialTheme({
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
    Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    Locale? Function(List<Locale>?, Iterable<Locale>)? localeListResolutionCallback,
    Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback,
    Iterable<Locale>? supportedLocales,
    bool? showPerformanceOverlay,
    bool? checkerboardRasterCacheImages,
    bool? checkerboardOffscreenLayers,
    bool? showSemanticsDebugger,
    bool? debugShowCheckedModeBanner,
    Map<LogicalKeySet, Intent>? shortcuts,
    Map<Type, Action<Intent>>? actions,
    List<Route<dynamic>> Function(String)? onGenerateInitialRoutes,
    String? restorationScopeId,
    ScrollBehavior? scrollBehavior,
    bool? useInheritedMediaQuery,
    ThemeData? theme,
    bool? debugShowMaterialGrid,
    ThemeData? darkTheme,
    ThemeMode? themeMode,
    GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
    Curve themeAnimationCurve = Curves.linear,
    Duration themeAnimationDuration = kThemeAnimationDuration,
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
          theme: theme ?? _buildThemeData(),
          debugShowMaterialGrid: debugShowMaterialGrid,
          darkTheme: darkTheme,
          themeMode: themeMode,
          scaffoldMessengerKey: scaffoldMessengerKey,
          themeAnimationCurve: themeAnimationCurve,
          themeAnimationDuration: themeAnimationDuration,
        );

  static ThemeData _buildThemeData() {
    Color themeColor = Color(EzConfig.prefs[themeColorKey]);
    Color themeTextColor = Color(EzConfig.prefs[themeTextColorKey]);
    Color buttonColor = Color(EzConfig.prefs[buttonColorKey]);
    Color buttonTextColor = Color(EzConfig.prefs[buttonTextColorKey]);

    return ThemeData(
      primaryColor: themeColor,

      // App bar
      appBarTheme: AppBarTheme(
        backgroundColor: themeColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: themeTextColor),
      ),

      // Nav bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: themeColor,
        selectedItemColor: buttonColor,
        selectedIconTheme: IconThemeData(color: buttonColor),
        unselectedItemColor: themeTextColor,
        unselectedIconTheme: IconThemeData(color: themeTextColor),
      ),

      // Text
      textTheme: materialTextTheme(),
      primaryTextTheme: materialTextTheme(),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: themeTextColor,
        selectionColor: buttonColor.withOpacity(0.5),
        selectionHandleColor: buttonColor,
      ),
      hintColor: themeTextColor,

      // Icons
      iconTheme: IconThemeData(color: themeTextColor),

      // Sliders
      sliderTheme: SliderThemeData(
        thumbColor: buttonColor,
        disabledThumbColor: themeColor,
        overlayColor: buttonColor,
        activeTrackColor: buttonColor,
        activeTickMarkColor: buttonTextColor,
        inactiveTrackColor: themeColor,
        inactiveTickMarkColor: themeTextColor,
        overlayShape: SliderComponentShape.noOverlay,
      ),

      // Dialogs
      dialogTheme: DialogTheme(
        backgroundColor: themeColor,
        iconColor: themeTextColor,
        alignment: Alignment.center,
      ),
    );
  }
}
