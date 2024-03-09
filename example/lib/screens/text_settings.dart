import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Enumerator for selecting which [TextStyle] is being updated
enum TextSettingType { display, headline, title, body, label }

class TextSettingsScreen extends StatefulWidget {
  const TextSettingsScreen({super.key});

  @override
  State<TextSettingsScreen> createState() => _TextSettingsScreenState();
}

class _TextSettingsScreenState extends State<TextSettingsScreen> {
  // Gather the theme data //

  late bool isDark = PlatformTheme.of(context)!.isDark;

  final double margin = EzConfig.get(marginKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EzSpacer spacer = EzSpacer(spacing);
  late final EzSpacer rowSpacer = EzSpacer.row(spacing);
  late final EzSwapSpacer swapSpacer = EzSwapSpacer(spacing);
  late final EzSpacer separator = EzSpacer(2 * spacing);

  late final EFUILang l10n = EFUILang.of(context)!;

  // Gather the build data //

  TextSettingType editing = TextSettingType.display;

  late TextStyle displayStyle = getDisplay(context)!;
  late TextStyle headlineStyle = getHeadline(context)!;
  late TextStyle titleStyle = getTitle(context)!;
  late TextStyle bodyStyle = getBody(context)!;
  late TextStyle labelStyle = getLabel(context)!;

  late final String display = l10n.tsDisplay.toLowerCase();
  late final String headline = l10n.tsHeadline.toLowerCase();
  late final String title = l10n.tsTitle.toLowerCase();
  late final String body = l10n.tsBody.toLowerCase();
  late final String label = l10n.tsLabel.toLowerCase();

  late final List<DropdownMenuEntry<TextSettingType>> styleChoices =
      <DropdownMenuEntry<TextSettingType>>[
    DropdownMenuEntry<TextSettingType>(
      value: TextSettingType.display,
      label: display,
    ),
    DropdownMenuEntry<TextSettingType>(
      value: TextSettingType.headline,
      label: headline,
    ),
    DropdownMenuEntry<TextSettingType>(
      value: TextSettingType.title,
      label: title,
    ),
    DropdownMenuEntry<TextSettingType>(
      value: TextSettingType.body,
      label: body,
    ),
    DropdownMenuEntry<TextSettingType>(
      value: TextSettingType.label,
      label: label,
    ),
  ];

  // Define the setting controllers //

  /// Font family setting(s)
  late final Map<TextSettingType, EzFontDropdownSetting> familyControllers =
      <TextSettingType, EzFontDropdownSetting>{
    TextSettingType.display: const EzFontDropdownSetting(
      settingKey: displayFontFamilyKey,
      settingType: FontDropdownType.fontFamily,
    ),
    TextSettingType.headline: const EzFontDropdownSetting(
      settingKey: headlineFontFamilyKey,
      settingType: FontDropdownType.fontFamily,
    ),
    TextSettingType.title: const EzFontDropdownSetting(
      settingKey: titleFontFamilyKey,
      settingType: FontDropdownType.fontFamily,
    ),
    TextSettingType.body: const EzFontDropdownSetting(
      settingKey: bodyFontFamilyKey,
      settingType: FontDropdownType.fontFamily,
    ),
    TextSettingType.label: const EzFontDropdownSetting(
      settingKey: labelFontFamilyKey,
      settingType: FontDropdownType.fontFamily,
    ),
  };

  /// Font weight setting(s)
  late final Map<TextSettingType, EzFontDropdownSetting> weightControllers =
      <TextSettingType, EzFontDropdownSetting>{
    TextSettingType.display: const EzFontDropdownSetting(
      settingKey: displayFontWeightKey,
      settingType: FontDropdownType.fontWeight,
    ),
    TextSettingType.headline: const EzFontDropdownSetting(
      settingKey: headlineFontWeightKey,
      settingType: FontDropdownType.fontWeight,
    ),
    TextSettingType.title: const EzFontDropdownSetting(
      settingKey: titleFontWeightKey,
      settingType: FontDropdownType.fontWeight,
    ),
    TextSettingType.body: const EzFontDropdownSetting(
      settingKey: bodyFontWeightKey,
      settingType: FontDropdownType.fontWeight,
    ),
    TextSettingType.label: const EzFontDropdownSetting(
      settingKey: labelFontWeightKey,
      settingType: FontDropdownType.fontWeight,
    ),
  };

  /// Font style setting(s)
  late final Map<TextSettingType, EzFontDropdownSetting> styleControllers =
      <TextSettingType, EzFontDropdownSetting>{
    TextSettingType.display: const EzFontDropdownSetting(
      settingKey: displayFontStyleKey,
      settingType: FontDropdownType.fontStyle,
    ),
    TextSettingType.headline: const EzFontDropdownSetting(
      settingKey: headlineFontStyleKey,
      settingType: FontDropdownType.fontStyle,
    ),
    TextSettingType.title: const EzFontDropdownSetting(
      settingKey: titleFontStyleKey,
      settingType: FontDropdownType.fontStyle,
    ),
    TextSettingType.body: const EzFontDropdownSetting(
      settingKey: bodyFontStyleKey,
      settingType: FontDropdownType.fontStyle,
    ),
    TextSettingType.label: const EzFontDropdownSetting(
      settingKey: labelFontStyleKey,
      settingType: FontDropdownType.fontStyle,
    ),
  };

  /// Font decoration setting(s)
  late final Map<TextSettingType, EzFontDropdownSetting> decorationControllers =
      <TextSettingType, EzFontDropdownSetting>{
    TextSettingType.display: const EzFontDropdownSetting(
      settingKey: displayFontDecorationKey,
      settingType: FontDropdownType.fontDecoration,
    ),
    TextSettingType.headline: const EzFontDropdownSetting(
      settingKey: headlineFontDecorationKey,
      settingType: FontDropdownType.fontDecoration,
    ),
    TextSettingType.title: const EzFontDropdownSetting(
      settingKey: titleFontDecorationKey,
      settingType: FontDropdownType.fontDecoration,
    ),
    TextSettingType.body: const EzFontDropdownSetting(
      settingKey: bodyFontDecorationKey,
      settingType: FontDropdownType.fontDecoration,
    ),
    TextSettingType.label: const EzFontDropdownSetting(
      settingKey: labelFontDecorationKey,
      settingType: FontDropdownType.fontDecoration,
    ),
  };

  /// Font size setting(s)
  late final Map<TextSettingType, EzFontIntegerSetting> sizeControllers =
      <TextSettingType, EzFontIntegerSetting>{
    TextSettingType.display: const EzFontIntegerSetting(
      settingKey: displayFontSizeKey,
      min: 8,
      max: 96,
    ),
    TextSettingType.headline: const EzFontIntegerSetting(
      settingKey: headlineFontSizeKey,
      min: 8,
      max: 96,
    ),
    TextSettingType.title: const EzFontIntegerSetting(
      settingKey: titleFontSizeKey,
      min: 8,
      max: 96,
    ),
    TextSettingType.body: const EzFontIntegerSetting(
      settingKey: bodyFontSizeKey,
      min: 8,
      max: 96,
    ),
    TextSettingType.label: const EzFontIntegerSetting(
      settingKey: labelFontSizeKey,
      min: 8,
      max: 96,
    ),
  };

  /// Letter spacing setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting>
      letterSpacingControllers = <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: const EzFontDoubleSetting(
      settingKey: displayLetterSpacingKey,
      min: -1.0,
      max: 1.0,
    ),
    TextSettingType.headline: const EzFontDoubleSetting(
      settingKey: headlineLetterSpacingKey,
      min: -1.0,
      max: 1.0,
    ),
    TextSettingType.title: const EzFontDoubleSetting(
      settingKey: titleLetterSpacingKey,
      min: -1.0,
      max: 1.0,
    ),
    TextSettingType.body: const EzFontDoubleSetting(
      settingKey: bodyLetterSpacingKey,
      min: -1.0,
      max: 1.0,
    ),
    TextSettingType.label: const EzFontDoubleSetting(
      settingKey: labelLetterSpacingKey,
      min: -1.0,
      max: 1.0,
    ),
  };

