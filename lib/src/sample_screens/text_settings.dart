/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Enumerator for selecting which [TextStyle] is being updated
enum TextSettingType { display, headline, title, body, label }

class TextSettings extends StatelessWidget {
  /// Dark theme value for [EzScreen.decorationImageKey]
  final String? darkBackgroundImageKey;

  /// Light theme value for [EzScreen.decorationImageKey]
  final String? lightBackgroundImageKey;

  /// Whether the [TextStyle] spacing controls should be shown
  final bool showSpacing;

  const TextSettings({
    super.key,
    this.darkBackgroundImageKey,
    this.lightBackgroundImageKey,
    this.showSpacing = true,
  });

  // Set the page title //

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.onSurface;

    return MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<DisplayTextStyleProvider>(
          create: (_) => DisplayTextStyleProvider(color: textColor),
        ),
        ChangeNotifierProvider<HeadlineTextStyleProvider>(
          create: (_) => HeadlineTextStyleProvider(color: textColor),
        ),
        ChangeNotifierProvider<TitleTextStyleProvider>(
          create: (_) => TitleTextStyleProvider(color: textColor),
        ),
        ChangeNotifierProvider<BodyTextStyleProvider>(
          create: (_) => BodyTextStyleProvider(color: textColor),
        ),
        ChangeNotifierProvider<LabelTextStyleProvider>(
          create: (_) => LabelTextStyleProvider(color: textColor),
        ),
      ],
      child: _TextSettings(
        darkBackgroundImageKey: darkBackgroundImageKey,
        lightBackgroundImageKey: lightBackgroundImageKey,
        showSpacing: showSpacing,
      ),
    );
  }
}

class _TextSettings extends StatefulWidget {
  final String? darkBackgroundImageKey;
  final String? lightBackgroundImageKey;
  final bool showSpacing;

  const _TextSettings({
    required this.darkBackgroundImageKey,
    required this.lightBackgroundImageKey,
    required this.showSpacing,
  });

  @override
  State<_TextSettings> createState() => _TextSettingsState();
}

class _TextSettingsState extends State<_TextSettings> {
  // Gather the theme data //

  late final bool isDark = PlatformTheme.of(context)!.isDark;

  final double margin = EzConfig.get(marginKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EzSpacer spacer = EzSpacer(spacing);

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define the build data //

  static const String quick = 'quick';
  static const String advanced = 'advanced';

  String currentTab = quick;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(l10n.tsPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScreen(
      decorationImageKey: isDark
          ? widget.darkBackgroundImageKey
          : widget.lightBackgroundImageKey,
      child: EzScrollView(
        children: <Widget>[
          if (spacing > margin) EzSpacer(spacing - margin),

          // Mode selector
          SegmentedButton<String>(
            segments: <ButtonSegment<String>>[
              ButtonSegment<String>(
                value: quick,
                label: Text(l10n.csQuick),
              ),
              ButtonSegment<String>(
                value: advanced,
                label: Text(l10n.csAdvanced),
              ),
            ],
            selected: <String>{currentTab},
            showSelectedIcon: false,
            onSelectionChanged: (Set<String> selected) {
              currentTab = selected.first;
              setState(() {});
            },
          ),
          spacer,

          // Settings
          if (currentTab == quick)
            const _QuickTextSettings()
          else
            _AdvancedTextSettings(showSpacing: widget.showSpacing),
        ],
      ),
    );
  }
}

class _QuickTextSettings extends StatefulWidget {
  const _QuickTextSettings();

  @override
  State<_QuickTextSettings> createState() => _QuickTextSettingsState();
}

class _QuickTextSettingsState extends State<_QuickTextSettings> {
  // Gather the theme data //

  final double spacing = EzConfig.get(spacingKey);

  late final EzSpacer spacer = EzSpacer(spacing);
  late final EzSwapSpacer swapSpacer = EzSwapSpacer(spacing);
  late final EzSpacer separator = EzSpacer(2 * spacing);

  late final EFUILang l10n = EFUILang.of(context)!;

  // Gather the build data //

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

  late final Map<String, String> defaultFonts = <String, String>{
    displayFontFamilyKey: EzConfig.getDefault(displayFontFamilyKey),
    headlineFontFamilyKey: EzConfig.getDefault(headlineFontFamilyKey),
    titleFontFamilyKey: EzConfig.getDefault(titleFontFamilyKey),
    bodyFontFamilyKey: EzConfig.getDefault(bodyFontFamilyKey),
    labelFontFamilyKey: EzConfig.getDefault(labelFontFamilyKey),
  };

