/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './export.dart';
import '../utils/export.dart';
import '../widgets/export.dart';

import 'package:http/http.dart' as http;
import 'package:updat/updat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Gather the theme data //

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define build data //

  late final TargetPlatform platform = getBasePlatform(context);
  late final bool isDesktop = (platform == TargetPlatform.linux) ||
      (platform == TargetPlatform.macOS) ||
      (platform == TargetPlatform.windows);

  static const String appVersionLink =
      'https://raw.githubusercontent.com/Empathetech-LLC/empathetech_flutter_ui/refs/heads/main/example/APP_VERSION';
  static const String downloadPrefix =
      'https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases/download';

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(efuiL, Theme.of(context).colorScheme.primary);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return OpenUIScaffold(
      body: EzScreen(
        child: EzScrollView(
          children: <Widget>[
            // Functionality disclaimer
            EzWarning(
              header: isDesktop
                  ? UpdatWidget(
                      currentVersion: appVersion,
                      getLatestVersion: () async {
                        final http.Response response =
                            await http.get(Uri.parse(appVersionLink));

                        return (response.statusCode == 200)
                            ? response.body
                            : null;
                      },
                      getBinaryUrl: (String? version) async {
                        String ver = version ?? '';

                        if (ver.isEmpty) {
                          final http.Response response =
                              await http.get(Uri.parse(appVersionLink));

                          ver = (response.statusCode == 200)
                              ? response.body
                              : appVersion;
                        }

                        switch (platform) {
                          case TargetPlatform.linux:
                            return '$downloadPrefix/$ver/open-ui-linux.deb';
                          case TargetPlatform.macOS:
                            return '$downloadPrefix/$ver/open-ui-mac.zip';
                          case TargetPlatform.windows:
                            return '$downloadPrefix/$ver/open-ui-windows.exe';
                          default:
                            ezLog(
                                'Something went wrong...\n$platform provided to UpdatWidget');
                            return '';
                        }
                      },
                      appName: appTitle,
                      openOnDownload: platform == TargetPlatform.windows,
                      closeOnInstall: platform == TargetPlatform.windows,
                    )
                  : null,
              body: kIsWeb ? l10n.ssSettingsGuideWeb : l10n.ssSettingsGuide,
            ),
            separator,

            // Global settings
            const EzDominantHandSwitch(),
            spacer,

            const EzThemeModeSwitch(),
            spacer,

            const EzLocaleSetting(),
            separator,

            // Text settings
            EzElevatedIconButton(
              onPressed: () => context.goNamed(textSettingsPath),
              icon: const Icon(Icons.navigate_next),
              label: l10n.tsPageTitle,
            ),
            spacer,

            // Layout settings
            EzElevatedIconButton(
              onPressed: () => context.goNamed(layoutSettingsPath),
              icon: const Icon(Icons.navigate_next),
              label: l10n.lsPageTitle,
            ),
            spacer,

            // Color settings
            EzElevatedIconButton(
              onPressed: () => context.goNamed(colorSettingsPath),
              icon: const Icon(Icons.navigate_next),
              label: l10n.csPageTitle,
            ),
            spacer,

            // Image settings
            EzElevatedIconButton(
              onPressed: () => context.goNamed(imageSettingsPath),
              icon: const Icon(Icons.navigate_next),
              label: l10n.isPageTitle,
            ),
            separator,

            // Feeling lucky
            const EzConfigRandomizer(),
            separator,

            // Reset button
            const EzResetButton(),
            separator,
          ],
        ),
      ),
    );
  }
}
