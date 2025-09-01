/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './models/export.dart';
import './screens/export.dart';
import './utils/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feedback/feedback.dart';
import 'package:go_router/go_router.dart';
import 'package:go_transitions/go_transitions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() async {
  // Setup the app //

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

  // Initialize EzConfig //

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  EzConfig.init(
    preferences: prefs,
    defaults: isMobile() ? mobileEmpathConfig : desktopEmpathConfig,
    fallbackLang: await EFUILang.delegate.load(americanEnglish),
    assetPaths: <String>{},
  );

  // Run the app //
  // With a feedback wrapper

  runApp(BetterFeedback(
    theme: empathFeedbackLight,
    darkTheme: empathFeedbackDark,
    themeMode: EzConfig.getThemeMode(),
    localizationsDelegates: <LocalizationsDelegate<dynamic>>[EzFeedbackLD()],
    localeOverride: EzConfig.getLocale(),
    child: const OpenUI(),
  ));
}

class OpenUI extends StatelessWidget {
  const OpenUI({super.key});

  @override
  Widget build(BuildContext context) {
    GoTransition.defaultCurve = Curves.easeInOut;
    GoTransition.defaultDuration =
        Duration(milliseconds: EzConfig.get(animationDurationKey));

    return EzAppProvider(
      app: PlatformApp.router(
        debugShowCheckedModeBanner: false,

        // Language handlers
        localizationsDelegates: <LocalizationsDelegate<dynamic>>{
          const LocaleNamesLocalizationsDelegate(),
          ...EFUILang.localizationsDelegates,
          ...Lang.localizationsDelegates,
        },

        // Supported languages
        supportedLocales: Lang.supportedLocales,

        // Current language
        locale: EzConfig.getLocale(),

        // App title
        title: appTitle,

        // Router (page) config
        routerConfig: GoRouter(
          initialLocation: homePath,
          errorBuilder: (_, GoRouterState state) => ErrorScreen(state.error),
          routes: <RouteBase>[
            GoRoute(
              path: homePath,
              name: homePath,
              builder: (_, __) => const HomeScreen(),
              pageBuilder: ezGoTransition,
              routes: <RouteBase>[
                GoRoute(
                  path: generateScreenPath,
                  name: generateScreenPath,
                  builder: (_, GoRouterState state) {
                    final EAGConfig config = state.extra as EAGConfig;
                    return GenerateScreen(config: config);
                  },
                  pageBuilder: ezGoTransition,
                ),
                GoRoute(
                  path: archiveScreenPath,
                  name: archiveScreenPath,
                  builder: (_, GoRouterState state) {
                    final EAGConfig config = state.extra as EAGConfig;
                    return ArchiveScreen(config: config);
                  },
                  pageBuilder: ezGoTransition,
                ),
                GoRoute(
                  path: settingsHomePath,
                  name: settingsHomePath,
                  builder: (_, __) => const SettingsHomeScreen(),
                  pageBuilder: ezGoTransition,
                  routes: <RouteBase>[
                    GoRoute(
                      path: colorSettingsPath,
                      name: colorSettingsPath,
                      builder: (_, __) => const ColorSettingsScreen(),
                      pageBuilder: ezGoTransition,
                      routes: <RouteBase>[
                        GoRoute(
                          path: EzCSType.quick.path,
                          name: EzCSType.quick.name,
                          builder: (_, __) =>
                              const ColorSettingsScreen(target: EzCSType.quick),
                          pageBuilder: ezGoTransition,
                        ),
                        GoRoute(
                          path: EzCSType.advanced.path,
                          name: EzCSType.advanced.name,
                          builder: (_, __) => const ColorSettingsScreen(
                              target: EzCSType.advanced),
                          pageBuilder: ezGoTransition,
                        ),
                      ],
                    ),
                    GoRoute(
                      path: designSettingsPath,
                      name: designSettingsPath,
                      builder: (_, __) => const DesignSettingsScreen(),
                      pageBuilder: ezGoTransition,
                    ),
                    GoRoute(
                      path: layoutSettingsPath,
                      name: layoutSettingsPath,
                      builder: (_, __) => const LayoutSettingsScreen(),
                      pageBuilder: ezGoTransition,
                    ),
                    GoRoute(
                      path: textSettingsPath,
                      name: textSettingsPath,
                      builder: (_, __) => const TextSettingsScreen(),
                      pageBuilder: ezGoTransition,
                      routes: <RouteBase>[
                        GoRoute(
                          path: EzTSType.quick.path,
                          name: EzTSType.quick.name,
                          builder: (_, __) =>
                              const TextSettingsScreen(target: EzTSType.quick),
                          pageBuilder: ezGoTransition,
                        ),
                        GoRoute(
                          path: EzTSType.advanced.path,
                          name: EzTSType.advanced.name,
                          builder: (_, __) => const TextSettingsScreen(
                              target: EzTSType.advanced),
                          pageBuilder: ezGoTransition,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
