/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Enumerator for selecting which [TextStyle] is being updated
enum EzTextSettingType { display, headline, title, body, label }

class EzTextSettings extends StatelessWidget {
  /// [EzScreen.useImageDecoration] passthrough
  final bool useImageDecoration;

  /// Optional starting [EzTSType] target
  final EzTSType? target;

  /// Spacer above the [EzResetButton]
  final Widget resetSpacer;

  /// Whether the text background opacity (quick) setting should be shown
  final bool showOpacity;

  /// Whether the onSurfaceColor (quick) setting should be shown
  final bool showOnSurface;

  /// Spacer below the default quick settings if [moreQuickSettings] is present
  final Widget quickSettingsSpacer;

  /// Optional additional quick settings
  /// Will appear just below the default quick settings
  final List<Widget>? moreQuickSettings;

  /// Whether the [TextStyle] spacing controls should be shown in the advanced tab
  /// [TextStyle.letterSpacing], [TextStyle.wordSpacing], and [TextStyle.height]
  final bool showSpacing;

  /// Empathetech text settings
  /// Recommended to use as a [Scaffold.body]
  const EzTextSettings({
    // Shared
    super.key,
    this.useImageDecoration = true,
    this.target,
    this.resetSpacer = const EzSeparator(),

    // Quick
    this.showOpacity = true,
    this.showOnSurface = true,
    this.quickSettingsSpacer = const EzSeparator(),
    this.moreQuickSettings,

    // Advanced
    this.showSpacing = true,
  });

  // Set the page title //

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.onSurface;

    return MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<EzDisplayStyleProvider>(
          create: (_) => EzDisplayStyleProvider(textColor),
        ),
        ChangeNotifierProvider<EzHeadlineStyleProvider>(
          create: (_) => EzHeadlineStyleProvider(textColor),
        ),
        ChangeNotifierProvider<EzTitleStyleProvider>(
          create: (_) => EzTitleStyleProvider(textColor),
        ),
        ChangeNotifierProvider<EzBodyStyleProvider>(
          create: (_) => EzBodyStyleProvider(textColor),
        ),
        ChangeNotifierProvider<EzLabelStyleProvider>(
          create: (_) => EzLabelStyleProvider(textColor),
        ),
      ],
      child: _TextSettings(
        useImageDecoration: useImageDecoration,
        target: target,
        resetSpacer: resetSpacer,
        showOpacity: showOpacity,
        showOnSurface: showOnSurface,
        quickSettingsSpacer: quickSettingsSpacer,
        moreQuickSettings: moreQuickSettings,
        showSpacing: showSpacing,
      ),
    );
  }
}

class _TextSettings extends StatefulWidget {
  final bool useImageDecoration;
  final EzTSType? target;
  final Widget resetSpacer;
  final bool showOpacity;
  final bool showOnSurface;
  final Widget quickSettingsSpacer;
  final List<Widget>? moreQuickSettings;
  final bool showSpacing;

  const _TextSettings({
    // Shared
    required this.useImageDecoration,
    required this.target,
    required this.resetSpacer,

    // Quick
    required this.showOpacity,
    required this.showOnSurface,
    required this.quickSettingsSpacer,
    required this.moreQuickSettings,

    // Advanced
    required this.showSpacing,
  });

  @override
  State<_TextSettings> createState() => _TextSettingsState();
}

class _TextSettingsState extends State<_TextSettings> {
  // Gather the theme data //

  final double margin = EzConfig.get(marginKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EFUILang l10n = ezL10n(context);

  // Define the build data //

  late EzTSType currentTab = widget.target ??
      (EzConfig.get(advancedTextKey) == true
          ? EzTSType.advanced
          : EzTSType.quick);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, l10n.tsPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScreen(
      useImageDecoration: widget.useImageDecoration,
      child: EzScrollView(
        children: <Widget>[
          if (spacing > margin) EzSpacer(space: spacing - margin),

          // Mode selector
          SegmentedButton<EzTSType>(
            segments: <ButtonSegment<EzTSType>>[
              ButtonSegment<EzTSType>(
                value: EzTSType.quick,
                label: Text(l10n.gQuick),
              ),
              ButtonSegment<EzTSType>(
                value: EzTSType.advanced,
                label: Text(l10n.gAdvanced),
              ),
            ],
            selected: <EzTSType>{currentTab},
            showSelectedIcon: false,
            onSelectionChanged: (Set<EzTSType> selected) async {
              switch (selected.first) {
                case EzTSType.quick:
                  currentTab = EzTSType.quick;
                  await EzConfig.setBool(advancedTextKey, false);
                  break;
                case EzTSType.advanced:
                  currentTab = EzTSType.advanced;
                  await EzConfig.setBool(advancedTextKey, true);
                  break;
              }
              setState(() {});
            },
          ),
          const EzSpacer(),

          // Settings
          if (currentTab == EzTSType.quick)
            _QuickTextSettings(
              resetSpacer: widget.resetSpacer,
              showOpacity: widget.showOpacity,
              showOnSurface: widget.showOnSurface,
              quickSettingsSpacer: widget.quickSettingsSpacer,
              moreQuickSettings: widget.moreQuickSettings,
            )
          else
            _AdvancedTextSettings(
              resetSpacer: widget.resetSpacer,
              showSpacing: widget.showSpacing,
            ),
        ],
      ),
    );
  }
}

