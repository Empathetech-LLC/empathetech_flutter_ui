/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './export.dart';
import '../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Gather the theme data //

  late bool isDark = PlatformTheme.of(context)!.isDark;

  final double spacing = EzConfig.get(spacingKey);

  late final EzSpacer spacer = EzSpacer(spacing);
  late final EzSpacer separator = EzSpacer(2 * spacing);

  late final EFUILang l10n = EFUILang.of(context)!;

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(efuiL);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        decorationImageKey: isDark ? darkPageImageKey : lightPageImageKey,
        child: EzScrollView(
          children: <Widget>[
            // Functionality disclaimer
            EzWarning(
              body: kIsWeb ? l10n.ssSettingsGuideWeb : l10n.ssSettingsGuide,
            ),
            separator,

            // Global settings
            const EzDominantHandSwitch(),
            spacer,

            const EzThemeModeSwitch(),
            spacer,

            const EzLocaleSetting(),
            spacer,

            // Text settings
            ElevatedButton(
              onPressed: () => context.go(textSettingsRoute),
              child: Text(l10n.tsPageTitle),
            ),
            spacer,

            // Layout settings
            ElevatedButton(
              onPressed: () => context.go(layoutSettingsRoute),
              child: Text(l10n.lsPageTitle),
            ),
            spacer,

            // Color settings
            ElevatedButton(
              onPressed: () => context.go(colorSettingsRoute),
              child: Text(l10n.csPageTitle),
            ),
            spacer,

            // Image settings
            ElevatedButton(
              onPressed: () => context.go(imageSettingsRoute),
              child: Text(l10n.isPageTitle),
            ),
            separator,

            // Reset button
            const EzResetButton(),
            spacer,
          ],
        ),
      ),
    );
  }
}