  late final Map<String, double> defaultSizes = <String, double>{
    displayFontSizeKey: EzConfig.getDefault(displayFontSizeKey),
    headlineFontSizeKey: EzConfig.getDefault(headlineFontSizeKey),
    titleFontSizeKey: EzConfig.getDefault(titleFontSizeKey),
    bodyFontSizeKey: EzConfig.getDefault(bodyFontSizeKey),
    labelFontSizeKey: EzConfig.getDefault(labelFontSizeKey),
  };

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        EzRow(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Font family
            EzFontFamilyBatchSetting(
              key: ValueKey<int>(bodyProvider.id),
              keysNDefaults: defaultFonts,
              notifierCallback: (String font) {
                displayProvider.fuse(font);
                headlineProvider.fuse(font);
                titleProvider.fuse(font);
                bodyProvider.fuse(font);
                labelProvider.fuse(font);
              },
              baseStyle: bodyProvider.value,
            ),
            swapSpacer,

            // Font size
            EzFontDoubleBatchSetting(
              key: ValueKey<int>(bodyProvider.id),
              keysNDefaults: defaultSizes,
              min: minFontScale,
              max: maxFontScale,
              notifierCallback: (bool changed) {
                if (changed) {
                  displayProvider
                      .resize(EzConfig.getDouble(displayFontSizeKey)!);
                  headlineProvider
                      .resize(EzConfig.getDouble(headlineFontSizeKey)!);
                  titleProvider.resize(EzConfig.getDouble(titleFontSizeKey)!);
                  bodyProvider.resize(EzConfig.getDouble(bodyFontSizeKey)!);
                  labelProvider.resize(EzConfig.getDouble(labelFontSizeKey)!);
                }
              },
              tooltip: l10n.tsFontSize,
              style: bodyProvider.value,
            ),
          ],
        ),
        separator,

        // Display preview
        Text(
          l10n.tsDisplayP1 + l10n.tsDisplayLink + l10n.tsDisplayP2,
          textAlign: TextAlign.center,
          style: displayProvider.value,
        ),
        spacer,

        // Headline preview
        Text(
          l10n.tsHeadlineP1 + l10n.tsHeadlineLink + l10n.tsHeadlineP2,
          textAlign: TextAlign.center,
          style: headlineProvider.value,
        ),
        spacer,

        // Title preview
        Text(
          l10n.tsTitleP1 + l10n.tsTitleLink,
          textAlign: TextAlign.center,
          style: titleProvider.value,
        ),
        spacer,

        // Body preview
        Text(
          l10n.tsBodyP1 + l10n.tsBodyLink + l10n.tsBodyP2,
          textAlign: TextAlign.center,
          style: bodyProvider.value,
        ),
        spacer,

        // Label preview
        Text(
          l10n.tsLabelP1 + l10n.tsLabelLink + l10n.tsLabelP2,
          textAlign: TextAlign.center,
          style: labelProvider.value,
        ),
        separator,

        // Reset all
        EzResetButton(
          dialogTitle: l10n.tsResetAll,
          onConfirm: () {
            EzConfig.removeKeys(textStyleKeys.keys.toSet());
            displayProvider.reset();
            headlineProvider.reset();
            titleProvider.reset();
            bodyProvider.reset();
            labelProvider.reset();

            setState(() {});
          },
        ),
        spacer,
      ],
    );
  }
}

class _AdvancedTextSettings extends StatefulWidget {
  final bool showSpacing;

  const _AdvancedTextSettings({required this.showSpacing});

  @override
  State<_AdvancedTextSettings> createState() => _AdvancedTextSettingsState();
}

