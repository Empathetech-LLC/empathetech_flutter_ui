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

  late final Map<String, String> defaultFontFamilies = <String, String>{
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
              key: ValueKey<String>('batchFontFamily-${bodyProvider.id}'),
              keysNDefaults: defaultFontFamilies,
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
              key: ValueKey<String>('batchFontDouble-${bodyProvider.id}'),
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
      key: ValueKey<String>(
          '$displayFontFamilyKey-${displayProvider.id}-${bodyProvider.id}'),
      configKey: displayFontFamilyKey,
      initialValue: displayProvider.value.fontFamily!,
      notifierCallback: displayProvider.fuse,
      baseStyle: bodyProvider.value,
    ),
    TextSettingType.headline: EzFontFamilySetting(
      key: ValueKey<String>(
          '$headlineFontFamilyKey-${headlineProvider.id}-${bodyProvider.id}'),
      configKey: headlineFontFamilyKey,
      initialValue: headlineProvider.value.fontFamily!,
      notifierCallback: headlineProvider.fuse,
      baseStyle: bodyProvider.value,
    ),
    TextSettingType.title: EzFontFamilySetting(
      key: ValueKey<String>(
          '$titleFontFamilyKey-${titleProvider.id}-${bodyProvider.id}'),
      configKey: titleFontFamilyKey,
      initialValue: titleProvider.value.fontFamily!,
      notifierCallback: titleProvider.fuse,
      baseStyle: bodyProvider.value,
    ),
    TextSettingType.body: EzFontFamilySetting(
      key: ValueKey<String>(
          '$bodyFontFamilyKey-${bodyProvider.id}-${bodyProvider.id}'),
      configKey: bodyFontFamilyKey,
      initialValue: bodyProvider.value.fontFamily!,
      notifierCallback: bodyProvider.fuse,
      baseStyle: bodyProvider.value,
    ),
    TextSettingType.label: EzFontFamilySetting(
      key: ValueKey<String>(
          '$labelFontFamilyKey-${labelProvider.id}-${bodyProvider.id}'),
      configKey: labelFontFamilyKey,
      initialValue: labelProvider.value.fontFamily!,
      notifierCallback: labelProvider.fuse,
      baseStyle: bodyProvider.value,
    ),
  };

  /// Font size setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting> sizeControllers =
      <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: EzFontDoubleSetting(
      key: ValueKey<String>(
          '$displayFontSizeKey-${displayProvider.id}-${bodyProvider.id}'),
      configKey: displayFontSizeKey,
      initialValue: displayProvider.value.fontSize!,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: displayProvider.resize,
      style: bodyProvider.value,
      icon: Icons.text_fields_sharp,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
      sizingString: fontSizeSampleString,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      key: ValueKey<String>(
          '$headlineFontSizeKey-${headlineProvider.id}-${bodyProvider.id}'),
      configKey: headlineFontSizeKey,
      initialValue: headlineProvider.value.fontSize!,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: headlineProvider.resize,
      style: bodyProvider.value,
      icon: Icons.text_fields_sharp,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
      sizingString: fontSizeSampleString,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      key: ValueKey<String>(
          '$titleFontSizeKey-${titleProvider.id}-${bodyProvider.id}'),
      configKey: titleFontSizeKey,
      initialValue: titleProvider.value.fontSize!,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: titleProvider.resize,
      style: bodyProvider.value,
      icon: Icons.text_fields_sharp,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
      sizingString: fontSizeSampleString,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      key: ValueKey<String>(
          '$bodyFontSizeKey-${bodyProvider.id}-${bodyProvider.id}'),
      configKey: bodyFontSizeKey,
      initialValue: bodyProvider.value.fontSize!,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: bodyProvider.resize,
      style: bodyProvider.value,
      icon: Icons.text_fields_sharp,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
      sizingString: fontSizeSampleString,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      key: ValueKey<String>(
          '$labelFontSizeKey-${labelProvider.id}-${bodyProvider.id}'),
      configKey: labelFontSizeKey,
      initialValue: labelProvider.value.fontSize!,
      min: minFontSize,
      max: maxFontSize,
      notifierCallback: labelProvider.resize,
      style: bodyProvider.value,
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
      key: ValueKey<String>('$displayBoldKey-${bodyProvider.id}'),
      configKey: displayBoldKey,
      notifierCallback: displayProvider.bold,
      size: bodyProvider.value.fontSize,
    ),
    TextSettingType.headline: EzBoldSetting(
      key: ValueKey<String>('$headlineBoldKey-${bodyProvider.id}'),
      configKey: headlineBoldKey,
      notifierCallback: headlineProvider.bold,
      size: bodyProvider.value.fontSize,
    ),
    TextSettingType.title: EzBoldSetting(
      key: ValueKey<String>('$titleBoldKey-${bodyProvider.id}'),
      configKey: titleBoldKey,
      notifierCallback: titleProvider.bold,
      size: bodyProvider.value.fontSize,
    ),
    TextSettingType.body: EzBoldSetting(
      key: ValueKey<String>('$bodyBoldKey-${bodyProvider.id}'),
      configKey: bodyBoldKey,
      notifierCallback: bodyProvider.bold,
      size: bodyProvider.value.fontSize,
    ),
    TextSettingType.label: EzBoldSetting(
      key: ValueKey<String>('$labelBoldKey-${bodyProvider.id}'),
      configKey: labelBoldKey,
      notifierCallback: labelProvider.bold,
      size: bodyProvider.value.fontSize,
    ),
  };

  /// Font style setting(s)
  late final Map<TextSettingType, EzItalicSetting> italicsControllers =
      <TextSettingType, EzItalicSetting>{
    TextSettingType.display: EzItalicSetting(
      key: ValueKey<String>('$displayItalicsKey-${bodyProvider.id}'),
      configKey: displayItalicsKey,
      notifierCallback: displayProvider.italic,
      size: bodyProvider.value.fontSize,
    ),
    TextSettingType.headline: EzItalicSetting(
      key: ValueKey<String>('$headlineItalicsKey-${bodyProvider.id}'),
      configKey: headlineItalicsKey,
      notifierCallback: headlineProvider.italic,
      size: bodyProvider.value.fontSize,
    ),
    TextSettingType.title: EzItalicSetting(
      key: ValueKey<String>('$titleItalicsKey-${bodyProvider.id}'),
      configKey: titleItalicsKey,
      notifierCallback: titleProvider.italic,
      size: bodyProvider.value.fontSize,
    ),
    TextSettingType.body: EzItalicSetting(
      key: ValueKey<String>('$bodyItalicsKey-${bodyProvider.id}'),
      configKey: bodyItalicsKey,
      notifierCallback: bodyProvider.italic,
      size: bodyProvider.value.fontSize,
    ),
    TextSettingType.label: EzItalicSetting(
      key: ValueKey<String>('$labelItalicsKey-${bodyProvider.id}'),
      configKey: labelItalicsKey,
      notifierCallback: labelProvider.italic,
      size: bodyProvider.value.fontSize,
    ),
  };

  /// Font decoration setting(s)
  late final Map<TextSettingType, EzUnderlineSetting> underlineControllers =
      <TextSettingType, EzUnderlineSetting>{
    TextSettingType.display: EzUnderlineSetting(
      key: ValueKey<String>('$displayUnderlinedKey-${bodyProvider.id}'),
      configKey: displayUnderlinedKey,
      notifierCallback: displayProvider.underline,
      size: bodyProvider.value.fontSize,
    ),
    TextSettingType.headline: EzUnderlineSetting(
      key: ValueKey<String>('$headlineUnderlinedKey-${bodyProvider.id}'),
      configKey: headlineUnderlinedKey,
      notifierCallback: headlineProvider.underline,
      size: bodyProvider.value.fontSize,
    ),
    TextSettingType.title: EzUnderlineSetting(
      key: ValueKey<String>('$titleUnderlinedKey-${bodyProvider.id}'),
      configKey: titleUnderlinedKey,
      notifierCallback: titleProvider.underline,
      size: bodyProvider.value.fontSize,
    ),
    TextSettingType.body: EzUnderlineSetting(
      key: ValueKey<String>('$bodyUnderlinedKey-${bodyProvider.id}'),
      configKey: bodyUnderlinedKey,
      notifierCallback: bodyProvider.underline,
      size: bodyProvider.value.fontSize,
    ),
    TextSettingType.label: EzUnderlineSetting(
      key: ValueKey<String>('$labelUnderlinedKey-${bodyProvider.id}'),
      configKey: labelUnderlinedKey,
      notifierCallback: labelProvider.underline,
      size: bodyProvider.value.fontSize,
    ),
  };

  /// Letter spacing setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting>
      letterSpacingControllers = <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: EzFontDoubleSetting(
      key: ValueKey<String>('$displayLetterSpacingKey-${bodyProvider.id}'),
      configKey: displayLetterSpacingKey,
      initialValue: displayProvider.value.letterSpacing!,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: displayProvider.setLetterSpacing,
      style: bodyProvider.value,
      icon: Icons.horizontal_distribute_sharp,
      tooltip: l10n.tsLetterSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      key: ValueKey<String>('$headlineLetterSpacingKey-${bodyProvider.id}'),
      configKey: headlineLetterSpacingKey,
      initialValue: headlineProvider.value.letterSpacing!,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: headlineProvider.setLetterSpacing,
      style: bodyProvider.value,
      icon: Icons.horizontal_distribute_sharp,
      tooltip: l10n.tsLetterSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      key: ValueKey<String>('$titleLetterSpacingKey-${bodyProvider.id}'),
      configKey: titleLetterSpacingKey,
      initialValue: titleProvider.value.letterSpacing!,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: titleProvider.setLetterSpacing,
      style: bodyProvider.value,
      icon: Icons.horizontal_distribute_sharp,
      tooltip: l10n.tsLetterSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      key: ValueKey<String>('$bodyLetterSpacingKey-${bodyProvider.id}'),
      configKey: bodyLetterSpacingKey,
      initialValue: bodyProvider.value.letterSpacing!,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: bodyProvider.setLetterSpacing,
      style: bodyProvider.value,
      icon: Icons.horizontal_distribute_sharp,
      tooltip: l10n.tsLetterSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      key: ValueKey<String>('$labelLetterSpacingKey-${bodyProvider.id}'),
      configKey: labelLetterSpacingKey,
      initialValue: labelProvider.value.letterSpacing!,
      min: minFontLetterSpacing,
      max: maxFontLetterSpacing,
      notifierCallback: labelProvider.setLetterSpacing,
      style: bodyProvider.value,
      icon: Icons.horizontal_distribute_sharp,
      tooltip: l10n.tsLetterSpacing,
      sizingString: fontSpacingSampleString,
    ),
  };

  /// Word spacing setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting> wordSpacingControllers =
      <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: EzFontDoubleSetting(
      key: ValueKey<String>('$displayWordSpacingKey-${bodyProvider.id}'),
      configKey: displayWordSpacingKey,
      initialValue: displayProvider.value.wordSpacing!,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: displayProvider.setWordSpacing,
      style: bodyProvider.value,
      icon: Icons.space_bar_sharp,
      tooltip: l10n.tsWordSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      key: ValueKey<String>('$headlineWordSpacingKey-${bodyProvider.id}'),
      configKey: headlineWordSpacingKey,
      initialValue: headlineProvider.value.wordSpacing!,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: headlineProvider.setWordSpacing,
      style: bodyProvider.value,
      icon: Icons.space_bar_sharp,
      tooltip: l10n.tsWordSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      key: ValueKey<String>('$titleWordSpacingKey-${bodyProvider.id}'),
      configKey: titleWordSpacingKey,
      initialValue: titleProvider.value.wordSpacing!,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: titleProvider.setWordSpacing,
      style: bodyProvider.value,
      icon: Icons.space_bar_sharp,
      tooltip: l10n.tsWordSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      key: ValueKey<String>('$bodyWordSpacingKey-${bodyProvider.id}'),
      configKey: bodyWordSpacingKey,
      initialValue: bodyProvider.value.wordSpacing!,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: bodyProvider.setWordSpacing,
      style: bodyProvider.value,
      icon: Icons.space_bar_sharp,
      tooltip: l10n.tsWordSpacing,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      key: ValueKey<String>('$labelWordSpacingKey-${bodyProvider.id}'),
      configKey: labelWordSpacingKey,
      initialValue: labelProvider.value.wordSpacing!,
      min: minFontWordSpacing,
      max: maxFontWordSpacing,
      notifierCallback: labelProvider.setWordSpacing,
      style: bodyProvider.value,
      icon: Icons.space_bar_sharp,
      tooltip: l10n.tsWordSpacing,
      sizingString: fontSpacingSampleString,
    ),
  };

  /// Line height setting(s)
  late final Map<TextSettingType, EzFontDoubleSetting> lineHeightControllers =
      <TextSettingType, EzFontDoubleSetting>{
    TextSettingType.display: EzFontDoubleSetting(
      key: ValueKey<String>('$displayFontHeightKey-${bodyProvider.id}'),
      configKey: displayFontHeightKey,
      initialValue: displayProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: displayProvider.setHeight,
      style: bodyProvider.value,
      icon: Icons.format_line_spacing_sharp,
      tooltip: l10n.tsLineHeight,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.headline: EzFontDoubleSetting(
      key: ValueKey<String>('$headlineFontHeightKey-${bodyProvider.id}'),
      configKey: headlineFontHeightKey,
      initialValue: headlineProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: headlineProvider.setHeight,
      style: bodyProvider.value,
      icon: Icons.format_line_spacing_sharp,
      tooltip: l10n.tsLineHeight,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.title: EzFontDoubleSetting(
      key: ValueKey<String>('$titleFontHeightKey-${bodyProvider.id}'),
      configKey: titleFontHeightKey,
      initialValue: titleProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: titleProvider.setHeight,
      style: bodyProvider.value,
      icon: Icons.format_line_spacing_sharp,
      tooltip: l10n.tsLineHeight,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.body: EzFontDoubleSetting(
      key: ValueKey<String>('$bodyFontHeightKey-${bodyProvider.id}'),
      configKey: bodyFontHeightKey,
      initialValue: bodyProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: bodyProvider.setHeight,
      style: bodyProvider.value,
      icon: Icons.format_line_spacing_sharp,
      tooltip: l10n.tsLineHeight,
      sizingString: fontSpacingSampleString,
    ),
    TextSettingType.label: EzFontDoubleSetting(
      key: ValueKey<String>('$labelFontHeightKey-${bodyProvider.id}'),
      configKey: labelFontHeightKey,
      initialValue: labelProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: labelProvider.setHeight,
      style: bodyProvider.value,
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
