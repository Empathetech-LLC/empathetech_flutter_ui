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
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(context, EFUILang.of(context)!.csPageTitle);
  }

  // Gather theme data //

  late bool _isLight = !PlatformTheme.of(context)!.isDark;
  late final String _themeProfile =
      _isLight ? EFUILang.of(context)!.gLight : EFUILang.of(context)!.gDark;

  // Define local reset button's messages
  late final String _resetTitle =
      EFUILang.of(context)!.csResetAll(_themeProfile);

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
                  Text(
                    EFUILang.of(context)!.csEditingTheme(_themeProfile),
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
                        // Background
                        EzColorSetting(
                          update: lightBackgroundColorKey,
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          update: lightOnBackgroundColorKey,
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: lightBackgroundColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Surface
                        EzColorSetting(
                          update: lightSurfaceColorKey,
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          update: lightOnSurfaceColorKey,
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: lightSurfaceColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Primary
                        EzColorSetting(
                          updating: [
                            lightPrimaryColorKey,
                            lightPrimaryContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            lightOnPrimaryColorKey,
                            lightOnPrimaryContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: lightPrimaryColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Secondary
                        EzColorSetting(
                          updating: [
                            lightSecondaryColorKey,
                            lightSecondaryContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            lightOnSecondaryColorKey,
                            lightOnSecondaryContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: lightSecondaryColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Tertiary
                        EzColorSetting(
                          updating: [
                            lightTertiaryColorKey,
                            lightTertiaryContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            lightOnTertiaryColorKey,
                            lightOnTertiaryContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: lightTertiaryColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Error
                        EzColorSetting(
                          updating: [
                            lightErrorColorKey,
                            lightErrorContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            lightOnErrorColorKey,
                            lightOnErrorContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: lightErrorColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Outline
                        EzColorSetting(
                          update: lightOutlineColorKey,
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                      ],
                    ),
                  ),
                  EzSpacer(2 * _buttonSpacer),

                  // Local reset "all"
                  EzResetButton(
                    context: context,
                    hint: _resetTitle,
                    dialogTitle: _resetTitle,
                    onConfirm: () {
                      removeAllKeys([
                        lightBackgroundColorKey,
                        lightOnBackgroundColorKey,
                        lightSurfaceColorKey,
                        lightOnSurfaceColorKey,
                        lightPrimaryColorKey,
                        lightOnPrimaryColorKey,
                        lightPrimaryContainerColorKey,
                        lightOnPrimaryContainerColorKey,
                        lightSecondaryColorKey,
                        lightOnSecondaryColorKey,
                        lightSecondaryContainerColorKey,
                        lightOnSecondaryContainerColorKey,
                        lightTertiaryColorKey,
                        lightOnTertiaryColorKey,
                        lightTertiaryContainerColorKey,
                        lightOnTertiaryContainerColorKey,
                        lightErrorColorKey,
                        lightOnErrorColorKey,
                        lightErrorContainerColorKey,
                        lightOnErrorContainerColorKey,
                        lightOutlineColorKey,
                      ]);

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
                  Text(
                    EFUILang.of(context)!.csEditingTheme(_themeProfile),
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
                        // Background
                        EzColorSetting(
                          update: darkBackgroundColorKey,
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          update: darkOnBackgroundColorKey,
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: darkBackgroundColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Surface
                        EzColorSetting(
                          update: darkSurfaceColorKey,
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          update: darkOnSurfaceColorKey,
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: darkSurfaceColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Primary
                        EzColorSetting(
                          updating: [
                            darkPrimaryColorKey,
                            darkPrimaryContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            darkOnPrimaryColorKey,
                            darkOnPrimaryContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: darkPrimaryColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Secondary
                        EzColorSetting(
                          updating: [
                            darkSecondaryColorKey,
                            darkSecondaryContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            darkOnSecondaryColorKey,
                            darkOnSecondaryContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: darkSecondaryColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Tertiary
                        EzColorSetting(
                          updating: [
                            darkTertiaryColorKey,
                            darkTertiaryContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            darkOnTertiaryColorKey,
                            darkOnTertiaryContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: darkTertiaryColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Error
                        EzColorSetting(
                          updating: [
                            darkErrorColorKey,
                            darkErrorContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            darkOnErrorColorKey,
                            darkOnErrorContainerColorKey,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: darkErrorColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Outline
                        EzColorSetting(
                          update: darkOutlineColorKey,
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                      ],
                    ),
                  ),
                  EzSpacer(2 * _buttonSpacer),

                  // Local reset "all"
                  EzResetButton(
                    context: context,
                    hint: _resetTitle,
                    dialogTitle: _resetTitle,
                    onConfirm: () {
                      removeAllKeys([
                        darkBackgroundColorKey,
                        darkOnBackgroundColorKey,
                        darkSurfaceColorKey,
                        darkOnSurfaceColorKey,
                        darkPrimaryColorKey,
                        darkOnPrimaryColorKey,
                        darkPrimaryContainerColorKey,
                        darkOnPrimaryContainerColorKey,
                        darkSecondaryColorKey,
                        darkOnSecondaryColorKey,
                        darkSecondaryContainerColorKey,
                        darkOnSecondaryContainerColorKey,
                        darkTertiaryColorKey,
                        darkOnTertiaryColorKey,
                        darkTertiaryContainerColorKey,
                        darkOnTertiaryContainerColorKey,
                        darkErrorColorKey,
                        darkOnErrorColorKey,
                        darkErrorContainerColorKey,
                        darkOnErrorContainerColorKey,
                        darkOutlineColorKey,
                      ]);

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
