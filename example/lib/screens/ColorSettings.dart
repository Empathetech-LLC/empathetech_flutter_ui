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
              decorationImageKey: lightPageImage,
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
                          update: lightBackgroundColor,
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          update: lightOnBackgroundColor,
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: lightBackgroundColor,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Surface
                        EzColorSetting(
                          update: lightSurfaceColor,
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          update: lightOnSurfaceColor,
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: lightSurfaceColor,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Primary
                        EzColorSetting(
                          updating: [
                            lightPrimaryColor,
                            lightPrimaryContainerColor,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            lightOnPrimaryColor,
                            lightOnPrimaryContainerColor,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: lightPrimaryColor,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Secondary
                        EzColorSetting(
                          updating: [
                            lightSecondaryColor,
                            lightSecondaryContainerColor,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            lightOnSecondaryColor,
                            lightOnSecondaryContainerColor,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: lightSecondaryColor,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Tertiary
                        EzColorSetting(
                          updating: [
                            lightTertiaryColor,
                            lightTertiaryContainerColor,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            lightOnTertiaryColor,
                            lightOnTertiaryContainerColor,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: lightTertiaryColor,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Error
                        EzColorSetting(
                          updating: [
                            lightErrorColor,
                            lightErrorContainerColor,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            lightOnErrorColor,
                            lightOnErrorContainerColor,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: lightErrorColor,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Outline
                        EzColorSetting(
                          update: lightOutlineColor,
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
                        lightBackgroundColor,
                        lightOnBackgroundColor,
                        lightSurfaceColor,
                        lightOnSurfaceColor,
                        lightPrimaryColor,
                        lightOnPrimaryColor,
                        lightPrimaryContainerColor,
                        lightOnPrimaryContainerColor,
                        lightSecondaryColor,
                        lightOnSecondaryColor,
                        lightSecondaryContainerColor,
                        lightOnSecondaryContainerColor,
                        lightTertiaryColor,
                        lightOnTertiaryColor,
                        lightTertiaryContainerColor,
                        lightOnTertiaryContainerColor,
                        lightErrorColor,
                        lightOnErrorColor,
                        lightErrorContainerColor,
                        lightOnErrorContainerColor,
                        lightOutlineColor,
                      ]);

                      popScreen(context: context, pass: true);
                    },
                  ),
                  EzSpacer(_buttonSpacer),
                ],
              ),
            )
          : EzScreen(
              decorationImageKey: darkPageImage,
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
                          update: darkBackgroundColor,
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          update: darkOnBackgroundColor,
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: darkBackgroundColor,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Surface
                        EzColorSetting(
                          update: darkSurfaceColor,
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          update: darkOnSurfaceColor,
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: darkSurfaceColor,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Primary
                        EzColorSetting(
                          updating: [
                            darkPrimaryColor,
                            darkPrimaryContainerColor,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            darkOnPrimaryColor,
                            darkOnPrimaryContainerColor,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: darkPrimaryColor,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Secondary
                        EzColorSetting(
                          updating: [
                            darkSecondaryColor,
                            darkSecondaryContainerColor,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            darkOnSecondaryColor,
                            darkOnSecondaryContainerColor,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: darkSecondaryColor,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Tertiary
                        EzColorSetting(
                          updating: [
                            darkTertiaryColor,
                            darkTertiaryContainerColor,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            darkOnTertiaryColor,
                            darkOnTertiaryContainerColor,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: darkTertiaryColor,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Error
                        EzColorSetting(
                          updating: [
                            darkErrorColor,
                            darkErrorContainerColor,
                          ],
                          name: EFUILang.of(context)!.csTheme,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            darkOnErrorColor,
                            darkOnErrorContainerColor,
                          ],
                          name: EFUILang.of(context)!.csThemeText,
                          textBackgroundKey: darkErrorColor,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Outline
                        EzColorSetting(
                          update: darkOutlineColor,
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
                        darkBackgroundColor,
                        darkOnBackgroundColor,
                        darkSurfaceColor,
                        darkOnSurfaceColor,
                        darkPrimaryColor,
                        darkOnPrimaryColor,
                        darkPrimaryContainerColor,
                        darkOnPrimaryContainerColor,
                        darkSecondaryColor,
                        darkOnSecondaryColor,
                        darkSecondaryContainerColor,
                        darkOnSecondaryContainerColor,
                        darkTertiaryColor,
                        darkOnTertiaryColor,
                        darkTertiaryContainerColor,
                        darkOnTertiaryContainerColor,
                        darkErrorColor,
                        darkOnErrorColor,
                        darkErrorContainerColor,
                        darkOnErrorContainerColor,
                        darkOutlineColor,
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
