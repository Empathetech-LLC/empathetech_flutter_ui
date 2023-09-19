import '../utils/utils.dart';
import '../screens/screens.dart';

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

    // Custom EFUI function that sets the tab title for web apps
    setPageTitle(context: context, title: 'Settings');
  }

  // Gather theme data //

  // Style settings can be taken directly from EzConfig
  final double buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  final double paragraphSpacer = EzConfig.instance.prefs[paragraphSpacingKey];

  // Color settings should be taken from the current context's theme
  // This way, if/when the theme changes in the backend, the frontend colors will actually respond
  // See 'empathetech_flutter_ui/lib/src/functions/ezThemeData.dart' for the color mappings
  late final Color? buttonColor = Theme.of(context).highlightColor;

  // Text styles should also be taken from the current context
  // This way, the app will respond properly to text size changes (page zoom, text scaling, etc)
  // See 'empathetech_flutter_ui/lib/src/functions/textStyles.dart' for the style mappings
  late final TextStyle? resetLinkStyle =
      titleLarge(context)?.copyWith(decoration: TextDecoration.underline);
  late final TextStyle? labelStyle = labelLarge(context);
  late final TextStyle? labelLinkStyle = labelStyle?.copyWith(
    color: buttonColor,
    decoration: TextDecoration.underline,
  );

  // Build page //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        child: EzScrollView(
          children: [
            // Functionality disclaimer
            EzWarning(
              warning: 'ATTENTION',
              message: kIsWeb
                  ? """Each button will preview it\'s changes
Reload the page for your changes to take full effect!
Have fun!"""
                  : """Each button will preview it\'s changes
Restart the app for your changes to take full effect!
Have fun!""",
              style: headlineSmall(context),
            ),
            EzSpacer(paragraphSpacer),

            // Theme mode switch
            const EzThemeModeSwitch(),
            EzSpacer(buttonSpacer),

            // Dominant hand switch
            const EzDominantHandSwitch(),
            EzSpacer(paragraphSpacer),

            // Color settings
            ElevatedButton(
              onPressed: () => context.goNamed(colorSettingsRoute),
              child: const Text('Colors'),
            ),
            EzSpacer(buttonSpacer),

            // Style settings
            ElevatedButton(
              onPressed: () => context.goNamed(styleSettingsRoute),
              child: const Text('Styling'),
            ),
            EzSpacer(paragraphSpacer),

            // Reset button
            EzSelectableText(
              'Reset all',
              style: resetLinkStyle,
              onTap: () => showPlatformDialog(
                context: context,
                builder: (context) => EzAlertDialog(
                  title: const EzSelectableText('Reset all settings?'),
                  contents: [
                    EzYesNo(
                      onConfirm: () {
                        EzConfig.instance.preferences.clear();
                        popScreen(context: context, pass: true);
                      },
                      onDeny: () => popScreen(context: context),
                    ),
                  ],
                  needsClose: false,
                ),
              ),
            ),
            EzSpacer(paragraphSpacer),
          ],
        ),
      ),
      fab: null,
    );
  }
}
