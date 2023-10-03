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
  void initState() {
    super.initState();
    setPageTitle(context: context, title: 'Settings');
  }

  // Gather theme data //

  late bool _isLight = !PlatformTheme.of(context)!.isDark;

  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  final double _textSpacer = EzConfig.instance.prefs[textSpacingKey];

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
              warning: 'ATTENTION',
              message: kIsWeb
                  ? """Each button will preview it's changes
Reload the page for your changes to take full effect!
Have fun!"""
                  : """Each button will preview it's changes
Restart the app for your changes to take full effect!
Have fun!""",
              style: headlineSmall(context),
            ),
            EzSpacer(_textSpacer),

            // Theme mode switch
            const EzThemeModeSwitch(),
            EzSpacer(_buttonSpacer),

            // Dominant hand switch
            const EzDominantHandSwitch(),
            EzSpacer(_textSpacer),

            // Style settings
            Semantics(
              button: true,
              hint: 'Open the styling settings',
              child: ExcludeSemantics(
                child: ElevatedButton(
                  onPressed: () => context.goNamed(styleSettingsRoute),
                  child: const Text('Styling'),
                ),
              ),
            ),
            EzSpacer(_textSpacer),

            // Color settings
            Semantics(
              button: true,
              hint: 'Open the color settings',
              child: ExcludeSemantics(
                child: ElevatedButton(
                  onPressed: () => context.goNamed(colorSettingsRoute),
                  child: const Text('Colors'),
                ),
              ),
            ),
            EzSpacer(_buttonSpacer),

            // Image settings
            Semantics(
              button: true,
              hint: 'Open the image settings',
              child: ExcludeSemantics(
                child: ElevatedButton(
                  onPressed: () => context.goNamed(imageSettingsRoute),
                  child: const Text('Images'),
                ),
              ),
            ),
            EzSpacer(_buttonSpacer),

            // Reset button
            EzResetButton(context: context),
            EzSpacer(_textSpacer),
          ],
        ),
      ),
    );
  }
}
