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

  final double textSpacer = EzConfig.instance.prefs[textSpacingKey];
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
            // Current theme mode reminder
            EzSelectableText(
              'Editing: $themeProfile theme',
              style: titleSmall(context),
            ),
            EzSpacer(textSpacer),

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
                    name: 'Theme',
                  ),
                  EzSpacer(buttonSpacer),

                  // Text
                  EzColorSetting(
                    toControl: isLight ? lightThemeTextColorKey : darkThemeTextColorKey,
                    name: 'Theme text',
                    textBackgroundKey: isLight ? lightThemeColorKey : darkThemeColorKey,
                  ),
                  EzSpacer(buttonSpacer),

                  // Page colors //

                  // Base
                  EzColorSetting(
                    toControl: isLight ? lightBackgroundColorKey : darkBackgroundColorKey,
                    name: 'Page',
                  ),
                  EzSpacer(buttonSpacer),

                  // Text
                  EzColorSetting(
                    toControl: isLight ? lightBackgroundTextColorKey : darkBackgroundTextColorKey,
                    name: 'Page text',
                    textBackgroundKey: isLight ? lightBackgroundColorKey : darkBackgroundColorKey,
                  ),
                  EzSpacer(buttonSpacer),

                  // Button colors //

                  // Base
                  EzColorSetting(
                    toControl: isLight ? lightButtonColorKey : darkButtonColorKey,
                    name: 'Buttons',
                  ),
                  EzSpacer(buttonSpacer),

                  // Text
                  EzColorSetting(
                    toControl: isLight ? lightButtonTextColorKey : darkButtonTextColorKey,
                    name: 'Button text',
                    textBackgroundKey: isLight ? lightButtonColorKey : darkButtonColorKey,
                  ),
                  EzSpacer(buttonSpacer),

                  // Accent colors //

                  // Base
                  EzColorSetting(
                    toControl: isLight ? lightAccentColorKey : darkAccentColorKey,
                    name: 'Accent',
                  ),
                  EzSpacer(buttonSpacer),

                  // Text
                  EzColorSetting(
                    toControl: isLight ? lightAccentTextColorKey : darkAccentTextColorKey,
                    name: 'Accent text',
                    textBackgroundKey: isLight ? lightAccentColorKey : darkAccentColorKey,
                  ),
                ],
              ),
            ),
            EzSpacer(textSpacer),
          ],
        ),
      ),
    );
  }
}
