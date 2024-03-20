import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Enumerator for selecting which [TextStyle] is being updated
enum TextSettingType { display, headline, title, body, label }

class TextSettingsScreen extends StatelessWidget {
  const TextSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<DisplayTextStyleProvider>(
          create: (_) => DisplayTextStyleProvider(),
        ),
        ChangeNotifierProvider<HeadlineTextStyleProvider>(
          create: (_) => HeadlineTextStyleProvider(),
        ),
        ChangeNotifierProvider<TitleTextStyleProvider>(
          create: (_) => TitleTextStyleProvider(),
        ),
        ChangeNotifierProvider<BodyTextStyleProvider>(
          create: (_) => BodyTextStyleProvider(),
        ),
        ChangeNotifierProvider<LabelTextStyleProvider>(
          create: (_) => LabelTextStyleProvider(),
        ),
      ],
      child: const TextSettings(),
    );
  }
}

class TextSettings extends StatefulWidget {
  const TextSettings({super.key});

  @override
  State<TextSettings> createState() => _TextSettingsState();
}

class _TextSettingsState extends State<TextSettings> {
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

  late final DisplayTextStyleProvider displayProvider =
      Provider.of<DisplayTextStyleProvider>(context);
  late final HeadlineTextStyleProvider headlineProvider =
      Provider.of<HeadlineTextStyleProvider>(context);
  late final TitleTextStyleProvider titleProvider =
      Provider.of<TitleTextStyleProvider>(context);
  late final BodyTextStyleProvider bodyProvider =
      Provider.of<BodyTextStyleProvider>(context);
  late final LabelTextStyleProvider labelProvider =
      Provider.of<LabelTextStyleProvider>(context);

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
  late final Map<TextSettingType, EzFontFamilySetting> familyControllers =
      <TextSettingType, EzFontFamilySetting>{
    TextSettingType.display: EzFontFamilySetting(
      configKey: displayFontFamilyKey,
      notifierCallback: displayProvider.fuse,
    ),
    TextSettingType.headline: EzFontFamilySetting(
      configKey: headlineFontFamilyKey,
      notifierCallback: headlineProvider.fuse,
    ),
    TextSettingType.title: EzFontFamilySetting(
      configKey: titleFontFamilyKey,
      notifierCallback: titleProvider.fuse,
    ),
    TextSettingType.body: EzFontFamilySetting(
      configKey: bodyFontFamilyKey,
      notifierCallback: bodyProvider.fuse,
    ),
    TextSettingType.label: EzFontFamilySetting(
      configKey: labelFontFamilyKey,
      notifierCallback: labelProvider.fuse,
    ),
  };