  /// Word spacing setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting> wordSpacingControllers =
      <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: const EzFontDoubleSetting(
      settingKey: displayWordSpacingKey,
      min: -1.0,
      max: 1.0,
    ),
    TextSettingType.headline: const EzFontDoubleSetting(
      settingKey: headlineWordSpacingKey,
      min: -1.0,
      max: 1.0,
    ),
    TextSettingType.title: const EzFontDoubleSetting(
      settingKey: titleWordSpacingKey,
      min: -1.0,
      max: 1.0,
    ),
    TextSettingType.body: const EzFontDoubleSetting(
      settingKey: bodyWordSpacingKey,
      min: -1.0,
      max: 1.0,
    ),
    TextSettingType.label: const EzFontDoubleSetting(
      settingKey: labelWordSpacingKey,
      min: -1.0,
      max: 1.0,
    ),
  };

  /// Line height setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting> lineHeightControllers =
      <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: const EzFontDoubleSetting(
      settingKey: displayFontHeightKey,
      min: 0.0,
      max: 5.0,
    ),
    TextSettingType.headline: const EzFontDoubleSetting(
      settingKey: headlineFontHeightKey,
      min: 0.0,
      max: 5.0,
    ),
    TextSettingType.title: const EzFontDoubleSetting(
      settingKey: titleFontHeightKey,
      min: 0.0,
      max: 5.0,
    ),
    TextSettingType.body: const EzFontDoubleSetting(
      settingKey: bodyFontHeightKey,
      min: 0.0,
      max: 5.0,
    ),
    TextSettingType.label: const EzFontDoubleSetting(
      settingKey: labelFontHeightKey,
      min: 0.0,
      max: 5.0,
    ),
  };

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(l10n.tsPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: efuiS,
      body: EzScreen(
        decorationImageKey: isDark ? darkPageImageKey : lightPageImageKey,
        child: EzScrollView(
          children: <Widget>[
            if (spacing > margin) EzSpacer(spacing - margin),

            // Style selector
            EzRow(
              mainAxisAlignment: MainAxisAlignment.center,
              reverseHands: true,
              children: <Widget>[
                Text(
                  l10n.tsEditing,
                  style: labelStyle,
                  textAlign: TextAlign.center,
                ),
                rowSpacer,
                DropdownMenu<TextSettingType>(
                  initialSelection: editing,
                  onSelected: (TextSettingType? value) {
                    if (value != null) {
                      setState(() {
                        editing = value;
                      });
                    }
                  },
                  dropdownMenuEntries: styleChoices,
                  textStyle: labelStyle,
                ),
              ],
            ),
            separator,

            // Controls
            EzScrollView(
              scrollDirection: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              child: EzRowCol.sym(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      familyControllers[editing]!, rowSpacer,
                      // weightControllers[editing]!, rowSpacer,
                      // styleControllers[editing]!, rowSpacer,
                      // decorationControllers[editing]!,
                    ],
                  ),
                  swapSpacer,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      sizeControllers[editing]!,
                      rowSpacer,
                      letterSpacingControllers[editing]!,
                      rowSpacer,
                      wordSpacingControllers[editing]!,
                      rowSpacer,
                      lineHeightControllers[editing]!,
                    ],
                  ),
                ],
              ),
            ),
            separator,

            // Display preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text: l10n.tsDisplayP1,
                  style: displayStyle,
                ),
                EzInlineLink(
                  l10n.tsDisplayLink,
                  style: displayStyle,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextSettingType.display;
                  }),
                  semanticsLabel: l10n.tsLinkHint(display),
                ),
                EzPlainText(
                  text: l10n.tsDisplayP2,
                  style: displayStyle,
                ),
              ],
              textAlign: TextAlign.center,
            ),
            spacer,

            // Headline preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text: l10n.tsHeadlineP1,
                  style: headlineStyle,
                ),
                EzInlineLink(
                  l10n.tsHeadlineLink,
                  style: headlineStyle,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextSettingType.headline;
                  }),
                  semanticsLabel: l10n.tsLinkHint(headline),
                ),
                EzPlainText(
                  text: l10n.tsHeadlineP2,
                  style: headlineStyle,
                ),
              ],
              textAlign: TextAlign.center,
            ),
            spacer,

            // Title preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text: l10n.tsTitleP1,
                  style: titleStyle,
                ),
                EzInlineLink(
                  l10n.tsTitleLink,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextSettingType.title;
                  }),
                  semanticsLabel: l10n.tsLinkHint(title),
                ),
              ],
              textAlign: TextAlign.center,
            ),
            spacer,

            // Body preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text: l10n.tsBodyP1,
                  style: bodyStyle,
                ),
                EzInlineLink(
                  l10n.tsBodyLink,
                  style: bodyStyle,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextSettingType.body;
                  }),
                  semanticsLabel: l10n.tsLinkHint(body),
                ),
                EzPlainText(
                  text: l10n.tsBodyP2,
                  style: bodyStyle,
                ),
              ],
              textAlign: TextAlign.center,
            ),
            spacer,

            // Label preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text: l10n.tsLabelP1,
                  style: labelStyle,
                ),
                EzInlineLink(
                  l10n.tsLabelLink,
                  style: labelStyle,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextSettingType.label;
                  }),
                  semanticsLabel: l10n.tsLinkHint(label),
                ),
                EzPlainText(
                  text: l10n.tsLabelP2,
                  style: labelStyle,
                ),
              ],
              textAlign: TextAlign.center,
            ),
            separator,

            // Local reset all
            EzResetButton(
              dialogTitle: l10n.tsResetAll,
              onConfirm: () {
                EzConfig.removeKeys(textStyleKeys.keys.toSet());
                popScreen(context: context, result: true);
              },
            ),
            spacer,
          ],
        ),
      ),
    );
  }
}
