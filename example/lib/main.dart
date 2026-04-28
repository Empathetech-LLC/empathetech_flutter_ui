/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './screens/export.dart';
import './utils/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

void main() async {
  // Configure the app //

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

  EzConfig.init(
    assetPaths: <String>{},
    defaults: isMobile() ? empathMobileConfig : empathDesktopConfig,
    localeFallback: americanEnglish,
    l10nFallback: await EFUILang.delegate.load(americanEnglish),
    preferences: await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(
        allowList: allEZConfigKeys.keys.toSet(),
      ),
    ),
  );

  if (!kIsWeb && !isMobile()) {
    await windowManager.ensureInitialized();

    await windowManager.waitUntilReadyToShow(
      const WindowOptions(minimumSize: Size(500, 500)),
      () async {
        await windowManager.show();
        await windowManager.focus();
      },
    );
  }

  // Run the app //

  final (Locale storedLocale, EFUILang storedEFUILang) = await ezStoredL10n();

  runApp(OpenUI(
    storedLocale,
    storedEFUILang,
    await Lang.delegate.load(storedLocale),
  ));
}

class OpenUI extends StatelessWidget {
  final Locale storedLocale;
  final EFUILang storedEFUILang;
  final Lang storedLang;

  const OpenUI(
    this.storedLocale,
    this.storedEFUILang,
    this.storedLang, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EzConfigurableApp(
      localizationsDelegates: <LocalizationsDelegate<dynamic>>{
        const LocaleNamesLocalizationsDelegate(),
        ...EFUILang.localizationsDelegates,
        ...Lang.localizationsDelegates,
      },
      supportedLocales: Lang.supportedLocales,
      locale: storedLocale,
      el10n: storedEFUILang,
      appCache: OpenUICache(storedLocale, storedLang),
      appName: appName,
      routerConfig: GoRouter(
        navigatorKey: ezRootNav,
        initialLocation: homePath,
        errorBuilder: (_, GoRouterState state) => ErrorScreen(state.error),
        routes: <RouteBase>[
          // Home
          GoRoute(
            path: homePath,
            name: homePath,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                ezPageBuilder(context, state, HomeScreen()),
            routes: <RouteBase>[
              // Archive
              GoRoute(
                path: archiveScreenPath,
                name: archiveScreenPath,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    ezPageBuilder(context, state, ArchiveScreen((state.extra as EAGConfig))),
              ),

              // Generate
              GoRoute(
                path: generateScreenPath,
                name: generateScreenPath,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    ezPageBuilder(context, state, GenerateScreen((state.extra as EAGConfig))),
              ),

              // Settings
              GoRoute(
                path: settingsHubPath,
                name: settingsHubPath,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    ezPageBuilder(context, state, SettingsHubScreen()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