  /// Font size setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting> sizeControllers =
      <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: EzFontDoubleSetting(
      configKey: displayFontSizeKey,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: displayProvider.resize,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      configKey: headlineFontSizeKey,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: headlineProvider.resize,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      configKey: titleFontSizeKey,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: titleProvider.resize,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      configKey: bodyFontSizeKey,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: bodyProvider.resize,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      configKey: labelFontSizeKey,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: labelProvider.resize,
    ),
  };

  /// Font weight setting(s)
  late final Map<TextSettingType, EzBoldSetting> boldControllers =
      <TextSettingType, EzBoldSetting>{
    TextSettingType.display: EzBoldSetting(
      configKey: displayBoldKey,
      notifierCallback: displayProvider.bold,
    ),
    TextSettingType.headline: EzBoldSetting(
      configKey: headlineBoldKey,
      notifierCallback: headlineProvider.bold,
    ),
    TextSettingType.title: EzBoldSetting(
      configKey: titleBoldKey,
      notifierCallback: titleProvider.bold,
    ),
    TextSettingType.body: EzBoldSetting(
      configKey: bodyBoldKey,
      notifierCallback: bodyProvider.bold,
    ),
    TextSettingType.label: EzBoldSetting(
      configKey: labelBoldKey,
      notifierCallback: labelProvider.bold,
    ),
  };

  /// Font style setting(s)
  late final Map<TextSettingType, EzItalicSetting> italicsControllers =
      <TextSettingType, EzItalicSetting>{
    TextSettingType.display: EzItalicSetting(
      configKey: displayItalicsKey,
      notifierCallback: displayProvider.italic,
    ),
    TextSettingType.headline: EzItalicSetting(
      configKey: headlineItalicsKey,
      notifierCallback: headlineProvider.italic,
    ),
    TextSettingType.title: EzItalicSetting(
      configKey: titleItalicsKey,
      notifierCallback: titleProvider.italic,
    ),
    TextSettingType.body: EzItalicSetting(
      configKey: bodyItalicsKey,
      notifierCallback: bodyProvider.italic,
    ),
    TextSettingType.label: EzItalicSetting(
      configKey: labelItalicsKey,
      notifierCallback: labelProvider.italic,
    ),
  };

  /// Font decoration setting(s)
  late final Map<TextSettingType, EzUnderlineSetting> underlineControllers =
      <TextSettingType, EzUnderlineSetting>{
    TextSettingType.display: EzUnderlineSetting(
      configKey: displayUnderlinedKey,
      notifierCallback: displayProvider.underline,
    ),
    TextSettingType.headline: EzUnderlineSetting(
      configKey: headlineUnderlinedKey,
      notifierCallback: headlineProvider.underline,
    ),
    TextSettingType.title: EzUnderlineSetting(
      configKey: titleUnderlinedKey,
      notifierCallback: titleProvider.underline,
    ),
    TextSettingType.body: EzUnderlineSetting(
      configKey: bodyUnderlinedKey,
      notifierCallback: bodyProvider.underline,
    ),
    TextSettingType.label: EzUnderlineSetting(
      configKey: labelUnderlinedKey,
      notifierCallback: labelProvider.underline,
    ),
  };

  /// Letter spacing setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting>
      letterSpacingControllers = <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: EzFontDoubleSetting(
      configKey: displayLetterSpacingKey,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: displayProvider.setLetterSpacing,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      configKey: headlineLetterSpacingKey,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: headlineProvider.setLetterSpacing,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      configKey: titleLetterSpacingKey,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: titleProvider.setLetterSpacing,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      configKey: bodyLetterSpacingKey,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: bodyProvider.setLetterSpacing,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      configKey: labelLetterSpacingKey,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: labelProvider.setLetterSpacing,
    ),
  };

  /// Word spacing setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting> wordSpacingControllers =
      <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: EzFontDoubleSetting(
      configKey: displayWordSpacingKey,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: displayProvider.setWordSpacing,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      configKey: headlineWordSpacingKey,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: headlineProvider.setWordSpacing,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      configKey: titleWordSpacingKey,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: titleProvider.setWordSpacing,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      configKey: bodyWordSpacingKey,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: bodyProvider.setWordSpacing,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      configKey: labelWordSpacingKey,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: labelProvider.setWordSpacing,
    ),
  };

  /// Line height setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting> lineHeightControllers =
      <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: EzFontDoubleSetting(
      configKey: displayFontHeightKey,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: displayProvider.setHeight,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      configKey: headlineFontHeightKey,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: headlineProvider.setHeight,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      configKey: titleFontHeightKey,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: titleProvider.setHeight,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      configKey: bodyFontHeightKey,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: bodyProvider.setHeight,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      configKey: labelFontHeightKey,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: labelProvider.setHeight,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  l10n.tsEditing,
                  style: labelProvider.value,
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
                  textStyle: labelProvider.value,
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
                  // Font family
                  familyControllers[editing]!,
                  swapSpacer,

                  // Font size
                  sizeControllers[editing]!,
                  swapSpacer,

                  // Font weight, style, and decoration
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      boldControllers[editing]!,
                      rowSpacer,
                      italicsControllers[editing]!,
                      rowSpacer,
                      underlineControllers[editing]!,
                    ],
                  ),
                  swapSpacer,

                  // Letter, word, and line spacing
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                  style: displayProvider.value,
                ),
                EzInlineLink(
                  l10n.tsDisplayLink,
                  style: displayProvider.value,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextSettingType.display;
                  }),
                  semanticsLabel: l10n.tsLinkHint(display),
                ),
                EzPlainText(
                  text: l10n.tsDisplayP2,
                  style: displayProvider.value,
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
                  style: headlineProvider.value,
                ),
                EzInlineLink(
                  l10n.tsHeadlineLink,
                  style: headlineProvider.value,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextSettingType.headline;
                  }),
                  semanticsLabel: l10n.tsLinkHint(headline),
                ),
                EzPlainText(
                  text: l10n.tsHeadlineP2,
                  style: headlineProvider.value,
                ),
              ],
              textAlign: TextAlign.center,
            ),
            spacer,

            // Title preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(text: l10n.tsTitleP1, style: titleProvider.value),
                EzInlineLink(
                  l10n.tsTitleLink,
                  style: titleProvider.value,
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
                EzPlainText(text: l10n.tsBodyP1, style: bodyProvider.value),
                EzInlineLink(
                  l10n.tsBodyLink,
                  style: bodyProvider.value,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextSettingType.body;
                  }),
                  semanticsLabel: l10n.tsLinkHint(body),
                ),
                EzPlainText(text: l10n.tsBodyP2, style: bodyProvider.value),
              ],
              textAlign: TextAlign.center,
            ),
            spacer,

            // Label preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(text: l10n.tsLabelP1, style: labelProvider.value),
                EzInlineLink(
                  l10n.tsLabelLink,
                  style: labelProvider.value,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextSettingType.label;
                  }),
                  semanticsLabel: l10n.tsLinkHint(label),
                ),
                EzPlainText(text: l10n.tsLabelP2, style: labelProvider.value),
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