class _AdvancedTextSettingsState extends State<_AdvancedTextSettings> {
  // Gather the theme data //

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
      icon: Icons.text_fields_sharp,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
      sizingString: fontSizeSampleString,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      key: const ValueKey<String>(headlineFontSizeKey),
      configKey: headlineFontSizeKey,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: headlineProvider.resize,
      icon: Icons.text_fields_sharp,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
      sizingString: fontSizeSampleString,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      key: const ValueKey<String>(titleFontSizeKey),
      configKey: titleFontSizeKey,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: titleProvider.resize,
      icon: Icons.text_fields_sharp,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
      sizingString: fontSizeSampleString,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      key: const ValueKey<String>(bodyFontSizeKey),
      configKey: bodyFontSizeKey,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: bodyProvider.resize,
      icon: Icons.text_fields_sharp,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
      sizingString: fontSizeSampleString,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      key: const ValueKey<String>(labelFontSizeKey),
      configKey: labelFontSizeKey,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: labelProvider.resize,
      icon: Icons.text_fields_sharp,
      plusMinus: true,
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
      icon: Icons.horizontal_distribute_sharp,
      tooltip: l10n.tsLetterSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      key: const ValueKey<String>(headlineLetterSpacingKey),
      configKey: headlineLetterSpacingKey,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: headlineProvider.setLetterSpacing,
      icon: Icons.horizontal_distribute_sharp,
      tooltip: l10n.tsLetterSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      key: const ValueKey<String>(titleLetterSpacingKey),
      configKey: titleLetterSpacingKey,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: titleProvider.setLetterSpacing,
      icon: Icons.horizontal_distribute_sharp,
      tooltip: l10n.tsLetterSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      key: const ValueKey<String>(bodyLetterSpacingKey),
      configKey: bodyLetterSpacingKey,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: bodyProvider.setLetterSpacing,
      icon: Icons.horizontal_distribute_sharp,
      tooltip: l10n.tsLetterSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      key: const ValueKey<String>(labelLetterSpacingKey),
      configKey: labelLetterSpacingKey,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: labelProvider.setLetterSpacing,
      icon: Icons.horizontal_distribute_sharp,
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
      icon: Icons.space_bar_sharp,
      tooltip: l10n.tsWordSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      key: const ValueKey<String>(headlineWordSpacingKey),
      configKey: headlineWordSpacingKey,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: headlineProvider.setWordSpacing,
      icon: Icons.space_bar_sharp,
      tooltip: l10n.tsWordSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      key: const ValueKey<String>(titleWordSpacingKey),
      configKey: titleWordSpacingKey,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: titleProvider.setWordSpacing,
      icon: Icons.space_bar_sharp,
      tooltip: l10n.tsWordSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      key: const ValueKey<String>(bodyWordSpacingKey),
      configKey: bodyWordSpacingKey,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: bodyProvider.setWordSpacing,
      icon: Icons.space_bar_sharp,
      tooltip: l10n.tsWordSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      key: const ValueKey<String>(labelWordSpacingKey),
      configKey: labelWordSpacingKey,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: labelProvider.setWordSpacing,
      icon: Icons.space_bar_sharp,
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
      icon: Icons.format_line_spacing_sharp,
      tooltip: l10n.tsLineHeight,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      key: const ValueKey<String>(headlineFontHeightKey),
      configKey: headlineFontHeightKey,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: headlineProvider.setHeight,
      icon: Icons.format_line_spacing_sharp,
      tooltip: l10n.tsLineHeight,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      key: const ValueKey<String>(titleFontHeightKey),
      configKey: titleFontHeightKey,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: titleProvider.setHeight,
      icon: Icons.format_line_spacing_sharp,
      tooltip: l10n.tsLineHeight,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      key: const ValueKey<String>(bodyFontHeightKey),
      configKey: bodyFontHeightKey,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: bodyProvider.setHeight,
      icon: Icons.format_line_spacing_sharp,
      tooltip: l10n.tsLineHeight,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      key: const ValueKey<String>(labelFontHeightKey),
      configKey: labelFontHeightKey,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: labelProvider.setHeight,
      icon: Icons.format_line_spacing_sharp,
      tooltip: l10n.tsLineHeight,
      sizingString: fontSpacingSampleString,
    ),
  };

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Style selector
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                l10n.gEditing,
                style: labelProvider.value,
                textAlign: TextAlign.center,
              ),
            ),
            rowSpacer,
            DropdownMenu<TextSettingType>(
              initialSelection: editing,
              onSelected: (TextSettingType? value) {
                if (value != null) {
                  editing = value;
                  setState(() {});
                }
              },
              dropdownMenuEntries: styleChoices,
              textStyle: labelProvider.value,
            ),
          ],
        ),
        spacer,

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

              // Letter, word, and line spacing
              if (widget.showSpacing) ...<Widget>{
                swapSpacer,
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
              }
            ],
          ),
        ),
        separator,

        // Display preview
        EzRichText(
          <InlineSpan>[
            EzPlainText(text: l10n.tsDisplayP1),
            EzInlineLink(
              key: ValueKey<int>(displayProvider.id),
              l10n.tsDisplayLink,
              style: displayProvider.value,
              textAlign: TextAlign.center,
              onTap: () {
                editing = TextSettingType.display;
                setState(() {});
              },
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
              key: ValueKey<int>(headlineProvider.id),
              l10n.tsHeadlineLink,
              style: headlineProvider.value,
              textAlign: TextAlign.center,
              onTap: () {
                editing = TextSettingType.headline;
                setState(() {});
              },
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
              key: ValueKey<int>(titleProvider.id),
              l10n.tsTitleLink,
              style: titleProvider.value,
              textAlign: TextAlign.center,
              onTap: () {
                editing = TextSettingType.title;
                setState(() {});
              },
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
              key: ValueKey<int>(bodyProvider.id),
              l10n.tsBodyLink,
              style: bodyProvider.value,
              textAlign: TextAlign.center,
              onTap: () {
                editing = TextSettingType.body;
                setState(() {});
              },
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
              key: ValueKey<int>(labelProvider.id),
              l10n.tsLabelLink,
              style: labelProvider.value,
              textAlign: TextAlign.center,
              onTap: () {
                editing = TextSettingType.label;
                setState(() {});
              },
              semanticsLabel: l10n.tsLinkHint(label),
            ),
            EzPlainText(text: l10n.tsLabelP2),
          ],
          style: labelProvider.value,
          textAlign: TextAlign.center,
        ),

        separator,

        // Reset all
        EzResetButton(
          dialogTitle: l10n.tsResetAll,
          onConfirm: () {
            EzConfig.removeKeys(textStyleKeys.keys.toSet());
            displayProvider.reset();
            headlineProvider.reset();
            titleProvider.reset();
            bodyProvider.reset();
            labelProvider.reset();
            editing = TextSettingType.display;
            setState(() {});
          },
        ),
        spacer,
      ],
    );
  }
}
