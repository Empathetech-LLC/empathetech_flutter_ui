import './screens.dart';
import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Gather the theme data //

  late bool isLight = !PlatformTheme.of(context)!.isDark;

  final double buttonSpace = EzConfig.get(buttonSpacingKey);

  late final EzSpacer _buttonSpacer = EzSpacer(buttonSpace);
  late final EzSpacer _buttonSeparator = EzSpacer(2 * buttonSpace);

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(efui);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        decorationImageKey: isLight ? lightPageImageKey : darkPageImageKey,
        child: EzScrollView(
          children: [
            // Functionality disclaimer
            EzWarning(
              message: kIsWeb
                  ? EFUILang.of(context)!.ssSettingsGuideWeb
                  : EFUILang.of(context)!.ssSettingsGuide,
              style: getTitle(context),
            ),
            _buttonSeparator,

            // Global settings
            const EzDominantHandSwitch(),
            _buttonSpacer,

            const EzThemeModeSwitch(),
            _buttonSeparator,

            const EzLocaleSetting(),
            _buttonSpacer,

            // Image settings
            ElevatedButton(
              onPressed: () => context.goNamed(imageSettingsRoute),
              child: Text(EFUILang.of(context)!.isPageTitle),
            ),
            _buttonSpacer,

            // Color settings
            ElevatedButton(
              onPressed: () => context.goNamed(colorSettingsRoute),
              child: Text(EFUILang.of(context)!.csPageTitle),
            ),
            _buttonSpacer,

            // Style settings
            ElevatedButton(
              onPressed: () => context.goNamed(styleSettingsRoute),
              child: Text(EFUILang.of(context)!.stsPageTitle),
            ),
            _buttonSeparator,

            // Reset button
            const EzResetButton(),
            _buttonSpacer,
          ],
        ),
      ),
    );
  }
}
