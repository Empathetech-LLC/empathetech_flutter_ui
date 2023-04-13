library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

const String homeRoute = '/';

class EzApp extends PlatformProvider {
  final Key? key;
  final Key? widgetKey;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Widget? home;
  final String title;
  final Map<String, Widget Function(BuildContext)> routes;
  final String? initialRoute;
  final Route<dynamic>? Function(RouteSettings)? onGenerateRoute;
  final Route<dynamic>? Function(RouteSettings)? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final String Function(BuildContext)? onGenerateTitle;
  final Color? color;
  final Locale? locale;

  /// Default ->
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

  /// Default -> PlatformSettingsData(iosUsesMaterialWidgets: true)
  final PlatformSettingsData? settings;

  /// Quickly setup a [PlatformProvider] to pair with [EzConfig]
  /// Optionally overwrite all fields from [PlatformApp]
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
    this.localizationsDelegates,
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
          builder: (context) => PlatformApp(
            key: key,
            widgetKey: widgetKey,
            navigatorKey: navigatorKey,
            home: home,
            title: title,
            routes: routes,
            initialRoute: initialRoute,
            onGenerateRoute: onGenerateRoute,
            onUnknownRoute: onUnknownRoute,
            navigatorObservers: navigatorObservers,
            onGenerateTitle: onGenerateTitle,
            color: color,
            locale: locale,
            localizationsDelegates: localizationsDelegates ??
                <LocalizationsDelegate<dynamic>>[
                  DefaultMaterialLocalizations.delegate,
                  DefaultWidgetsLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate,
                ],
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
          settings: settings ?? PlatformSettingsData(iosUsesMaterialWidgets: true),
        );
}

/// Material (Android) [ThemeData] built from [EzConfig.prefs]
MaterialAppData materialAppTheme() {
  Color themeColor = Color(EzConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(EzConfig.prefs[themeTextColorKey]);
  Color buttonColor = Color(EzConfig.prefs[buttonColorKey]);
  Color buttonTextColor = Color(EzConfig.prefs[buttonTextColorKey]);

  TextStyle dialogTitleText = buildTextStyle(style: dialogTitleStyleKey);
  TextStyle dialogContentText = buildTextStyle(style: dialogContentStyleKey);

  return MaterialAppData(
    theme: ThemeData(
      primaryColor: themeColor,

      // App bar
      appBarTheme: AppBarTheme(
        backgroundColor: themeColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: themeTextColor),
        titleTextStyle: buildTextStyle(style: titleStyleKey),
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
        selectionColor: themeColor,
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
        valueIndicatorTextStyle: dialogContentText,
        overlayShape: SliderComponentShape.noOverlay,
      ),

      // Dialogs
      dialogTheme: DialogTheme(
        backgroundColor: themeColor,
        iconColor: themeTextColor,
        alignment: Alignment.center,
        titleTextStyle: dialogTitleText,
        contentTextStyle: dialogContentText,
      ),
    ),
  );
}

/// (iOS) [CupertinoAppData] data built [from] the passed in [MaterialAppData]
CupertinoAppData cupertinoAppTheme() {
  Color themeColor = Color(EzConfig.prefs[themeColorKey]);
  Color themeTextColor = Color(EzConfig.prefs[themeTextColorKey]);

  return CupertinoAppData(
    color: themeColor,
    theme: CupertinoThemeData(
      primaryColor: themeColor,
      primaryContrastingColor: themeTextColor,
      textTheme: cupertinoTextTheme(),
    ),
  );
}
