import './screens.dart';
import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
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
              titleStyle: getTitle(context),
              bodyStyle: getBody(context),
              body: kIsWeb
                  ? EFUILang.of(context)!.ssSettingsGuideWeb
                  : EFUILang.of(context)!.ssSettingsGuide,
            ),
            separator,

            // Global settings
            const EzDominantHandSwitch(),
            spacer,

            const EzThemeModeSwitch(),
            separator,

            const EzLocaleSetting(),
            spacer,

            // Text settings
            ElevatedButton(
              onPressed: () => context.goNamed(textSettingsRoute),
              child: Text(EFUILang.of(context)!.tsPageTitle),
            ),
            spacer,

            // Image settings
            ElevatedButton(
              onPressed: () => context.goNamed(imageSettingsRoute),
              child: Text(EFUILang.of(context)!.isPageTitle),
            ),
            spacer,

            // Color settings
            ElevatedButton(
              onPressed: () => context.goNamed(colorSettingsRoute),
              child: Text(EFUILang.of(context)!.csPageTitle),
            ),
            spacer,

            // Layout settings
            ElevatedButton(
              onPressed: () => context.goNamed(layoutSettingsRoute),
              child: Text(EFUILang.of(context)!.lsPageTitle),
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
