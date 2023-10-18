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
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(context, Lang.of(context)!.colorSettings);
  }

  // Gather theme data //

  late bool _isLight = !PlatformTheme.of(context)!.isDark;
  late final String _themeProfile =
      _isLight ? EFUILang.of(context)!.light : EFUILang.of(context)!.dark;

  // Define local reset button's messages
  late final String _resetTitle =
      Lang.of(context)!.resetAllColors(_themeProfile);

  late final String _resetMessage = kIsWeb
      ? Lang.of(context)!.resetAllWarningWeb
      : Lang.of(context)!.resetAllWarning;

  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  final double _textSpacer = EzConfig.instance.prefs[textSpacingKey];

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
                  EzText(
                    Lang.of(context)!.editingThemeColors(_themeProfile),
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
                        EzColorSetting(
                          toControl: lightThemeColorKey,
                          name: Lang.of(context)!.theme,
                        ),
                        EzSpacer(_buttonSpacer),

                        EzColorSetting(
                          toControl: lightThemeTextColorKey,
                          name: Lang.of(context)!.themeText,
                          textBackgroundKey: lightThemeColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Page colors
                        EzColorSetting(
                          toControl: lightPageColorKey,
                          name: Lang.of(context)!.page,
                        ),
                        EzSpacer(_buttonSpacer),

                        EzColorSetting(
                          toControl: lightPageTextColorKey,
                          name: Lang.of(context)!.pageText,
                          textBackgroundKey: lightPageColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Button colors
                        EzColorSetting(
                          toControl: lightButtonColorKey,
                          name: Lang.of(context)!.buttons,
                        ),
                        EzSpacer(_buttonSpacer),

                        EzColorSetting(
                          toControl: lightButtonTextColorKey,
                          name: Lang.of(context)!.buttonText,
                          textBackgroundKey: lightButtonColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Accent colors
                        EzColorSetting(
                          toControl: lightAccentColorKey,
                          name: Lang.of(context)!.accent,
                        ),
                        EzSpacer(_buttonSpacer),

                        EzColorSetting(
                          toControl: lightAccentTextColorKey,
                          name: Lang.of(context)!.accentText,
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
                    dialogTitle: _resetTitle,
                    dialogContents: _resetMessage,
                    onConfirm: () {
                      EzConfig.instance.preferences.remove(lightThemeColorKey);
                      EzConfig.instance.preferences
                          .remove(lightThemeTextColorKey);
                      EzConfig.instance.preferences.remove(lightPageColorKey);
                      EzConfig.instance.preferences
                          .remove(lightPageTextColorKey);
                      EzConfig.instance.preferences.remove(lightButtonColorKey);
                      EzConfig.instance.preferences
                          .remove(lightButtonTextColorKey);
                      EzConfig.instance.preferences.remove(lightAccentColorKey);
                      EzConfig.instance.preferences
                          .remove(lightAccentTextColorKey);

                      popScreen(context: context, pass: true);
                    },
                  ),
                  EzSpacer(_buttonSpacer),
                ],
              ),
            )
          : EzScreen(
              decorationImageKey: darkPageImageKey,
              child: EzScrollView(
                children: [
                  // Editing reminders
                  EzText(
                    Lang.of(context)!.editingThemeColors(_themeProfile),
                    style: titleSmall(context),
                  ),
                  EzSpacer(_buttonSpacer),

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
                        EzColorSetting(
                          toControl: darkThemeColorKey,
                          name: Lang.of(context)!.theme,
                        ),
                        EzSpacer(_buttonSpacer),

                        EzColorSetting(
                          toControl: darkThemeTextColorKey,
                          name: Lang.of(context)!.themeText,
                          textBackgroundKey: darkThemeColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Page colors
                        EzColorSetting(
                          toControl: darkPageColorKey,
                          name: Lang.of(context)!.page,
                        ),
                        EzSpacer(_buttonSpacer),

                        EzColorSetting(
                          toControl: darkPageTextColorKey,
                          name: Lang.of(context)!.pageText,
                          textBackgroundKey: darkPageColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Button colors
                        EzColorSetting(
                          toControl: darkButtonColorKey,
                          name: Lang.of(context)!.buttons,
                        ),
                        EzSpacer(_buttonSpacer),

                        EzColorSetting(
                          toControl: darkButtonTextColorKey,
                          name: Lang.of(context)!.buttonText,
                          textBackgroundKey: darkButtonColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Accent colors
                        EzColorSetting(
                          toControl: darkAccentColorKey,
                          name: Lang.of(context)!.accent,
                        ),
                        EzSpacer(_buttonSpacer),

                        EzColorSetting(
                          toControl: darkAccentTextColorKey,
                          name: Lang.of(context)!.accentText,
                          textBackgroundKey: darkAccentColorKey,
                        ),
                      ],
                    ),
                  ),
                  EzSpacer(_buttonSpacer),

                  // Local reset "all"
                  EzResetButton(
                    context: context,
                    hint: _resetTitle,
                    dialogTitle: _resetTitle,
                    dialogContents: _resetMessage,
                    onConfirm: () {
                      EzConfig.instance.preferences.remove(darkThemeColorKey);
                      EzConfig.instance.preferences
                          .remove(darkThemeTextColorKey);
                      EzConfig.instance.preferences.remove(darkPageColorKey);
                      EzConfig.instance.preferences
                          .remove(darkPageTextColorKey);
                      EzConfig.instance.preferences.remove(darkButtonColorKey);
                      EzConfig.instance.preferences
                          .remove(darkButtonTextColorKey);
                      EzConfig.instance.preferences.remove(darkAccentColorKey);
                      EzConfig.instance.preferences
                          .remove(darkAccentTextColorKey);

                      popScreen(context: context, pass: true);
                    },
                  ),
                  EzSpacer(_buttonSpacer),
                ],
              ),
            ),
    );
  }
}
