import './screens.dart';
import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    setPageTitle(context: context, title: AppLocalizations.of(context)!.settings);
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
              warning: AppLocalizations.of(context)!.attention,
              message: kIsWeb
                  ? AppLocalizations.of(context)!.resetWarning
                  : AppLocalizations.of(context)!.resetWarningWeb,
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
            ElevatedButton(
              onPressed: () => context.goNamed(styleSettingsRoute),
              child: const Text('Styling'),
            ),
            EzSpacer(_textSpacer),

            // Color settings
            ElevatedButton(
              onPressed: () => context.goNamed(colorSettingsRoute),
              child: const Text('Colors'),
            ),
            EzSpacer(_buttonSpacer),

            // Image settings

            ElevatedButton(
              onPressed: () => context.goNamed(imageSettingsRoute),
              child: const Text('Images'),
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
