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
      body: EzScreen(
        decorationImageKey: _isLight ? lightPageImageKey : darkPageImageKey,
        child: EzScrollView(
          children: [
            // Editing reminders
            SelectableText(
              EFUILang.of(context)!.csEditingTheme(_themeProfile),
              style: titleSmall(context),
              textAlign: TextAlign.center,
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
                children: _isLight
                    ? [
                        // Background
                        EzColorSetting(
                          updating: [lightBackgroundColorKey],
                          label: EFUILang.of(context)!.csBackground,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [lightOnBackgroundColorKey],
                          label: EFUILang.of(context)!.csOnBackground,
                          textBackgroundKey: lightBackgroundColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Surface
                        EzColorSetting(
                          updating: [lightSurfaceColorKey],
                          label: EFUILang.of(context)!.csSurface,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [lightOnSurfaceColorKey],
                          label: EFUILang.of(context)!.csOnSurface,
                          textBackgroundKey: lightSurfaceColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Primary
                        EzColorSetting(
                          updating: [
                            lightPrimaryColorKey,
                            lightPrimaryContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csPrimary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            lightOnPrimaryColorKey,
                            lightOnPrimaryContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csOnPrimary,
                          textBackgroundKey: lightPrimaryColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Secondary
                        EzColorSetting(
                          updating: [
                            lightSecondaryColorKey,
                            lightSecondaryContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csSecondary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            lightOnSecondaryColorKey,
                            lightOnSecondaryContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csOnSecondary,
                          textBackgroundKey: lightSecondaryColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Tertiary
                        EzColorSetting(
                          updating: [
                            lightTertiaryColorKey,
                            lightTertiaryContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csTertiary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            lightOnTertiaryColorKey,
                            lightOnTertiaryContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csOnTertiary,
                          textBackgroundKey: lightTertiaryColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Error
                        EzColorSetting(
                          updating: [
                            lightErrorColorKey,
                            lightErrorContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csError,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            lightOnErrorColorKey,
                            lightOnErrorContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csOnError,
                          textBackgroundKey: lightErrorColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Outline
                        EzColorSetting(
                          updating: [lightOutlineColorKey],
                          label: EFUILang.of(context)!.csOutline,
                        ),
                        EzSpacer(_buttonSpacer),
                      ]
                    : [
                        // Background
                        EzColorSetting(
                          updating: [darkBackgroundColorKey],
                          label: EFUILang.of(context)!.csBackground,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [darkOnBackgroundColorKey],
                          label: EFUILang.of(context)!.csOnBackground,
                          textBackgroundKey: darkBackgroundColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Surface
                        EzColorSetting(
                          updating: [darkSurfaceColorKey],
                          label: EFUILang.of(context)!.csSurface,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [darkOnSurfaceColorKey],
                          label: EFUILang.of(context)!.csOnSurface,
                          textBackgroundKey: darkSurfaceColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Primary
                        EzColorSetting(
                          updating: [
                            darkPrimaryColorKey,
                            darkPrimaryContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csPrimary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            darkOnPrimaryColorKey,
                            darkOnPrimaryContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csOnPrimary,
                          textBackgroundKey: darkPrimaryColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Secondary
                        EzColorSetting(
                          updating: [
                            darkSecondaryColorKey,
                            darkSecondaryContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csSecondary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            darkOnSecondaryColorKey,
                            darkOnSecondaryContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csOnSecondary,
                          textBackgroundKey: darkSecondaryColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Tertiary
                        EzColorSetting(
                          updating: [
                            darkTertiaryColorKey,
                            darkTertiaryContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csTertiary,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            darkOnTertiaryColorKey,
                            darkOnTertiaryContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csOnTertiary,
                          textBackgroundKey: darkTertiaryColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Error
                        EzColorSetting(
                          updating: [
                            darkErrorColorKey,
                            darkErrorContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csError,
                        ),
                        EzSpacer(_buttonSpacer),
                        EzColorSetting(
                          updating: [
                            darkOnErrorColorKey,
                            darkOnErrorContainerColorKey,
                          ],
                          label: EFUILang.of(context)!.csOnError,
                          textBackgroundKey: darkErrorColorKey,
                        ),
                        EzSpacer(_buttonSpacer),

                        // Outline
                        EzColorSetting(
                          updating: [darkOutlineColorKey],
                          label: EFUILang.of(context)!.csOutline,
                        ),
                        EzSpacer(_buttonSpacer),
                      ],
              ),
            ),

            EzSpacer(2 * _buttonSpacer),

            // Local reset all
            EzResetButton(
              context: context,
              hint: _resetTitle,
              dialogTitle: _resetTitle,
              onConfirm: () {
                removeAllKeys(_isLight ? lightColorKeys : darkColorKeys);
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