class _QuickTextSettings extends StatefulWidget {
  final Widget resetSpacer;
  final bool showOpacity;
  final bool showOnSurface;
  final Widget quickSettingsSpacer;
  final List<Widget>? moreQuickSettings;

  const _QuickTextSettings({
    required this.resetSpacer,
    required this.showOpacity,
    required this.showOnSurface,
    required this.quickSettingsSpacer,
    required this.moreQuickSettings,
  });

  @override
  State<_QuickTextSettings> createState() => _QuickTextSettingsState();
}

class _QuickTextSettingsState extends State<_QuickTextSettings> {
  // Gather the theme data //

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();

  late final EdgeInsets colMargin = EzInsets.col(EzConfig.get(marginKey));

  late final EFUILang l10n = ezL10n(context);

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;
  late final Color surface = Theme.of(context).colorScheme.surface;

  // Gather the build data //

  late final EzDisplayStyleProvider displayProvider =
      Provider.of<EzDisplayStyleProvider>(context);
  late final EzHeadlineStyleProvider headlineProvider =
      Provider.of<EzHeadlineStyleProvider>(context);
  late final EzTitleStyleProvider titleProvider =
      Provider.of<EzTitleStyleProvider>(context);
  late final EzBodyStyleProvider bodyProvider =
      Provider.of<EzBodyStyleProvider>(context);
  late final EzLabelStyleProvider labelProvider =
      Provider.of<EzLabelStyleProvider>(context);

  late final String oKey = isDarkTheme(context)
      ? darkTextBackgroundOpacityKey
      : lightTextBackgroundOpacityKey;

  late double currOpacity =
      EzConfig.get(oKey) ?? EzConfig.getDefault(oKey) ?? defaultTextOpacity;

  late Color backgroundColor = surface.withValues(alpha: currOpacity);

  late double currIconSize = EzConfig.get(iconSizeKey) ??
      EzConfig.getDefault(iconSizeKey) ??
      defaultIconSize;

