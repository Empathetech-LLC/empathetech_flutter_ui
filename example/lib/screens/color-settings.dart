import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ColorSettingsScreen extends StatefulWidget {
  const ColorSettingsScreen({Key? key}) : super(key: key);

  @override
  _ColorSettingsScreenState createState() => _ColorSettingsScreenState();
}

class _ColorSettingsScreenState extends State<ColorSettingsScreen> {
  // Set page/tab title //

  @override
  void initState() {
    super.initState();
    setPageTitle(context: context, title: 'Color settings');
  }

  // Gather theme data //

  late bool isLight = !PlatformTheme.of(context)!.isDark;

  final double paragraphSpacer = EzConfig.instance.prefs[paragraphSpacingKey];
  final double buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  final double diameter = EzConfig.instance.prefs[circleDiameterKey];

  // Build page //

  @override
  Widget build(BuildContext context) {
    final String themeProfile = isLight ? 'Light' : 'Dark';

    return ExampleScaffold(
      body: EzScreen(
        child: EzScrollView(
          children: [
            // Title
            EzSelectableText(
              'Make it yours!',
              style: headlineSmall(context),
            ),
            EzSpacer(0.5 * paragraphSpacer),

            EzSelectableText(
              'Editing: $themeProfile theme',
              style: titleSmall(context),
            ),
            EzSpacer(1.5 * paragraphSpacer),

            // Settings //

            // Nested in a horizontal scroll view in case the screen doesn't have enough horizontal space
            EzScrollView(
              scrollDirection: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Theme colors //

                  // Base
                  EzColorSetting(
                    toControl: isLight ? lightThemeColorKey : darkThemeColorKey,
                    message: 'Theme',
                  ),
                  EzSpacer(buttonSpacer),

                  // Text
                  EzColorSetting(
                    toControl: isLight ? lightThemeTextColorKey : darkThemeTextColorKey,
                    message: 'Theme text',
                    textBackgroundKey: isLight ? lightThemeColorKey : darkThemeColorKey,
                  ),
                  EzSpacer(buttonSpacer),

                  // Page colors //

                  // Base
                  EzColorSetting(
                    toControl: isLight ? lightBackgroundColorKey : darkBackgroundColorKey,
                    message: 'Page',
                  ),
                  EzSpacer(buttonSpacer),

                  // Text
                  EzColorSetting(
                    toControl: isLight ? lightBackgroundTextColorKey : darkBackgroundTextColorKey,
                    message: 'Page text',
                    textBackgroundKey: isLight ? lightBackgroundColorKey : darkBackgroundColorKey,
                  ),
                  EzSpacer(buttonSpacer),

                  // Button colors //

                  // Base
                  EzColorSetting(
                    toControl: isLight ? lightButtonColorKey : darkButtonColorKey,
                    message: 'Buttons',
                  ),
                  EzSpacer(buttonSpacer),

                  // Text
                  EzColorSetting(
                    toControl: isLight ? lightButtonTextColorKey : darkButtonTextColorKey,
                    message: 'Button text',
                    textBackgroundKey: isLight ? lightButtonColorKey : darkButtonColorKey,
                  ),
                  EzSpacer(buttonSpacer),

                  // Accent colors //

                  // Base
                  EzColorSetting(
                    toControl: isLight ? lightAccentColorKey : darkAccentColorKey,
                    message: 'Accent',
                  ),
                  EzSpacer(buttonSpacer),

                  // Text
                  EzColorSetting(
                    toControl: isLight ? lightAccentTextColorKey : darkAccentTextColorKey,
                    message: 'Accent text',
                    textBackgroundKey: isLight ? lightAccentColorKey : darkAccentColorKey,
                  ),
                ],
              ),
            ),
            EzSpacer(paragraphSpacer),
          ],
        ),
      ),
      fab: const BackFAB(),
    );
  }
}
