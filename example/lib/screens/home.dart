import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
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

  final double buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  final double paragraphSpacer = EzConfig.instance.prefs[paragraphSpacingKey];

  late final Color? buttonColor = Theme.of(context).highlightColor;

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
              message: """Each button will preview it\'s settting
Reload this (or any) page for the changes to take full effect
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
              onPressed: () => context.goNamed('color-settings'),
              child: const Text('Colors'),
            ),
            EzSpacer(buttonSpacer),

            // Style settings
            ElevatedButton(
              onPressed: () => context.goNamed('style-settings'),
              child: const Text('Styling'),
            ),
            EzSpacer(paragraphSpacer),

            // Reset button
            EzSelectableText(
              'Reset all',
              style: resetLinkStyle,
              onTap: () => showPlatformDialog(
                context: context,
                builder: (context) => EzDialog(
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
                ),
              ),
            ),
            EzSpacer(3 * paragraphSpacer),
          ],
        ),
      ),
      fab: const BackFAB(),
    );
  }
}