  static const double iconDelta = 2.0;
  final EzSpacer pMSpacer = EzMargin(vertical: false);

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Required batch settings
        EzRowCol.sym(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Font family
            EzFontFamilyBatchSetting(key: UniqueKey(), iconSize: currIconSize),
            const EzSwapSpacer(),

            // Font size
            EzTextBackground(
              EzFontDoubleBatchSetting(
                key: UniqueKey(),
                iconSize: currIconSize,
              ),
              backgroundColor: backgroundColor,
              borderRadius: ezPillShape,
            ),
          ],
        ),

        // Optional additional settings
        // if (widget.additionalSettings != null) ...<Widget>[
        //   spacer,
        //   ...widget.additionalSettings!,
        // ],
        separator,

        // Display preview
        EzTextBackground(
          Text(
            l10n.tsDisplayP1 + l10n.tsDisplayLink + l10n.tsDisplayP2,
            textAlign: TextAlign.center,
            style: displayProvider.value,
          ),
          backgroundColor: backgroundColor,
          margin: colMargin,
        ),
        spacer,

        // Headline preview
        EzTextBackground(
          Text(
            l10n.tsHeadlineP1 + l10n.tsHeadlineLink + l10n.tsHeadlineP2,
            textAlign: TextAlign.center,
            style: headlineProvider.value,
          ),
          backgroundColor: backgroundColor,
          margin: colMargin,
        ),
        spacer,

        // Title preview
        EzTextBackground(
          Text(
            l10n.tsTitleP1 + l10n.tsTitleLink,
            textAlign: TextAlign.center,
            style: titleProvider.value,
          ),
          backgroundColor: backgroundColor,
          margin: colMargin,
        ),
        spacer,

        // Body preview
        EzTextBackground(
          Text(
            l10n.tsBodyP1 + l10n.tsBodyLink + l10n.tsBodyP2,
            textAlign: TextAlign.center,
            style: bodyProvider.value,
          ),
          backgroundColor: backgroundColor,
          margin: colMargin,
        ),
        spacer,

        // Label preview
        EzTextBackground(
          Text(
            l10n.tsLabelP1 + l10n.tsLabelLink + l10n.tsLabelP2,
            textAlign: TextAlign.center,
            style: labelProvider.value,
          ),
          backgroundColor: backgroundColor,
          margin: colMargin,
        ),
        separator,

        if (widget.showOpacity) ...<Widget>[
          // Text background opacity
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
            child: Slider(
              // Slider values
              value: currOpacity,
              min: minOpacity,
              max: maxOpacity,
              divisions: 20,
              label: currOpacity.toStringAsFixed(2),

              // Slider functions
              onChanged: (double value) {
                setState(() {
                  currOpacity = value;
                  backgroundColor = surface.withValues(alpha: currOpacity);
                });
              },
              onChangeEnd: (double value) async {
                await EzConfig.setDouble(oKey, value);
              },

              // Slider semantics
              semanticFormatterCallback: (double value) =>
                  value.toStringAsFixed(2),
            ),
          ),
          EzTextBackground(
            Text(
              l10n.tsTextBackground,
              style: labelProvider.value,
              textAlign: TextAlign.center,
            ),
            backgroundColor: backgroundColor,
            margin: colMargin,
          ),
          separator,
        ],

        // Icon size
        Tooltip(
          message: l10n.tsIconSize,
          child: EzTextBackground(
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Minus
                (currIconSize > minIconSize)
                    ? EzIconButton(
                        onPressed: () async {
                          currIconSize -= iconDelta;
                          await EzConfig.setDouble(iconSizeKey, currIconSize);
                          setState(() {});
                        },
                        tooltip:
                            '${l10n.gDecrease} ${l10n.tsIconSize.toLowerCase()}',
                        iconSize: currIconSize,
                        icon: Icon(PlatformIcons(context).remove),
                      )
                    : EzIconButton(
                        enabled: false,
                        tooltip: l10n.gMinimum,
                        iconSize: currIconSize,
                        icon: Icon(
                          PlatformIcons(context).remove,
                          color: colorScheme.outline,
                        ),
                      ),
                pMSpacer,

                // Preview
                Icon(
                  Icons.sync_alt,
                  size: currIconSize,
                  color: colorScheme.onSurface,
                ),
                pMSpacer,

                // Plus
                (currIconSize < maxIconSize)
                    ? EzIconButton(
                        onPressed: () async {
                          currIconSize += iconDelta;
                          await EzConfig.setDouble(iconSizeKey, currIconSize);
                          setState(() {});
                        },
                        tooltip:
                            '${l10n.gIncrease} ${l10n.tsIconSize.toLowerCase()}',
                        iconSize: currIconSize,
                        icon: Icon(PlatformIcons(context).add),
                      )
                    : EzIconButton(
                        enabled: false,
                        tooltip: l10n.gMaximum,
                        iconSize: currIconSize,
                        icon: Icon(
                          PlatformIcons(context).add,
                          color: colorScheme.outline,
                        ),
                      ),
              ],
            ),
            backgroundColor: backgroundColor,
            borderRadius: ezPillShape,
          ),
        ),
        separator,

        // Reset all
        EzResetButton(
          dialogTitle: l10n.tsResetAll,
          onConfirm: () async {
            await EzConfig.removeKeys(textStyleKeys.keys.toSet());
            displayProvider.reset();
            headlineProvider.reset();
            titleProvider.reset();
            bodyProvider.reset();
            labelProvider.reset();

            currOpacity = EzConfig.getDefault(oKey) ?? defaultTextOpacity;
            backgroundColor = surface.withValues(alpha: currOpacity);

            currIconSize = EzConfig.getDefault(iconSizeKey) ?? defaultIconSize;

            setState(() {});
          },
        ),
        separator,
      ],
    );
  }
}

class _AdvancedTextSettings extends StatefulWidget {
  final Widget resetSpacer;
  final bool showSpacing;

  const _AdvancedTextSettings({
    required this.resetSpacer,
    required this.showSpacing,
  });

  @override
  State<_AdvancedTextSettings> createState() => _AdvancedTextSettingsState();
}

class _AdvancedTextSettingsState extends State<_AdvancedTextSettings> {
  // Gather the theme data //

  static const EzSpacer spacer = EzSpacer();
  static const EzSpacer rowSpacer = EzSpacer(vertical: false);
  static const EzSwapSpacer swapSpacer =
      EzSwapSpacer(breakpoint: ScreenSize.medium);
  static const EzSeparator separator = EzSeparator();

  final double margin = EzConfig.get(marginKey);

  late final ButtonStyle menuButtonStyle = TextButton.styleFrom(
    padding: EzInsets.wrap(EzConfig.get(paddingKey)),
  );
  late final EdgeInsets colMargin = EzInsets.col(margin);

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  late final EFUILang l10n = ezL10n(context);

