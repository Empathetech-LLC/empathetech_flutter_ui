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
  // Gather the theme data //

  late bool _isLight = !PlatformTheme.of(context)!.isDark;

  final double _buttonSpacer = EzConfig.get(buttonSpacingKey);

  late final TextStyle? _descriptionStyle = titleSmall(context);

  late final String _themeProfile = _isLight
      ? EFUILang.of(context)!.gLight.toLowerCase()
      : EFUILang.of(context)!.gDark.toLowerCase();

  late final String _fromImageLabel = EFUILang.of(context)!.csSchemeBase;
  late final String _fromImageTitle =
      "$_themeProfile ${EFUILang.of(context)!.csColorScheme}";
  late final String _fromImageHint =
      "${EFUILang.of(context)!.csOptional}: ${EFUILang.of(context)!.csFromImage}";

  late final String _resetTitle =
      EFUILang.of(context)!.csResetAll(_themeProfile);

  final Set<String> defaultLightColors = {
    lightPrimaryKey,
    lightSecondaryKey,
    lightTertiaryKey,
    lightBackgroundKey,
    lightSurfaceKey,
  };
  final Set<String> defaultDarkColors = {
    darkPrimaryKey,
    darkSecondaryKey,
    darkTertiaryKey,
    darkBackgroundKey,
    darkSurfaceKey,
  };

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(context, EFUILang.of(context)!.csPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        decorationImageKey: _isLight ? lightPageImageKey : darkPageImageKey,
        child: EzScrollView(
          children: [
            // Editing reminders
            Text(
              EFUILang.of(context)!.gEditingTheme(_themeProfile),
              style: _descriptionStyle,
              textAlign: TextAlign.center,
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
                children: _isLight
                    ? [
                        // Individual settings
                        ...EzColorSetting.buildDynamicSet(
                          defaultSet: defaultLightColors,
                          fullList: lightColors,
                        ),

                        // ColorScheme source
                        Semantics(
                          button: true,
                          hint: _fromImageHint,
                          child: ExcludeSemantics(
                            child: EzImageSetting(
                              prefsKey: lightColorSchemeImageKey,
                              label: _fromImageLabel,
                              dialogTitle: _fromImageTitle,
                              allowClear: true,
                              updateTheme: Brightness.light,
                              hideThemeMessage: true,
                            ),
                          ),
                        ),
                        EzSpacer(_buttonSpacer),

                        // Local reset all
                        EzResetButton(
                          context: context,
                          hint: _resetTitle,
                          dialogTitle: _resetTitle,
                          onConfirm: () {
                            EzConfig.removeKeys(lightColorKeys.keys.toSet());
                            popScreen(context: context, pass: true);
                          },
                        ),
                      ]
                    : [
                        // Individual settings
                        ...EzColorSetting.buildDynamicSet(
                          defaultSet: defaultDarkColors,
                          fullList: darkColors,
                        ),

                        // ColorScheme source
                        Semantics(
                          button: true,
                          hint: _fromImageHint,
                          child: ExcludeSemantics(
                            child: EzImageSetting(
                              prefsKey: darkColorSchemeImageKey,
                              label: _fromImageLabel,
                              dialogTitle: _fromImageTitle,
                              allowClear: true,
                              updateTheme: Brightness.dark,
                              hideThemeMessage: true,
                            ),
                          ),
                        ),
                        EzSpacer(_buttonSpacer),

                        // Local reset all
                        EzResetButton(
                          context: context,
                          hint: _resetTitle,
                          dialogTitle: _resetTitle,
                          onConfirm: () {
                            EzConfig.removeKeys(darkColorKeys.keys.toSet());
                            popScreen(context: context, pass: true);
                          },
                        ),
                      ],
              ),
            ),
            EzSpacer(_buttonSpacer),
          ],
        ),
      ),
    );
  }
}
