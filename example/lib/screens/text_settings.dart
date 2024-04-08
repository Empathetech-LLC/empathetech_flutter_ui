import '../utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
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
      key: const ValueKey<String>(displayFontFamilyKey),
      configKey: displayFontFamilyKey,
      notifierCallback: displayProvider.fuse,
    ),
    TextSettingType.headline: EzFontFamilySetting(
      key: const ValueKey<String>(headlineFontFamilyKey),
      configKey: headlineFontFamilyKey,
      notifierCallback: headlineProvider.fuse,
    ),
    TextSettingType.title: EzFontFamilySetting(
      key: const ValueKey<String>(titleFontFamilyKey),
      configKey: titleFontFamilyKey,
      notifierCallback: titleProvider.fuse,
    ),
    TextSettingType.body: EzFontFamilySetting(
      key: const ValueKey<String>(bodyFontFamilyKey),
      configKey: bodyFontFamilyKey,
      notifierCallback: bodyProvider.fuse,
    ),
    TextSettingType.label: EzFontFamilySetting(
      key: const ValueKey<String>(labelFontFamilyKey),
      configKey: labelFontFamilyKey,
      notifierCallback: labelProvider.fuse,
    ),
  };

  /// Font size setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting> sizeControllers =
      <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: EzFontDoubleSetting(
      key: const ValueKey<String>(displayFontSizeKey),
      configKey: displayFontSizeKey,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: displayProvider.resize,
      tooltip: l10n.tsFontSize,
      sizingString: fontSizeSampleString,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      key: const ValueKey<String>(headlineFontSizeKey),
      configKey: headlineFontSizeKey,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: headlineProvider.resize,
      tooltip: l10n.tsFontSize,
      sizingString: fontSizeSampleString,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      key: const ValueKey<String>(titleFontSizeKey),
      configKey: titleFontSizeKey,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: titleProvider.resize,
      tooltip: l10n.tsFontSize,
      sizingString: fontSizeSampleString,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      key: const ValueKey<String>(bodyFontSizeKey),
      configKey: bodyFontSizeKey,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: bodyProvider.resize,
      tooltip: l10n.tsFontSize,
      sizingString: fontSizeSampleString,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      key: const ValueKey<String>(labelFontSizeKey),
      configKey: labelFontSizeKey,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: labelProvider.resize,
      tooltip: l10n.tsFontSize,
      sizingString: fontSizeSampleString,
    ),
  };

  /// Font weight setting(s)
  late final Map<TextSettingType, EzBoldSetting> boldControllers =
      <TextSettingType, EzBoldSetting>{
    TextSettingType.display: EzBoldSetting(
      key: const ValueKey<String>(displayBoldKey),
      configKey: displayBoldKey,
      notifierCallback: displayProvider.bold,
    ),
    TextSettingType.headline: EzBoldSetting(
      key: const ValueKey<String>(headlineBoldKey),
      configKey: headlineBoldKey,
      notifierCallback: headlineProvider.bold,
    ),
    TextSettingType.title: EzBoldSetting(
      key: const ValueKey<String>(titleBoldKey),
      configKey: titleBoldKey,
      notifierCallback: titleProvider.bold,
    ),
    TextSettingType.body: EzBoldSetting(
      key: const ValueKey<String>(bodyBoldKey),
      configKey: bodyBoldKey,
      notifierCallback: bodyProvider.bold,
    ),
    TextSettingType.label: EzBoldSetting(
      key: const ValueKey<String>(labelBoldKey),
      configKey: labelBoldKey,
      notifierCallback: labelProvider.bold,
    ),
  };

  /// Font style setting(s)
  late final Map<TextSettingType, EzItalicSetting> italicsControllers =
      <TextSettingType, EzItalicSetting>{
    TextSettingType.display: EzItalicSetting(
      key: const ValueKey<String>(displayItalicsKey),
      configKey: displayItalicsKey,
      notifierCallback: displayProvider.italic,
    ),
    TextSettingType.headline: EzItalicSetting(
      key: const ValueKey<String>(headlineItalicsKey),
      configKey: headlineItalicsKey,
      notifierCallback: headlineProvider.italic,
    ),
    TextSettingType.title: EzItalicSetting(
      key: const ValueKey<String>(titleItalicsKey),
      configKey: titleItalicsKey,
      notifierCallback: titleProvider.italic,
    ),
    TextSettingType.body: EzItalicSetting(
      key: const ValueKey<String>(bodyItalicsKey),
      configKey: bodyItalicsKey,
      notifierCallback: bodyProvider.italic,
    ),
    TextSettingType.label: EzItalicSetting(
      key: const ValueKey<String>(labelItalicsKey),
      configKey: labelItalicsKey,
      notifierCallback: labelProvider.italic,
    ),
  };

  /// Font decoration setting(s)
  late final Map<TextSettingType, EzUnderlineSetting> underlineControllers =
      <TextSettingType, EzUnderlineSetting>{
    TextSettingType.display: EzUnderlineSetting(
      key: const ValueKey<String>(displayUnderlinedKey),
      configKey: displayUnderlinedKey,
      notifierCallback: displayProvider.underline,
    ),
    TextSettingType.headline: EzUnderlineSetting(
      key: const ValueKey<String>(headlineUnderlinedKey),
      configKey: headlineUnderlinedKey,
      notifierCallback: headlineProvider.underline,
    ),
    TextSettingType.title: EzUnderlineSetting(
      key: const ValueKey<String>(titleUnderlinedKey),
      configKey: titleUnderlinedKey,
      notifierCallback: titleProvider.underline,
    ),
    TextSettingType.body: EzUnderlineSetting(
      key: const ValueKey<String>(bodyUnderlinedKey),
      configKey: bodyUnderlinedKey,
      notifierCallback: bodyProvider.underline,
    ),
    TextSettingType.label: EzUnderlineSetting(
      key: const ValueKey<String>(labelUnderlinedKey),
      configKey: labelUnderlinedKey,
      notifierCallback: labelProvider.underline,
    ),
  };

  /// Letter spacing setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting>
      letterSpacingControllers = <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: EzFontDoubleSetting(
      key: const ValueKey<String>(displayLetterSpacingKey),
      configKey: displayLetterSpacingKey,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: displayProvider.setLetterSpacing,
      tooltip: l10n.tsLetterSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      key: const ValueKey<String>(headlineLetterSpacingKey),
      configKey: headlineLetterSpacingKey,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: headlineProvider.setLetterSpacing,
      tooltip: l10n.tsLetterSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      key: const ValueKey<String>(titleLetterSpacingKey),
      configKey: titleLetterSpacingKey,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: titleProvider.setLetterSpacing,
      tooltip: l10n.tsLetterSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      key: const ValueKey<String>(bodyLetterSpacingKey),
      configKey: bodyLetterSpacingKey,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: bodyProvider.setLetterSpacing,
      tooltip: l10n.tsLetterSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      key: const ValueKey<String>(labelLetterSpacingKey),
      configKey: labelLetterSpacingKey,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: labelProvider.setLetterSpacing,
      tooltip: l10n.tsLetterSpacing,
      sizingString: fontSpacingSampleString,
    ),
  };

  /// Word spacing setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting> wordSpacingControllers =
      <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: EzFontDoubleSetting(
      key: const ValueKey<String>(displayWordSpacingKey),
      configKey: displayWordSpacingKey,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: displayProvider.setWordSpacing,
      tooltip: l10n.tsWordSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      key: const ValueKey<String>(headlineWordSpacingKey),
      configKey: headlineWordSpacingKey,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: headlineProvider.setWordSpacing,
      tooltip: l10n.tsWordSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      key: const ValueKey<String>(titleWordSpacingKey),
      configKey: titleWordSpacingKey,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: titleProvider.setWordSpacing,
      tooltip: l10n.tsWordSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      key: const ValueKey<String>(bodyWordSpacingKey),
      configKey: bodyWordSpacingKey,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: bodyProvider.setWordSpacing,
      tooltip: l10n.tsWordSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      key: const ValueKey<String>(labelWordSpacingKey),
      configKey: labelWordSpacingKey,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: labelProvider.setWordSpacing,
      tooltip: l10n.tsWordSpacing,
      sizingString: fontSpacingSampleString,
    ),
  };

  /// Line height setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting> lineHeightControllers =
      <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: EzFontDoubleSetting(
      key: const ValueKey<String>(displayFontHeightKey),
      configKey: displayFontHeightKey,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: displayProvider.setHeight,
      tooltip: l10n.tsLineHeight,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      key: const ValueKey<String>(headlineFontHeightKey),
      configKey: headlineFontHeightKey,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: headlineProvider.setHeight,
      tooltip: l10n.tsLineHeight,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      key: const ValueKey<String>(titleFontHeightKey),
      configKey: titleFontHeightKey,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: titleProvider.setHeight,
      tooltip: l10n.tsLineHeight,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      key: const ValueKey<String>(bodyFontHeightKey),
      configKey: bodyFontHeightKey,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: bodyProvider.setHeight,
      tooltip: l10n.tsLineHeight,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      key: const ValueKey<String>(labelFontHeightKey),
      configKey: labelFontHeightKey,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: labelProvider.setHeight,
      tooltip: l10n.tsLineHeight,
      sizingString: fontSpacingSampleString,
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
                EzPlainText(text: l10n.tsDisplayP1),
                EzInlineLink(
                  l10n.tsDisplayLink,
                  style: displayProvider.value,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextSettingType.display;
                  }),
                  semanticsLabel: l10n.tsLinkHint(display),
                ),
                EzPlainText(text: l10n.tsDisplayP2),
              ],
              style: displayProvider.value,
              textAlign: TextAlign.center,
            ),
            spacer,

            // Headline preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(text: l10n.tsHeadlineP1),
                EzInlineLink(
                  l10n.tsHeadlineLink,
                  style: headlineProvider.value,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextSettingType.headline;
                  }),
                  semanticsLabel: l10n.tsLinkHint(headline),
                ),
                EzPlainText(text: l10n.tsHeadlineP2),
              ],
              style: headlineProvider.value,
              textAlign: TextAlign.center,
            ),
            spacer,

            // Title preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(text: l10n.tsTitleP1),
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
              style: titleProvider.value,
              textAlign: TextAlign.center,
            ),
            spacer,

            // Body preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(text: l10n.tsBodyP1),
                EzInlineLink(
                  l10n.tsBodyLink,
                  style: bodyProvider.value,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextSettingType.body;
                  }),
                  semanticsLabel: l10n.tsLinkHint(body),
                ),
                EzPlainText(text: l10n.tsBodyP2),
              ],
              style: bodyProvider.value,
              textAlign: TextAlign.center,
            ),
            spacer,

            // Label preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(text: l10n.tsLabelP1),
                EzInlineLink(
                  l10n.tsLabelLink,
                  style: labelProvider.value,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextSettingType.label;
                  }),
                  semanticsLabel: l10n.tsLinkHint(label),
                ),
                EzPlainText(text: l10n.tsLabelP2),
              ],
              style: labelProvider.value,
              textAlign: TextAlign.center,
            ),
            separator,

            // Local reset all
            EzResetButton(
              dialogTitle: l10n.tsResetAll,
              onConfirm: () {
                EzConfig.removeKeys(textStyleKeys.keys.toSet());
                displayProvider.reset();
                headlineProvider.reset();
                titleProvider.reset();
                bodyProvider.reset();
                labelProvider.reset();
                setState(() {
                  editing = TextSettingType.display;
                });
                Navigator.of(context).pop(true);
              },
            ),
            spacer,
          ],
        ),
      ),
    );
  }
}