  // Gather the build data //

  EzTextSettingType editing = EzTextSettingType.display;

  late final EzDisplayStyleProvider displayProvider =
      Provider.of<EzDisplayStyleProvider>(context);
  late final EzHeadlineStyleProvider headlineProvider =
      Provider.of<EzHeadlineStyleProvider>(context);
  late final EzTitleStyleProvider titleProvider =
      Provider.of<EzTitleStyleProvider>(context);
  late final EzBodyStyleProvider bodyProvider =
      Provider.of<EzBodyStyleProvider>(context);
  late final EzLabelStyleProvider labelProvider =
      Provider.of<EzLabelStyleProvider>(context);

  late final String display = l10n.tsDisplay.toLowerCase();
  late final String headline = l10n.tsHeadline.toLowerCase();
  late final String title = l10n.tsTitle.toLowerCase();
  late final String body = l10n.tsBody.toLowerCase();
  late final String label = l10n.tsLabel.toLowerCase();

  late final List<DropdownMenuEntry<EzTextSettingType>> styleChoices =
      <DropdownMenuEntry<EzTextSettingType>>[
    DropdownMenuEntry<EzTextSettingType>(
      value: EzTextSettingType.display,
      label: display,
      style: menuButtonStyle,
    ),
    DropdownMenuEntry<EzTextSettingType>(
      value: EzTextSettingType.headline,
      label: headline,
      style: menuButtonStyle,
    ),
    DropdownMenuEntry<EzTextSettingType>(
      value: EzTextSettingType.title,
      label: title,
      style: menuButtonStyle,
    ),
    DropdownMenuEntry<EzTextSettingType>(
      value: EzTextSettingType.body,
      label: body,
      style: menuButtonStyle,
    ),
    DropdownMenuEntry<EzTextSettingType>(
      value: EzTextSettingType.label,
      label: label,
      style: menuButtonStyle,
    ),
  ];

  // Define the setting controllers //

  late final Widget fontSizeIcon = EzTextBackground(
    Icon(
      Icons.text_fields_sharp,
      color: colorScheme.onSurface,
      size: labelProvider.value.fontSize,
    ),
    borderRadius: textFieldRadius,
  );

  late final Widget letterSpacingIcon = EzTextBackground(
    Icon(
      Icons.horizontal_distribute_sharp,
      color: colorScheme.onSurface,
      size: labelProvider.value.fontSize,
    ),
    borderRadius: textFieldRadius,
  );

  late final Widget wordSpacingIcon = EzTextBackground(
    Icon(
      Icons.space_bar_sharp,
      color: colorScheme.onSurface,
      size: labelProvider.value.fontSize,
    ),
    borderRadius: textFieldRadius,
  );

  late final Widget lineHeightIcon = EzTextBackground(
    Icon(
      Icons.format_line_spacing_sharp,
      color: colorScheme.onSurface,
      size: labelProvider.value.fontSize,
    ),
    borderRadius: textFieldRadius,
  );

  /// Font family setting(s)
  late final Map<EzTextSettingType, EzFontFamilySetting> familyControllers =
      <EzTextSettingType, EzFontFamilySetting>{
    EzTextSettingType.display: EzFontFamilySetting(
      key: UniqueKey(),
      configKey: displayFontFamilyKey,
      provider: displayProvider,
      baseStyle: bodyProvider.value,
    ),
    EzTextSettingType.headline: EzFontFamilySetting(
      key: UniqueKey(),
      configKey: headlineFontFamilyKey,
      provider: headlineProvider,
      baseStyle: bodyProvider.value,
    ),
    EzTextSettingType.title: EzFontFamilySetting(
      key: UniqueKey(),
      configKey: titleFontFamilyKey,
      provider: titleProvider,
      baseStyle: bodyProvider.value,
    ),
    EzTextSettingType.body: EzFontFamilySetting(
      key: UniqueKey(),
      configKey: bodyFontFamilyKey,
      provider: bodyProvider,
      baseStyle: bodyProvider.value,
    ),
    EzTextSettingType.label: EzFontFamilySetting(
      key: UniqueKey(),
      configKey: labelFontFamilyKey,
      provider: labelProvider,
      baseStyle: bodyProvider.value,
    ),
  };

