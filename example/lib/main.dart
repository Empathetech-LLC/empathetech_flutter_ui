import 'screens/screens.dart';
import 'utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feedback/feedback.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() async {
  // Most apps need this
  // https://stackoverflow.com/questions/63873338/
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EzConfig //

  // Get a SharedPreferences instance to... share
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Make it so
  EzConfig.init(
    // Paths to any locally stored images the app uses
    assetPaths: <String>{},

    preferences: prefs,

    // Your brand colors, custom styling, etc
    defaults: empathetechConfig,
  );

  // Set device orientation(s)
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  late final TextStyle lightFeedbackText = buildBody(color: Colors.black);
  late final TextStyle darkFeedbackText = buildBody(color: Colors.white);

  // Run the app!
  runApp(BetterFeedback(
    theme: FeedbackThemeData(
      background: Colors.grey,
      feedbackSheetColor: Colors.white,
      activeFeedbackModeColor: empathPurple,
      bottomSheetDescriptionStyle: lightFeedbackText,
      bottomSheetTextInputStyle: lightFeedbackText,
      sheetIsDraggable: true,
      dragHandleColor: Colors.grey,
      colorScheme: const ColorScheme.light(primary: empathGoldenrod),
    ),
    darkTheme: FeedbackThemeData(
      background: Colors.grey,
      feedbackSheetColor: Colors.black,
      activeFeedbackModeColor: empathEucalyptus,
      bottomSheetDescriptionStyle: darkFeedbackText,
      bottomSheetTextInputStyle: darkFeedbackText,
      sheetIsDraggable: true,
      dragHandleColor: Colors.grey,
      colorScheme: const ColorScheme.dark(primary: empathGoldenrod),
    ),
    themeMode: EzConfig.getThemeMode(),
    localizationsDelegates: <LocalizationsDelegate<dynamic>>[
      const LocaleNamesLocalizationsDelegate(),
      ...EFUILang.localizationsDelegates,
      OpenUIFeedbackLocalizationsDelegate(),
    ],
    localeOverride: EzConfig.getLocale(),
    child: const OpenUI(),
  ));
}

/// Initialize a path based router for web-enabled apps
/// Or any other app that requires deep linking
/// https://docs.flutter.dev/ui/navigation/deep-linking
final GoRouter router = GoRouter(
  initialLocation: homePath,
  routes: <RouteBase>[
    GoRoute(
      path: homePath,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: textSettingsPath,
          builder: (BuildContext context, GoRouterState state) {
            return const TextSettingsScreen();
          },
        ),
        GoRoute(
          path: layoutSettingsPath,
          builder: (BuildContext context, GoRouterState state) {
            return const LayoutSettingsScreen();
          },
        ),
        GoRoute(
          path: colorSettingsPath,
          builder: (BuildContext context, GoRouterState state) {
            return const ColorSettingsScreen();
          },
        ),
        GoRoute(
          path: imageSettingsPath,
          builder: (BuildContext context, GoRouterState state) {
            return const ImageSettingsScreen();
          },
        ),
      ],
    ),
  ],
);

class OpenUI extends StatelessWidget {
  const OpenUI({super.key});

  @override
  Widget build(BuildContext context) {
    return EzAppProvider(
      app: PlatformApp.router(
        // Production ready!
        debugShowCheckedModeBanner: false,

        // Language handlers
        localizationsDelegates: <LocalizationsDelegate<dynamic>>{
          const LocaleNamesLocalizationsDelegate(),
          ...EFUILang.localizationsDelegates,
          OpenUIFeedbackLocalizationsDelegate(),
        },

        // Supported languages
        supportedLocales: EFUILang.supportedLocales,

        // Current language
        locale: EzConfig.getLocale(),

        title: appTitle,
        routerConfig: router,
      ),
    );
  }
}
