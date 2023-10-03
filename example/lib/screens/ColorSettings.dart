import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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

  late bool _isLight = !PlatformTheme.of(context)!.isDark;
  late final String _themeProfile = _isLight ? 'light' : 'dark';

  // Define local reset button's messages
  late final String _resetTitle = "Reset all $_themeProfile theme colors?";
  final String _resetMessage = kIsWeb
      ? "Cannot be undone\nChanges take effect on page reload"
      : "Cannot be undone\nChanges take effect on app restart";

  late final TextStyle? resetLinkStyle =
      bodyLarge(context)?.copyWith(decoration: TextDecoration.underline);

  final double _textSpacer = EzConfig.instance.prefs[textSpacingKey];
  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: _isLight
          ? EzScreen(
              decorationImageKey: lightPageImageKey,
              child: EzScrollView(
                children: [
                  // Editing reminders
                  EzSelectableText(
                    """Editing: $_themeProfile theme
Long press buttons to reset individually""",
                    style: titleSmall(context),
                  ),
                  EzSpacer(_textSpacer),

                  // Settings //

                  // Nested in a horizontal scroll view in case the screen doesn't have enough horizontal space
                  EzScrollView(
                    scrollDirection: Axis.horizontal,
                    mainAxisSize: MainAxisSize.min,
                    primary: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Theme colors
                        const EzColorSetting(toControl: lightThemeColorKey, name: 'Theme'),
                        EzSpacer(_buttonSpacer),

                        const EzColorSetting(
                          toControl: lightThemeTextColorKey,
                          name: 'Theme text',
                          textBackgroundKey: lightThemeColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Page colors
                        const EzColorSetting(toControl: lightPageColorKey, name: 'Page'),
                        EzSpacer(_buttonSpacer),

                        const EzColorSetting(
                          toControl: lightPageTextColorKey,
                          name: 'Page text',
                          textBackgroundKey: lightPageColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Button colors
                        const EzColorSetting(toControl: lightButtonColorKey, name: 'Buttons'),
                        EzSpacer(_buttonSpacer),

                        const EzColorSetting(
                          toControl: lightButtonTextColorKey,
                          name: 'Button text',
                          textBackgroundKey: lightButtonColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Accent colors
                        const EzColorSetting(toControl: lightAccentColorKey, name: 'Accent'),
                        EzSpacer(_buttonSpacer),

                        const EzColorSetting(
                          toControl: lightAccentTextColorKey,
                          name: 'Accent text',
                          textBackgroundKey: lightAccentColorKey,
                        ),
                      ],
                    ),
                  ),
                  EzSpacer(_buttonSpacer),

                  // Local reset "all"
                  EzResetButton(
                    context: context,
                    hint: _resetMessage,
                    style: resetLinkStyle,
                    dialogTitle: _resetTitle,
                    dialogContents: _resetMessage,
                    onConfirm: () {
                      EzConfig.instance.preferences.remove(lightThemeColorKey);
                      EzConfig.instance.preferences.remove(lightThemeTextColorKey);
                      EzConfig.instance.preferences.remove(lightPageColorKey);
                      EzConfig.instance.preferences.remove(lightPageTextColorKey);
                      EzConfig.instance.preferences.remove(lightButtonColorKey);
                      EzConfig.instance.preferences.remove(lightButtonTextColorKey);
                      EzConfig.instance.preferences.remove(lightAccentColorKey);
                      EzConfig.instance.preferences.remove(lightAccentTextColorKey);

                      popScreen(context: context, pass: true);
                    },
                  ),
                  EzSpacer(_textSpacer),
                ],
              ),
            )
          : EzScreen(
              decorationImageKey: darkPageImageKey,
              child: EzScrollView(
                children: [
                  // Current theme mode reminder
                  EzSelectableText(
                    'Editing: $_themeProfile theme',
                    style: titleSmall(context),
                  ),
                  EzSpacer(_textSpacer),

                  // Settings //

                  // Nested in a horizontal scroll view in case the screen doesn't have enough horizontal space
                  EzScrollView(
                    scrollDirection: Axis.horizontal,
                    mainAxisSize: MainAxisSize.min,
                    primary: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Theme colors
                        const EzColorSetting(toControl: darkThemeColorKey, name: 'Theme'),
                        EzSpacer(_buttonSpacer),

                        const EzColorSetting(
                          toControl: darkThemeTextColorKey,
                          name: 'Theme text',
                          textBackgroundKey: darkThemeColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Page colors
                        const EzColorSetting(toControl: darkPageColorKey, name: 'Page'),
                        EzSpacer(_buttonSpacer),

                        const EzColorSetting(
                          toControl: darkPageTextColorKey,
                          name: 'Page text',
                          textBackgroundKey: darkPageColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Button colors
                        const EzColorSetting(toControl: darkButtonColorKey, name: 'Buttons'),
                        EzSpacer(_buttonSpacer),

                        const EzColorSetting(
                          toControl: darkButtonTextColorKey,
                          name: 'Button text',
                          textBackgroundKey: darkButtonColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Accent colors
                        const EzColorSetting(toControl: darkAccentColorKey, name: 'Accent'),
                        EzSpacer(_buttonSpacer),

                        const EzColorSetting(
                          toControl: darkAccentTextColorKey,
                          name: 'Accent text',
                          textBackgroundKey: darkAccentColorKey,
                        ),
                      ],
                    ),
                  ),
                  EzSpacer(_buttonSpacer),

                  // Local reset "all"
                  EzResetButton(
                    context: context,
                    hint: _resetMessage,
                    style: resetLinkStyle,
                    dialogTitle: _resetTitle,
                    dialogContents: _resetMessage,
                    onConfirm: () {
                      EzConfig.instance.preferences.remove(darkThemeColorKey);
                      EzConfig.instance.preferences.remove(darkThemeTextColorKey);
                      EzConfig.instance.preferences.remove(darkPageColorKey);
                      EzConfig.instance.preferences.remove(darkPageTextColorKey);
                      EzConfig.instance.preferences.remove(darkButtonColorKey);
                      EzConfig.instance.preferences.remove(darkButtonTextColorKey);
                      EzConfig.instance.preferences.remove(darkAccentColorKey);
                      EzConfig.instance.preferences.remove(darkAccentTextColorKey);

                      popScreen(context: context, pass: true);
                    },
                  ),
                  EzSpacer(_textSpacer),
                ],
              ),
            ),
    );
  }
}