  /// Font size setting(s)
  late final Map<EzTextSettingType, Widget> sizeControllers =
      <EzTextSettingType, Widget>{
    EzTextSettingType.display: EzFontDoubleSetting(
      key: ValueKey<String>('$displayFontSizeKey-${displayProvider.id}'),
      configKey: displayFontSizeKey,
      initialValue: displayProvider.value.fontSize!,
      min: minDisplay,
      max: maxDisplay,
      notifierCallback: displayProvider.resize,
      style: bodyProvider.value,
      icon: fontSizeIcon,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
    ),
    EzTextSettingType.headline: EzFontDoubleSetting(
      key: ValueKey<String>('$headlineFontSizeKey-${headlineProvider.id}'),
      configKey: headlineFontSizeKey,
      initialValue: headlineProvider.value.fontSize!,
      min: minHeadline,
      max: maxHeadline,
      notifierCallback: headlineProvider.resize,
      style: bodyProvider.value,
      icon: fontSizeIcon,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
    ),
    EzTextSettingType.title: EzFontDoubleSetting(
      key: ValueKey<String>('$titleFontSizeKey-${titleProvider.id}'),
      configKey: titleFontSizeKey,
      initialValue: titleProvider.value.fontSize!,
      min: minTitle,
      max: maxTitle,
      notifierCallback: titleProvider.resize,
      style: bodyProvider.value,
      icon: fontSizeIcon,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
    ),
    EzTextSettingType.body: EzFontDoubleSetting(
      key: ValueKey<String>('$bodyFontSizeKey-${bodyProvider.id}'),
      configKey: bodyFontSizeKey,
      initialValue: bodyProvider.value.fontSize!,
      min: minBody,
      max: maxBody,
      notifierCallback: bodyProvider.resize,
      style: bodyProvider.value,
      icon: fontSizeIcon,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
    ),
    EzTextSettingType.label: EzFontDoubleSetting(
      key: ValueKey<String>('$labelFontSizeKey-${labelProvider.id}'),
      configKey: labelFontSizeKey,
      initialValue: labelProvider.value.fontSize!,
      min: minLabel,
      max: maxLabel,
      notifierCallback: labelProvider.resize,
      style: bodyProvider.value,
      icon: fontSizeIcon,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
    ),
  };

  /// Font weight setting(s)
  late final Map<EzTextSettingType, EzBoldSetting> boldControllers =
      <EzTextSettingType, EzBoldSetting>{
    EzTextSettingType.display: EzBoldSetting(
      key: ValueKey<String>('$displayBoldedKey-${displayProvider.id}'),
      configKey: displayBoldedKey,
      notifierCallback: displayProvider.bold,
      size: titleProvider.value.fontSize,
    ),
    EzTextSettingType.headline: EzBoldSetting(
      key: ValueKey<String>('$headlineBoldedKey-${headlineProvider.id}'),
      configKey: headlineBoldedKey,
      notifierCallback: headlineProvider.bold,
      size: titleProvider.value.fontSize,
    ),
    EzTextSettingType.title: EzBoldSetting(
      key: ValueKey<String>('$titleBoldedKey-${titleProvider.id}'),
      configKey: titleBoldedKey,
      notifierCallback: titleProvider.bold,
      size: titleProvider.value.fontSize,
    ),
    EzTextSettingType.body: EzBoldSetting(
      key: ValueKey<String>('$bodyBoldedKey-${bodyProvider.id}'),
      configKey: bodyBoldedKey,
      notifierCallback: bodyProvider.bold,
      size: titleProvider.value.fontSize,
    ),
    EzTextSettingType.label: EzBoldSetting(
      key: ValueKey<String>('$labelBoldedKey-${labelProvider.id}'),
      configKey: labelBoldedKey,
      notifierCallback: labelProvider.bold,
      size: titleProvider.value.fontSize,
    ),
  };

  /// Font style setting(s)
  late final Map<EzTextSettingType, EzItalicSetting> italicsControllers =
      <EzTextSettingType, EzItalicSetting>{
    EzTextSettingType.display: EzItalicSetting(
      key: ValueKey<String>('$displayItalicizedKey-${displayProvider.id}'),
      configKey: displayItalicizedKey,
      notifierCallback: displayProvider.italic,
      size: titleProvider.value.fontSize,
    ),
    EzTextSettingType.headline: EzItalicSetting(
      key: ValueKey<String>('$headlineItalicizedKey-${headlineProvider.id}'),
      configKey: headlineItalicizedKey,
      notifierCallback: headlineProvider.italic,
      size: titleProvider.value.fontSize,
    ),
    EzTextSettingType.title: EzItalicSetting(
      key: ValueKey<String>('$titleItalicizedKey-${titleProvider.id}'),
      configKey: titleItalicizedKey,
      notifierCallback: titleProvider.italic,
      size: titleProvider.value.fontSize,
    ),
    EzTextSettingType.body: EzItalicSetting(
      key: ValueKey<String>('$bodyItalicizedKey-${bodyProvider.id}'),
      configKey: bodyItalicizedKey,
      notifierCallback: bodyProvider.italic,
      size: titleProvider.value.fontSize,
    ),
    EzTextSettingType.label: EzItalicSetting(
      key: ValueKey<String>('$labelItalicizedKey-${labelProvider.id}'),
      configKey: labelItalicizedKey,
      notifierCallback: labelProvider.italic,
      size: titleProvider.value.fontSize,
    ),
  };

