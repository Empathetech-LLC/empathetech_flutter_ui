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
  // Set page/tab title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(context, EFUILang.of(context)!.ssPageTitle);
  }

  // Gather theme data //

  late bool _isLight = !PlatformTheme.of(context)!.isDark;

  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

  // Return the Build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        decorationImageKey: _isLight ? lightPageImageKey : darkPageImageKey,
        child: EzScrollView(
          children: [
            // Functionality disclaimer
            EzWarning(
              message: kIsWeb
                  ? EFUILang.of(context)!.ssSettingsGuide
                  : EFUILang.of(context)!.ssSettingsGuideWeb,
              style: headlineSmall(context),
            ),
            EzSpacer(_buttonSpacer),

            // Global settings
            const EzLocaleSetting(),
            EzSpacer(_buttonSpacer),

            const EzThemeModeSwitch(),
            EzSpacer(_buttonSpacer),

            const EzDominantHandSwitch(),
            EzSpacer(_buttonSpacer),

            // Image settings
            ElevatedButton(
              onPressed: () => context.goNamed(imageSettingsRoute),
              child: Text(EFUILang.of(context)!.isPageTitle),
            ),
            EzSpacer(_buttonSpacer),

            // Color settings
            ElevatedButton(
              onPressed: () => context.goNamed(colorSettingsRoute),
              child: Text(EFUILang.of(context)!.csPageTitle),
            ),
            EzSpacer(_buttonSpacer),

            // Style settings
            ElevatedButton(
              onPressed: () => context.goNamed(styleSettingsRoute),
              child: Text(EFUILang.of(context)!.stsPageTitle),
            ),
            EzSpacer(_buttonSpacer),

            // Reset button
            EzResetButton(
              context: context,
              dialogTitle: EFUILang.of(context)!.ssResetAll,
            ),
            EzSpacer(_buttonSpacer),
          ],
        ),
      ),
    );
  }
}
