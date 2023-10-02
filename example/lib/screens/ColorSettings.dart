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

  late final TextStyle? resetLinkStyle =
      bodyLarge(context)?.copyWith(decoration: TextDecoration.underline);

  // Build page //

  @override
  Widget build(BuildContext context) {
    final String themeProfile = isLight ? 'Light' : 'Dark';
    final String resetMessage = "Reset all $themeProfile colors?";

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
                children: isLight
                    ? // Editing light theme //
                    [
                        // Theme colors
                        const EzColorSetting(toControl: lightThemeColorKey, name: 'Theme'),
                        EzSpacer(buttonSpacer),

                        const EzColorSetting(
                          toControl: lightThemeTextColorKey,
                          name: 'Theme text',
                          textBackgroundKey: lightThemeColorKey,
                        ),
                        EzSpacer(buttonSpacer),

                        // Page colors
                        const EzColorSetting(toControl: lightPageColorKey, name: 'Page'),
                        EzSpacer(buttonSpacer),

                        const EzColorSetting(
                          toControl: lightPageTextColorKey,
                          name: 'Page text',
                          textBackgroundKey: lightPageColorKey,
                        ),
                        EzSpacer(buttonSpacer),

                        // Button colors
                        const EzColorSetting(toControl: lightButtonColorKey, name: 'Buttons'),
                        EzSpacer(buttonSpacer),

                        const EzColorSetting(
                          toControl: lightButtonTextColorKey,
                          name: 'Button text',
                          textBackgroundKey: lightButtonColorKey,
                        ),
                        EzSpacer(buttonSpacer),

                        // Accent colors
                        const EzColorSetting(toControl: lightAccentColorKey, name: 'Accent'),
                        EzSpacer(buttonSpacer),

                        const EzColorSetting(
                          toControl: lightAccentTextColorKey,
                          name: 'Accent text',
                          textBackgroundKey: lightAccentColorKey,
                        ),
                      ]
                    : // Editing dark theme //
                    [
                        // Theme colors
                        const EzColorSetting(toControl: darkThemeColorKey, name: 'Theme'),
                        EzSpacer(buttonSpacer),

                        const EzColorSetting(
                          toControl: darkThemeTextColorKey,
                          name: 'Theme text',
                          textBackgroundKey: darkThemeColorKey,
                        ),
                        EzSpacer(buttonSpacer),

                        // Page colors
                        const EzColorSetting(toControl: darkPageColorKey, name: 'Page'),
                        EzSpacer(buttonSpacer),

                        const EzColorSetting(
                          toControl: darkPageTextColorKey,
                          name: 'Page text',
                          textBackgroundKey: darkPageColorKey,
                        ),
                        EzSpacer(buttonSpacer),

                        // Button colors
                        const EzColorSetting(toControl: darkButtonColorKey, name: 'Buttons'),
                        EzSpacer(buttonSpacer),

                        const EzColorSetting(
                          toControl: darkButtonTextColorKey,
                          name: 'Button text',
                          textBackgroundKey: darkButtonColorKey,
                        ),
                        EzSpacer(buttonSpacer),

                        // Accent colors
                        const EzColorSetting(toControl: darkAccentColorKey, name: 'Accent'),
                        EzSpacer(buttonSpacer),

                        const EzColorSetting(
                          toControl: darkAccentTextColorKey,
                          name: 'Accent text',
                          textBackgroundKey: darkAccentColorKey,
                        ),
                      ],
              ),
            ),
            EzSpacer(buttonSpacer),

            // Local reset "all"
            EzResetButton(
              context: context,
              hint: resetMessage,
              style: resetLinkStyle,
              dialogTitle: resetMessage,
              onConfirm: () {
                if (isLight) {
                  EzConfig.instance.preferences.remove(lightThemeColorKey);
                  EzConfig.instance.preferences.remove(lightThemeTextColorKey);
                  EzConfig.instance.preferences.remove(lightPageColorKey);
                  EzConfig.instance.preferences.remove(lightPageTextColorKey);
                  EzConfig.instance.preferences.remove(lightButtonColorKey);
                  EzConfig.instance.preferences.remove(lightButtonTextColorKey);
                  EzConfig.instance.preferences.remove(lightAccentColorKey);
                  EzConfig.instance.preferences.remove(lightAccentTextColorKey);
                } else {
                  EzConfig.instance.preferences.remove(darkThemeColorKey);
                  EzConfig.instance.preferences.remove(darkThemeTextColorKey);
                  EzConfig.instance.preferences.remove(darkPageColorKey);
                  EzConfig.instance.preferences.remove(darkPageTextColorKey);
                  EzConfig.instance.preferences.remove(darkButtonColorKey);
                  EzConfig.instance.preferences.remove(darkButtonTextColorKey);
                  EzConfig.instance.preferences.remove(darkAccentColorKey);
                  EzConfig.instance.preferences.remove(darkAccentTextColorKey);
                }
              },
            ),
            EzSpacer(textSpacer),
          ],
        ),
      ),
    );
  }
}