  /// Font decoration setting(s)
  late final Map<EzTextSettingType, EzUnderlineSetting> underlineControllers =
      <EzTextSettingType, EzUnderlineSetting>{
    EzTextSettingType.display: EzUnderlineSetting(
      key: ValueKey<String>('$displayUnderlinedKey-${displayProvider.id}'),
      configKey: displayUnderlinedKey,
      notifierCallback: displayProvider.underline,
      size: titleProvider.value.fontSize,
    ),
    EzTextSettingType.headline: EzUnderlineSetting(
      key: ValueKey<String>('$headlineUnderlinedKey-${headlineProvider.id}'),
      configKey: headlineUnderlinedKey,
      notifierCallback: headlineProvider.underline,
      size: titleProvider.value.fontSize,
    ),
    EzTextSettingType.title: EzUnderlineSetting(
      key: ValueKey<String>('$titleUnderlinedKey-${titleProvider.id}'),
      configKey: titleUnderlinedKey,
      notifierCallback: titleProvider.underline,
      size: titleProvider.value.fontSize,
    ),
    EzTextSettingType.body: EzUnderlineSetting(
      key: ValueKey<String>('$bodyUnderlinedKey-${bodyProvider.id}'),
      configKey: bodyUnderlinedKey,
      notifierCallback: bodyProvider.underline,
      size: titleProvider.value.fontSize,
    ),
    EzTextSettingType.label: EzUnderlineSetting(
      key: ValueKey<String>('$labelUnderlinedKey-${labelProvider.id}'),
      configKey: labelUnderlinedKey,
      notifierCallback: labelProvider.underline,
      size: titleProvider.value.fontSize,
    ),
  };

  /// Letter spacing setting(s)
  late final Map<EzTextSettingType, EzFontDoubleSetting>
      letterSpacingControllers = <EzTextSettingType, EzFontDoubleSetting>{
    EzTextSettingType.display: EzFontDoubleSetting(
      key: ValueKey<String>('$displayLetterSpacingKey-${displayProvider.id}'),
      configKey: displayLetterSpacingKey,
      initialValue: displayProvider.value.letterSpacing!,
      min: minLetterSpacing,
      max: maxLetterSpacing,
      notifierCallback: displayProvider.setLetterSpacing,
      style: bodyProvider.value,
      icon: letterSpacingIcon,
      tooltip: l10n.tsLetterSpacing,
    ),
    EzTextSettingType.headline: EzFontDoubleSetting(
      key: ValueKey<String>('$headlineLetterSpacingKey-${headlineProvider.id}'),
      configKey: headlineLetterSpacingKey,
      initialValue: headlineProvider.value.letterSpacing!,
      min: minLetterSpacing,
      max: maxLetterSpacing,
      notifierCallback: headlineProvider.setLetterSpacing,
      style: bodyProvider.value,
      icon: letterSpacingIcon,
      tooltip: l10n.tsLetterSpacing,
    ),
    EzTextSettingType.title: EzFontDoubleSetting(
      key: ValueKey<String>('$titleLetterSpacingKey-${titleProvider.id}'),
      configKey: titleLetterSpacingKey,
      initialValue: titleProvider.value.letterSpacing!,
      min: minLetterSpacing,
      max: maxLetterSpacing,
      notifierCallback: titleProvider.setLetterSpacing,
      style: bodyProvider.value,
      icon: letterSpacingIcon,
      tooltip: l10n.tsLetterSpacing,
    ),
    EzTextSettingType.body: EzFontDoubleSetting(
      key: ValueKey<String>('$bodyLetterSpacingKey-${bodyProvider.id}'),
      configKey: bodyLetterSpacingKey,
      initialValue: bodyProvider.value.letterSpacing!,
      min: minLetterSpacing,
      max: maxLetterSpacing,
      notifierCallback: bodyProvider.setLetterSpacing,
      style: bodyProvider.value,
      icon: letterSpacingIcon,
      tooltip: l10n.tsLetterSpacing,
    ),
    EzTextSettingType.label: EzFontDoubleSetting(
      key: ValueKey<String>('$labelLetterSpacingKey-${labelProvider.id}'),
      configKey: labelLetterSpacingKey,
      initialValue: labelProvider.value.letterSpacing!,
      min: minLetterSpacing,
      max: maxLetterSpacing,
      notifierCallback: labelProvider.setLetterSpacing,
      style: bodyProvider.value,
      icon: letterSpacingIcon,
      tooltip: l10n.tsLetterSpacing,
    ),
  };

