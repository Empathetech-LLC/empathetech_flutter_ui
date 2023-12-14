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

  final double _buttonSpace = EzConfig.get(buttonSpacingKey);
  final double _textSpace = EzConfig.get(textSpacingKey);

  late final EzSpacer _buttonSpacer = EzSpacer(_buttonSpace);
  late final EzSpacer _buttonSeparator = EzSpacer(2 * _buttonSpace);
  late final EzSpacer _textSpacer = EzSpacer(_textSpace);

  late final TextStyle? _descriptionStyle = titleSmall(context);

  // Define the page content //

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

  final Set<String> _defaultLightColors = {
    lightPrimaryKey,
    lightSecondaryKey,
    lightTertiaryKey,
    lightBackgroundKey,
    lightSurfaceKey,
  };
  final Set<String> _defaultDarkColors = {
    darkPrimaryKey,
    darkSecondaryKey,
    darkTertiaryKey,
    darkBackgroundKey,
    darkSurfaceKey,
  };

  late final List<Widget> _lightButtons = [
    // Individual settings
    ...EzColorSetting.buildDynamicSet(
      defaultSet: _defaultLightColors,
      fullList: lightColors,
    ),
    _buttonSpacer,

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
    _buttonSeparator,

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
  ];

  late final List<Widget> _darkButtons = [
    // Individual settings
    ...EzColorSetting.buildDynamicSet(
      defaultSet: _defaultDarkColors,
      fullList: darkColors,
    ),
    _buttonSpacer,

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
    _buttonSeparator,

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
  ];

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
            // Current theme reminder
            Text(
              EFUILang.of(context)!.gEditingTheme(_themeProfile),
              style: _descriptionStyle,
              textAlign: TextAlign.center,
            ),
            _textSpacer,

            // Settings
            ...(_isLight ? _lightButtons : _darkButtons),
            _buttonSeparator,

            // Help
            EzLink(
              EFUILang.of(context)!.gHowToUse,
              style: _descriptionStyle,
              textAlign: TextAlign.center,
              url: Uri.parse(materialColorRoles),
              semanticsLabel: EFUILang.of(context)!.gHowToUseHint,
            ),
            _buttonSpacer,
          ],
        ),
      ),
    );
  }
}