  /// Word spacing setting(s)
  late final Map<EzTextSettingType, EzFontDoubleSetting>
      wordSpacingControllers = <EzTextSettingType, EzFontDoubleSetting>{
    EzTextSettingType.display: EzFontDoubleSetting(
      key: ValueKey<String>('$displayWordSpacingKey-${displayProvider.id}'),
      configKey: displayWordSpacingKey,
      initialValue: displayProvider.value.wordSpacing!,
      min: minWordSpacing,
      max: maxWordSpacing,
      notifierCallback: displayProvider.setWordSpacing,
      style: bodyProvider.value,
      icon: wordSpacingIcon,
      tooltip: l10n.tsWordSpacing,
    ),
    EzTextSettingType.headline: EzFontDoubleSetting(
      key: ValueKey<String>('$headlineWordSpacingKey-${headlineProvider.id}'),
      configKey: headlineWordSpacingKey,
      initialValue: headlineProvider.value.wordSpacing!,
      min: minWordSpacing,
      max: maxWordSpacing,
      notifierCallback: headlineProvider.setWordSpacing,
      style: bodyProvider.value,
      icon: wordSpacingIcon,
      tooltip: l10n.tsWordSpacing,
    ),
    EzTextSettingType.title: EzFontDoubleSetting(
      key: ValueKey<String>('$titleWordSpacingKey-${titleProvider.id}'),
      configKey: titleWordSpacingKey,
      initialValue: titleProvider.value.wordSpacing!,
      min: minWordSpacing,
      max: maxWordSpacing,
      notifierCallback: titleProvider.setWordSpacing,
      style: bodyProvider.value,
      icon: wordSpacingIcon,
      tooltip: l10n.tsWordSpacing,
    ),
    EzTextSettingType.body: EzFontDoubleSetting(
      key: ValueKey<String>('$bodyWordSpacingKey-${bodyProvider.id}'),
      configKey: bodyWordSpacingKey,
      initialValue: bodyProvider.value.wordSpacing!,
      min: minWordSpacing,
      max: maxWordSpacing,
      notifierCallback: bodyProvider.setWordSpacing,
      style: bodyProvider.value,
      icon: wordSpacingIcon,
      tooltip: l10n.tsWordSpacing,
    ),
    EzTextSettingType.label: EzFontDoubleSetting(
      key: ValueKey<String>('$labelWordSpacingKey-${labelProvider.id}'),
      configKey: labelWordSpacingKey,
      initialValue: labelProvider.value.wordSpacing!,
      min: minWordSpacing,
      max: maxWordSpacing,
      notifierCallback: labelProvider.setWordSpacing,
      style: bodyProvider.value,
      icon: wordSpacingIcon,
      tooltip: l10n.tsWordSpacing,
    ),
  };

  /// Line height setting(s)
  late final Map<EzTextSettingType, EzFontDoubleSetting> lineHeightControllers =
      <EzTextSettingType, EzFontDoubleSetting>{
    EzTextSettingType.display: EzFontDoubleSetting(
      key: ValueKey<String>('$displayFontHeightKey-${displayProvider.id}'),
      configKey: displayFontHeightKey,
      initialValue: displayProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: displayProvider.setHeight,
      style: bodyProvider.value,
      icon: lineHeightIcon,
      tooltip: l10n.tsLineHeight,
    ),
    EzTextSettingType.headline: EzFontDoubleSetting(
      key: ValueKey<String>('$headlineFontHeightKey-${headlineProvider.id}'),
      configKey: headlineFontHeightKey,
      initialValue: headlineProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: headlineProvider.setHeight,
      style: bodyProvider.value,
      icon: lineHeightIcon,
      tooltip: l10n.tsLineHeight,
    ),
    EzTextSettingType.title: EzFontDoubleSetting(
      key: ValueKey<String>('$titleFontHeightKey-${titleProvider.id}'),
      configKey: titleFontHeightKey,
      initialValue: titleProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: titleProvider.setHeight,
      style: bodyProvider.value,
      icon: lineHeightIcon,
      tooltip: l10n.tsLineHeight,
    ),
    EzTextSettingType.body: EzFontDoubleSetting(
      key: ValueKey<String>('$bodyFontHeightKey-${bodyProvider.id}'),
      configKey: bodyFontHeightKey,
      initialValue: bodyProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: bodyProvider.setHeight,
      style: bodyProvider.value,
      icon: lineHeightIcon,
      tooltip: l10n.tsLineHeight,
    ),
    EzTextSettingType.label: EzFontDoubleSetting(
      key: ValueKey<String>('$labelFontHeightKey-${labelProvider.id}'),
      configKey: labelFontHeightKey,
      initialValue: labelProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: labelProvider.setHeight,
      style: bodyProvider.value,
      icon: lineHeightIcon,
      tooltip: l10n.tsLineHeight,
    ),
  };

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Style selector
        EzScrollView(
          scrollDirection: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          primary: false,
          children: <Widget>[
            EzText(
              l10n.gEditing,
              style: labelProvider.value,
              textAlign: TextAlign.center,
            ),
            EzMargin(),
            EzDropdownMenu<EzTextSettingType>(
              widthEntries: styleChoices
                  .map(
                      (DropdownMenuEntry<EzTextSettingType> type) => type.label)
                  .toList(),
              textStyle: labelProvider.value,
              dropdownMenuEntries: styleChoices,
              enableSearch: false,
              initialSelection: editing,
              onSelected: (EzTextSettingType? value) {
                if (value != null) setState(() => editing = value);
              },
            ),
          ],
        ),
        spacer,

        // Controls
        EzRowCol.sym(
          breakpoint: ScreenSize.medium,
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
            EzScrollView(
              scrollDirection: Axis.horizontal,
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
            if (widget.showSpacing) ...<Widget>[
              swapSpacer,
              EzScrollView(
                scrollDirection: Axis.horizontal,
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
          ],
        ),
        separator,

        // Display preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: l10n.tsDisplayP1),
              EzInlineLink(
                l10n.tsDisplayLink,
                style: displayProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(displayProvider.id),
                onTap: () {
                  editing = EzTextSettingType.display;
                  setState(() {});
                },
                hint: l10n.tsLinkHint(display),
              ),
              EzPlainText(text: l10n.tsDisplayP2),
            ],
            textBackground: false,
            style: displayProvider.value,
            textAlign: TextAlign.center,
          ),
          useSurface: true,
          margin: colMargin,
          borderRadius: ezPillShape,
        ),
        spacer,

        // Headline preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: l10n.tsHeadlineP1),
              EzInlineLink(
                l10n.tsHeadlineLink,
                style: headlineProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(headlineProvider.id),
                onTap: () {
                  editing = EzTextSettingType.headline;
                  setState(() {});
                },
                hint: l10n.tsLinkHint(headline),
              ),
              EzPlainText(text: l10n.tsHeadlineP2),
            ],
            textBackground: false,
            style: headlineProvider.value,
            textAlign: TextAlign.center,
          ),
          useSurface: true,
          margin: colMargin,
          borderRadius: ezPillShape,
        ),
        spacer,

        // Title preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: l10n.tsTitleP1),
              EzInlineLink(
                l10n.tsTitleLink,
                style: titleProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(titleProvider.id),
                onTap: () {
                  editing = EzTextSettingType.title;
                  setState(() {});
                },
                hint: l10n.tsLinkHint(title),
              ),
            ],
            textBackground: false,
            style: titleProvider.value,
            textAlign: TextAlign.center,
          ),
          useSurface: true,
          margin: colMargin,
          borderRadius: ezPillShape,
        ),
        spacer,

        // Body preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: l10n.tsBodyP1),
              EzInlineLink(
                l10n.tsBodyLink,
                style: bodyProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(bodyProvider.id),
                onTap: () {
                  editing = EzTextSettingType.body;
                  setState(() {});
                },
                hint: l10n.tsLinkHint(body),
              ),
              EzPlainText(text: l10n.tsBodyP2),
            ],
            textBackground: false,
            style: bodyProvider.value,
            textAlign: TextAlign.center,
          ),
          useSurface: true,
          margin: colMargin,
          borderRadius: ezPillShape,
        ),
        spacer,

        // Label preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: l10n.tsLabelP1),
              EzInlineLink(
                l10n.tsLabelLink,
                style: labelProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(labelProvider.id),
                onTap: () {
                  editing = EzTextSettingType.label;
                  setState(() {});
                },
                hint: l10n.tsLinkHint(label),
              ),
              EzPlainText(text: l10n.tsLabelP2),
            ],
            textBackground: false,
            style: labelProvider.value,
            textAlign: TextAlign.center,
          ),
          useSurface: true,
          margin: colMargin,
          borderRadius: ezPillShape,
        ),
        separator,

        // Reset all
        EzResetButton(
          dialogTitle: l10n.tsResetAll,
          onConfirm: () async {
            await EzConfig.removeKeys(textStyleKeys.keys.toSet());
            displayProvider.reset();
            headlineProvider.reset();
            titleProvider.reset();
            bodyProvider.reset();
            labelProvider.reset();

            editing = EzTextSettingType.display;

            setState(() {});
          },
        ),
        separator,
      ],
    );
  }
}
