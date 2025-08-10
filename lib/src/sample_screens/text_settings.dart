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
  /// Optional starting [EzTSType] target
  final EzTSType? target;

  /// Spacer above the [EzResetButton] (shared by both tabs)
  final Widget resetSpacer;

  /// Optional additional reset keys for the dark theme
  /// [textStyleKeys] are included by default
  final Set<String>? darkThemeResetKeys;

  /// Optional additional reset keys for the light theme
  /// [textStyleKeys] are included by default
  final Set<String>? lightThemeResetKeys;

  /// Whether the onSurfaceColor (quick) setting should be shown
  final bool showOnSurface;

  /// Spacer above [moreQuickHeaderSettings], if present
  final Widget quickHeaderSpacer;

  /// Optional additional quick settings
  /// Will appear just above the text block
  /// See [quickHeaderSpacer] for layout tuning
  final List<Widget>? moreQuickHeaderSettings;

  /// Spacer above and below the text block (when [ScreenSize.medium] or smaller)
  final Widget textBlockSpacer;

  /// Whether the text background opacity (quick) setting should be shown
  final bool showOpacity;

  /// Spacer below the default quick settings, if [moreQuickFooterSettings] is present
  final Widget quickFooterSpacer;

  /// Optional additional quick settings
  /// Will appear just below the default quick settings
  final List<Widget>? moreQuickFooterSettings;

  /// Whether the [TextStyle] spacing controls should be shown in the advanced tab
  /// [TextStyle.letterSpacing], [TextStyle.wordSpacing], and [TextStyle.height]
  final bool showSpacing;

  /// Empathetech text settings
  /// Recommended to use as a [Scaffold.body]
  const EzTextSettings({
    // Shared
    super.key,
    this.target,
    this.resetSpacer = const EzSeparator(),
    this.darkThemeResetKeys,
    this.lightThemeResetKeys,

    // Quick
    this.showOnSurface = true,
    this.quickHeaderSpacer = const EzSpacer(),
    this.moreQuickHeaderSettings,
    this.textBlockSpacer = const EzDivider(),
    this.showOpacity = true,
    this.quickFooterSpacer = const EzSpacer(),
    this.moreQuickFooterSettings,

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
        //Shared
        target: target,
        resetSpacer: resetSpacer,
        darkThemeResetKeys: darkThemeResetKeys,
        lightThemeResetKeys: lightThemeResetKeys,

        // Quick
        showOnSurface: showOnSurface,
        quickHeaderSpacer: quickHeaderSpacer,
        moreQuickHeaderSettings: moreQuickHeaderSettings,
        textBlockSpacer: textBlockSpacer,
        showOpacity: showOpacity,
        quickFooterSpacer: quickFooterSpacer,
        moreQuickFooterSettings: moreQuickFooterSettings,

        // Advanced
        showSpacing: showSpacing,
      ),
    );
  }
}

class _TextSettings extends StatefulWidget {
  // Shared
  final EzTSType? target;
  final Widget resetSpacer;
  final Set<String>? darkThemeResetKeys;
  final Set<String>? lightThemeResetKeys;

  // Quick
  final bool showOnSurface;
  final Widget quickHeaderSpacer;
  final List<Widget>? moreQuickHeaderSettings;
  final Widget textBlockSpacer;
  final bool showOpacity;
  final Widget quickFooterSpacer;
  final List<Widget>? moreQuickFooterSettings;

  // Advanced
  final bool showSpacing;

  const _TextSettings({
    required this.target,
    required this.resetSpacer,
    required this.darkThemeResetKeys,
    required this.lightThemeResetKeys,
    required this.showOnSurface,
    required this.quickHeaderSpacer,
    required this.moreQuickHeaderSettings,
    required this.textBlockSpacer,
    required this.showOpacity,
    required this.quickFooterSpacer,
    required this.moreQuickFooterSettings,
    required this.showSpacing,
  });

  @override
  State<_TextSettings> createState() => _TextSettingsState();
}

class _TextSettingsState extends State<_TextSettings> {
  // Gather the fixed theme data //

  final double margin = EzConfig.get(marginKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EFUILang l10n = ezL10n(context);

  // Define the build data //

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

  late EzTSType currentTab = widget.target ??
      (EzConfig.get(advancedTextKey) == true
          ? EzTSType.advanced
          : EzTSType.quick);

  // Return the build //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, l10n.tsPageTitle);
  }

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
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

        // Settings
        if (currentTab == EzTSType.quick)
          _QuickTextSettings(
            // Providers
            displayProvider: displayProvider,
            headlineProvider: headlineProvider,
            titleProvider: titleProvider,
            bodyProvider: bodyProvider,
            labelProvider: labelProvider,

            // Settings config
            showOnSurface: widget.showOnSurface,
            quickHeaderSpacer: widget.quickHeaderSpacer,
            moreQuickHeaderSettings: widget.moreQuickHeaderSettings,
            textBlockSpacer: widget.textBlockSpacer,
            showOpacity: widget.showOpacity,
            quickFooterSpacer: widget.quickFooterSpacer,
            moreQuickFooterSettings: widget.moreQuickFooterSettings,
            resetSpacer: widget.resetSpacer,
            darkThemeResetKeys: widget.darkThemeResetKeys,
            lightThemeResetKeys: widget.lightThemeResetKeys,
          )
        else
          _AdvancedTextSettings(
            // Providers
            displayProvider: displayProvider,
            headlineProvider: headlineProvider,
            titleProvider: titleProvider,
            bodyProvider: bodyProvider,
            labelProvider: labelProvider,

            // Settings config
            showSpacing: widget.showSpacing,
            resetSpacer: widget.resetSpacer,
            darkThemeResetKeys: widget.darkThemeResetKeys,
            lightThemeResetKeys: widget.lightThemeResetKeys,
          ),
      ],
    );
  }
}

class _QuickTextSettings extends StatefulWidget {
  //Providers
  final EzDisplayStyleProvider displayProvider;
  final EzHeadlineStyleProvider headlineProvider;
  final EzTitleStyleProvider titleProvider;
  final EzBodyStyleProvider bodyProvider;
  final EzLabelStyleProvider labelProvider;

  // Settings config
  final bool showOnSurface;
  final Widget quickHeaderSpacer;
  final List<Widget>? moreQuickHeaderSettings;
  final Widget textBlockSpacer;
  final bool showOpacity;
  final Widget quickFooterSpacer;
  final List<Widget>? moreQuickFooterSettings;
  final Widget resetSpacer;
  final Set<String>? darkThemeResetKeys;
  final Set<String>? lightThemeResetKeys;

  const _QuickTextSettings({
    required this.displayProvider,
    required this.headlineProvider,
    required this.titleProvider,
    required this.bodyProvider,
    required this.labelProvider,
    required this.showOnSurface,
    required this.quickHeaderSpacer,
    required this.moreQuickHeaderSettings,
    required this.textBlockSpacer,
    required this.showOpacity,
    required this.quickFooterSpacer,
    required this.moreQuickFooterSettings,
    required this.resetSpacer,
    required this.darkThemeResetKeys,
    required this.lightThemeResetKeys,
  });

  @override
  State<_QuickTextSettings> createState() => _QuickTextSettingsState();
}

class _QuickTextSettingsState extends State<_QuickTextSettings> {
  // Gather the fixed theme data //

  static const EzSpacer spacer = EzSpacer();

  final double margin = EzConfig.get(marginKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EdgeInsets colMargin = EzInsets.col(margin);
  late final EdgeInsets wrapPadding = EdgeInsets.only(
    top: spacing,
    left: spacing / 2,
    right: spacing / 2,
  );

  late final EFUILang l10n = ezL10n(context);

  late Color surface = Theme.of(context).colorScheme.surface;

  // Gather the build data //

  late final bool isDark = isDarkTheme(context);

  late final String oKey =
      isDark ? darkTextBackgroundOpacityKey : lightTextBackgroundOpacityKey;
  late double currOpacity = EzConfig.get(oKey);
  late Color backgroundColor = surface.withValues(alpha: currOpacity);

  late double currIconSize = EzConfig.get(iconSizeKey);
  static const double iconDelta = 2.0;

  final EzSpacer pMSpacer = EzMargin(vertical: false);

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        EzSpacer(space: spacing / 2),

        // Required batch settings
        Wrap(
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            // Font family
            Padding(
              padding: wrapPadding,
              child: EzFontFamilyBatchSetting(
                key: UniqueKey(),
                displayProvider: widget.displayProvider,
                headlineProvider: widget.headlineProvider,
                titleProvider: widget.titleProvider,
                bodyProvider: widget.bodyProvider,
                labelProvider: widget.labelProvider,
                iconSize: currIconSize,
              ),
            ),

            // Optional onSurface Color setting
            if (widget.showOnSurface)
              Padding(
                padding: wrapPadding,
                child: EzColorSetting(
                  key: UniqueKey(),
                  configKey: isDark ? darkOnSurfaceKey : lightOnSurfaceKey,
                  onUpdate: (Color color) {
                    widget.displayProvider.redraw(color);
                    widget.headlineProvider.redraw(color);
                    widget.titleProvider.redraw(color);
                    widget.bodyProvider.redraw(color);
                    widget.labelProvider.redraw(color);
                    setState(() {});
                  },
                ),
              ),

            // Font size
            Padding(
              padding: wrapPadding,
              child: EzTextBackground(
                EzFontDoubleBatchSetting(
                  key: UniqueKey(),
                  iconSize: currIconSize,
                ),
                backgroundColor: backgroundColor,
                borderRadius: ezPillShape,
              ),
            ),
          ],
        ),

        // Optional additional settings
        if (widget.moreQuickHeaderSettings != null) ...<Widget>[
          widget.quickHeaderSpacer,
          ...widget.moreQuickHeaderSettings!,
        ],

        widget.textBlockSpacer,
        // Display preview
        EzTextBackground(
          Text(
            l10n.tsDisplayP1 + l10n.tsDisplayLink + l10n.tsDisplayP2,
            textAlign: TextAlign.center,
            style: widget.displayProvider.value,
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
            style: widget.headlineProvider.value,
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
            style: widget.titleProvider.value,
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
            style: widget.bodyProvider.value,
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
            style: widget.labelProvider.value,
          ),
          backgroundColor: backgroundColor,
          margin: colMargin,
        ),
        widget.textBlockSpacer,

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
              style: widget.labelProvider.value,
              textAlign: TextAlign.center,
            ),
            backgroundColor: backgroundColor,
            margin: colMargin,
          ),
          spacer,
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
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                pMSpacer,

                // Preview
                Icon(
                  Icons.sync_alt,
                  size: currIconSize,
                  color: Theme.of(context).colorScheme.onSurface,
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
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
              ],
            ),
            backgroundColor: backgroundColor,
            borderRadius: ezPillShape,
          ),
        ),

        // Optional additional settings
        if (widget.moreQuickFooterSettings != null) ...<Widget>[
          widget.quickFooterSpacer,
          ...widget.moreQuickFooterSettings!,
        ],

        // Reset all
        widget.resetSpacer,
        EzResetButton(
          dialogTitle: l10n.tsResetAll,
          onConfirm: () async {
            final Set<String> textKeys = textStyleKeys.keys.toSet();

            if (isDark) {
              textKeys.remove(lightTextBackgroundOpacityKey);
              await EzConfig.removeKeys(textKeys);
              await EzConfig.remove(darkOnSurfaceKey);

              if (widget.darkThemeResetKeys != null) {
                EzConfig.removeKeys(widget.darkThemeResetKeys!);
              }
            } else {
              textKeys.remove(darkTextBackgroundOpacityKey);
              await EzConfig.removeKeys(textKeys);
              await EzConfig.remove(lightOnSurfaceKey);

              if (widget.lightThemeResetKeys != null) {
                EzConfig.removeKeys(widget.lightThemeResetKeys!);
              }
            }

            widget.displayProvider.reset();
            widget.headlineProvider.reset();
            widget.titleProvider.reset();
            widget.bodyProvider.reset();
            widget.labelProvider.reset();

            currOpacity = EzConfig.getDefault(oKey);
            backgroundColor = surface.withValues(alpha: currOpacity);
            currIconSize = EzConfig.getDefault(iconSizeKey);

            setState(() {});
          },
        ),
        const EzSeparator(),
      ],
    );
  }
}

class _AdvancedTextSettings extends StatefulWidget {
  // Providers
  final EzDisplayStyleProvider displayProvider;
  final EzHeadlineStyleProvider headlineProvider;
  final EzTitleStyleProvider titleProvider;
  final EzBodyStyleProvider bodyProvider;
  final EzLabelStyleProvider labelProvider;

  // Settings config
  final bool showSpacing;
  final Widget resetSpacer;
  final Set<String>? darkThemeResetKeys;
  final Set<String>? lightThemeResetKeys;

  const _AdvancedTextSettings({
    required this.displayProvider,
    required this.headlineProvider,
    required this.titleProvider,
    required this.bodyProvider,
    required this.labelProvider,
    required this.showSpacing,
    required this.resetSpacer,
    required this.darkThemeResetKeys,
    required this.lightThemeResetKeys,
  });

  @override
  State<_AdvancedTextSettings> createState() => _AdvancedTextSettingsState();
}

class _AdvancedTextSettingsState extends State<_AdvancedTextSettings> {
  // Gather the fixed theme data //

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

  late final EFUILang l10n = ezL10n(context);

  // Gather the build data //

  EzTextSettingType editing = EzTextSettingType.display;
  late final bool isDark = isDarkTheme(context);

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

  late Widget fontSizeIcon = EzTextBackground(
    Icon(
      Icons.text_fields_sharp,
      color: Theme.of(context).colorScheme.onSurface,
      size: widget.labelProvider.value.fontSize,
    ),
    borderRadius: textFieldRadius,
  );

  late Widget letterSpacingIcon = EzTextBackground(
    Icon(
      Icons.horizontal_distribute_sharp,
      color: Theme.of(context).colorScheme.onSurface,
      size: widget.labelProvider.value.fontSize,
    ),
    borderRadius: textFieldRadius,
  );

  late Widget wordSpacingIcon = EzTextBackground(
    Icon(
      Icons.space_bar_sharp,
      color: Theme.of(context).colorScheme.onSurface,
      size: widget.labelProvider.value.fontSize,
    ),
    borderRadius: textFieldRadius,
  );

  late Widget lineHeightIcon = EzTextBackground(
    Icon(
      Icons.format_line_spacing_sharp,
      color: Theme.of(context).colorScheme.onSurface,
      size: widget.labelProvider.value.fontSize,
    ),
    borderRadius: textFieldRadius,
  );

  /// Font family setting(s)
  late final Map<EzTextSettingType, EzFontFamilySetting> familyControllers =
      <EzTextSettingType, EzFontFamilySetting>{
    EzTextSettingType.display: EzFontFamilySetting(
      key: UniqueKey(),
      configKey: displayFontFamilyKey,
      provider: widget.displayProvider,
      baseStyle: widget.bodyProvider.value,
    ),
    EzTextSettingType.headline: EzFontFamilySetting(
      key: UniqueKey(),
      configKey: headlineFontFamilyKey,
      provider: widget.headlineProvider,
      baseStyle: widget.bodyProvider.value,
    ),
    EzTextSettingType.title: EzFontFamilySetting(
      key: UniqueKey(),
      configKey: titleFontFamilyKey,
      provider: widget.titleProvider,
      baseStyle: widget.bodyProvider.value,
    ),
    EzTextSettingType.body: EzFontFamilySetting(
      key: UniqueKey(),
      configKey: bodyFontFamilyKey,
      provider: widget.bodyProvider,
      baseStyle: widget.bodyProvider.value,
    ),
    EzTextSettingType.label: EzFontFamilySetting(
      key: UniqueKey(),
      configKey: labelFontFamilyKey,
      provider: widget.labelProvider,
      baseStyle: widget.bodyProvider.value,
    ),
  };

  /// Font size setting(s)
  late final Map<EzTextSettingType, Widget> sizeControllers =
      <EzTextSettingType, Widget>{
    EzTextSettingType.display: EzFontDoubleSetting(
      key: ValueKey<String>('$displayFontSizeKey-${widget.displayProvider.id}'),
      configKey: displayFontSizeKey,
      initialValue: widget.displayProvider.value.fontSize!,
      min: minDisplay,
      max: maxDisplay,
      notifierCallback: widget.displayProvider.resize,
      style: widget.bodyProvider.value,
      icon: fontSizeIcon,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
    ),
    EzTextSettingType.headline: EzFontDoubleSetting(
      key: ValueKey<String>(
          '$headlineFontSizeKey-${widget.headlineProvider.id}'),
      configKey: headlineFontSizeKey,
      initialValue: widget.headlineProvider.value.fontSize!,
      min: minHeadline,
      max: maxHeadline,
      notifierCallback: widget.headlineProvider.resize,
      style: widget.bodyProvider.value,
      icon: fontSizeIcon,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
    ),
    EzTextSettingType.title: EzFontDoubleSetting(
      key: ValueKey<String>('$titleFontSizeKey-${widget.titleProvider.id}'),
      configKey: titleFontSizeKey,
      initialValue: widget.titleProvider.value.fontSize!,
      min: minTitle,
      max: maxTitle,
      notifierCallback: widget.titleProvider.resize,
      style: widget.bodyProvider.value,
      icon: fontSizeIcon,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
    ),
    EzTextSettingType.body: EzFontDoubleSetting(
      key: ValueKey<String>('$bodyFontSizeKey-${widget.bodyProvider.id}'),
      configKey: bodyFontSizeKey,
      initialValue: widget.bodyProvider.value.fontSize!,
      min: minBody,
      max: maxBody,
      notifierCallback: widget.bodyProvider.resize,
      style: widget.bodyProvider.value,
      icon: fontSizeIcon,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
    ),
    EzTextSettingType.label: EzFontDoubleSetting(
      key: ValueKey<String>('$labelFontSizeKey-${widget.labelProvider.id}'),
      configKey: labelFontSizeKey,
      initialValue: widget.labelProvider.value.fontSize!,
      min: minLabel,
      max: maxLabel,
      notifierCallback: widget.labelProvider.resize,
      style: widget.bodyProvider.value,
      icon: fontSizeIcon,
      plusMinus: true,
      tooltip: l10n.tsFontSize,
    ),
  };

  /// Font weight setting(s)
  late final Map<EzTextSettingType, EzBoldSetting> boldControllers =
      <EzTextSettingType, EzBoldSetting>{
    EzTextSettingType.display: EzBoldSetting(
      key: ValueKey<String>('$displayBoldedKey-${widget.displayProvider.id}'),
      configKey: displayBoldedKey,
      notifierCallback: widget.displayProvider.bold,
      size: widget.titleProvider.value.fontSize,
    ),
    EzTextSettingType.headline: EzBoldSetting(
      key: ValueKey<String>('$headlineBoldedKey-${widget.headlineProvider.id}'),
      configKey: headlineBoldedKey,
      notifierCallback: widget.headlineProvider.bold,
      size: widget.titleProvider.value.fontSize,
    ),
    EzTextSettingType.title: EzBoldSetting(
      key: ValueKey<String>('$titleBoldedKey-${widget.titleProvider.id}'),
      configKey: titleBoldedKey,
      notifierCallback: widget.titleProvider.bold,
      size: widget.titleProvider.value.fontSize,
    ),
    EzTextSettingType.body: EzBoldSetting(
      key: ValueKey<String>('$bodyBoldedKey-${widget.bodyProvider.id}'),
      configKey: bodyBoldedKey,
      notifierCallback: widget.bodyProvider.bold,
      size: widget.titleProvider.value.fontSize,
    ),
    EzTextSettingType.label: EzBoldSetting(
      key: ValueKey<String>('$labelBoldedKey-${widget.labelProvider.id}'),
      configKey: labelBoldedKey,
      notifierCallback: widget.labelProvider.bold,
      size: widget.titleProvider.value.fontSize,
    ),
  };

  /// Font style setting(s)
  late final Map<EzTextSettingType, EzItalicSetting> italicsControllers =
      <EzTextSettingType, EzItalicSetting>{
    EzTextSettingType.display: EzItalicSetting(
      key: ValueKey<String>(
          '$displayItalicizedKey-${widget.displayProvider.id}'),
      configKey: displayItalicizedKey,
      notifierCallback: widget.displayProvider.italic,
      size: widget.titleProvider.value.fontSize,
    ),
    EzTextSettingType.headline: EzItalicSetting(
      key: ValueKey<String>(
          '$headlineItalicizedKey-${widget.headlineProvider.id}'),
      configKey: headlineItalicizedKey,
      notifierCallback: widget.headlineProvider.italic,
      size: widget.titleProvider.value.fontSize,
    ),
    EzTextSettingType.title: EzItalicSetting(
      key: ValueKey<String>('$titleItalicizedKey-${widget.titleProvider.id}'),
      configKey: titleItalicizedKey,
      notifierCallback: widget.titleProvider.italic,
      size: widget.titleProvider.value.fontSize,
    ),
    EzTextSettingType.body: EzItalicSetting(
      key: ValueKey<String>('$bodyItalicizedKey-${widget.bodyProvider.id}'),
      configKey: bodyItalicizedKey,
      notifierCallback: widget.bodyProvider.italic,
      size: widget.titleProvider.value.fontSize,
    ),
    EzTextSettingType.label: EzItalicSetting(
      key: ValueKey<String>('$labelItalicizedKey-${widget.labelProvider.id}'),
      configKey: labelItalicizedKey,
      notifierCallback: widget.labelProvider.italic,
      size: widget.titleProvider.value.fontSize,
    ),
  };

  /// Font decoration setting(s)
  late final Map<EzTextSettingType, EzUnderlineSetting> underlineControllers =
      <EzTextSettingType, EzUnderlineSetting>{
    EzTextSettingType.display: EzUnderlineSetting(
      key: ValueKey<String>(
          '$displayUnderlinedKey-${widget.displayProvider.id}'),
      configKey: displayUnderlinedKey,
      notifierCallback: widget.displayProvider.underline,
      size: widget.titleProvider.value.fontSize,
    ),
    EzTextSettingType.headline: EzUnderlineSetting(
      key: ValueKey<String>(
          '$headlineUnderlinedKey-${widget.headlineProvider.id}'),
      configKey: headlineUnderlinedKey,
      notifierCallback: widget.headlineProvider.underline,
      size: widget.titleProvider.value.fontSize,
    ),
    EzTextSettingType.title: EzUnderlineSetting(
      key: ValueKey<String>('$titleUnderlinedKey-${widget.titleProvider.id}'),
      configKey: titleUnderlinedKey,
      notifierCallback: widget.titleProvider.underline,
      size: widget.titleProvider.value.fontSize,
    ),
    EzTextSettingType.body: EzUnderlineSetting(
      key: ValueKey<String>('$bodyUnderlinedKey-${widget.bodyProvider.id}'),
      configKey: bodyUnderlinedKey,
      notifierCallback: widget.bodyProvider.underline,
      size: widget.titleProvider.value.fontSize,
    ),
    EzTextSettingType.label: EzUnderlineSetting(
      key: ValueKey<String>('$labelUnderlinedKey-${widget.labelProvider.id}'),
      configKey: labelUnderlinedKey,
      notifierCallback: widget.labelProvider.underline,
      size: widget.titleProvider.value.fontSize,
    ),
  };

  /// Letter spacing setting(s)
  late final Map<EzTextSettingType, EzFontDoubleSetting>
      letterSpacingControllers = <EzTextSettingType, EzFontDoubleSetting>{
    EzTextSettingType.display: EzFontDoubleSetting(
      key: ValueKey<String>(
          '$displayLetterSpacingKey-${widget.displayProvider.id}'),
      configKey: displayLetterSpacingKey,
      initialValue: widget.displayProvider.value.letterSpacing!,
      min: minLetterSpacing,
      max: maxLetterSpacing,
      notifierCallback: widget.displayProvider.setLetterSpacing,
      style: widget.bodyProvider.value,
      icon: letterSpacingIcon,
      tooltip: l10n.tsLetterSpacing,
    ),
    EzTextSettingType.headline: EzFontDoubleSetting(
      key: ValueKey<String>(
          '$headlineLetterSpacingKey-${widget.headlineProvider.id}'),
      configKey: headlineLetterSpacingKey,
      initialValue: widget.headlineProvider.value.letterSpacing!,
      min: minLetterSpacing,
      max: maxLetterSpacing,
      notifierCallback: widget.headlineProvider.setLetterSpacing,
      style: widget.bodyProvider.value,
      icon: letterSpacingIcon,
      tooltip: l10n.tsLetterSpacing,
    ),
    EzTextSettingType.title: EzFontDoubleSetting(
      key:
          ValueKey<String>('$titleLetterSpacingKey-${widget.titleProvider.id}'),
      configKey: titleLetterSpacingKey,
      initialValue: widget.titleProvider.value.letterSpacing!,
      min: minLetterSpacing,
      max: maxLetterSpacing,
      notifierCallback: widget.titleProvider.setLetterSpacing,
      style: widget.bodyProvider.value,
      icon: letterSpacingIcon,
      tooltip: l10n.tsLetterSpacing,
    ),
    EzTextSettingType.body: EzFontDoubleSetting(
      key: ValueKey<String>('$bodyLetterSpacingKey-${widget.bodyProvider.id}'),
      configKey: bodyLetterSpacingKey,
      initialValue: widget.bodyProvider.value.letterSpacing!,
      min: minLetterSpacing,
      max: maxLetterSpacing,
      notifierCallback: widget.bodyProvider.setLetterSpacing,
      style: widget.bodyProvider.value,
      icon: letterSpacingIcon,
      tooltip: l10n.tsLetterSpacing,
    ),
    EzTextSettingType.label: EzFontDoubleSetting(
      key:
          ValueKey<String>('$labelLetterSpacingKey-${widget.labelProvider.id}'),
      configKey: labelLetterSpacingKey,
      initialValue: widget.labelProvider.value.letterSpacing!,
      min: minLetterSpacing,
      max: maxLetterSpacing,
      notifierCallback: widget.labelProvider.setLetterSpacing,
      style: widget.bodyProvider.value,
      icon: letterSpacingIcon,
      tooltip: l10n.tsLetterSpacing,
    ),
  };

  /// Word spacing setting(s)
  late final Map<EzTextSettingType, EzFontDoubleSetting>
      wordSpacingControllers = <EzTextSettingType, EzFontDoubleSetting>{
    EzTextSettingType.display: EzFontDoubleSetting(
      key: ValueKey<String>(
          '$displayWordSpacingKey-${widget.displayProvider.id}'),
      configKey: displayWordSpacingKey,
      initialValue: widget.displayProvider.value.wordSpacing!,
      min: minWordSpacing,
      max: maxWordSpacing,
      notifierCallback: widget.displayProvider.setWordSpacing,
      style: widget.bodyProvider.value,
      icon: wordSpacingIcon,
      tooltip: l10n.tsWordSpacing,
    ),
    EzTextSettingType.headline: EzFontDoubleSetting(
      key: ValueKey<String>(
          '$headlineWordSpacingKey-${widget.headlineProvider.id}'),
      configKey: headlineWordSpacingKey,
      initialValue: widget.headlineProvider.value.wordSpacing!,
      min: minWordSpacing,
      max: maxWordSpacing,
      notifierCallback: widget.headlineProvider.setWordSpacing,
      style: widget.bodyProvider.value,
      icon: wordSpacingIcon,
      tooltip: l10n.tsWordSpacing,
    ),
    EzTextSettingType.title: EzFontDoubleSetting(
      key: ValueKey<String>('$titleWordSpacingKey-${widget.titleProvider.id}'),
      configKey: titleWordSpacingKey,
      initialValue: widget.titleProvider.value.wordSpacing!,
      min: minWordSpacing,
      max: maxWordSpacing,
      notifierCallback: widget.titleProvider.setWordSpacing,
      style: widget.bodyProvider.value,
      icon: wordSpacingIcon,
      tooltip: l10n.tsWordSpacing,
    ),
    EzTextSettingType.body: EzFontDoubleSetting(
      key: ValueKey<String>('$bodyWordSpacingKey-${widget.bodyProvider.id}'),
      configKey: bodyWordSpacingKey,
      initialValue: widget.bodyProvider.value.wordSpacing!,
      min: minWordSpacing,
      max: maxWordSpacing,
      notifierCallback: widget.bodyProvider.setWordSpacing,
      style: widget.bodyProvider.value,
      icon: wordSpacingIcon,
      tooltip: l10n.tsWordSpacing,
    ),
    EzTextSettingType.label: EzFontDoubleSetting(
      key: ValueKey<String>('$labelWordSpacingKey-${widget.labelProvider.id}'),
      configKey: labelWordSpacingKey,
      initialValue: widget.labelProvider.value.wordSpacing!,
      min: minWordSpacing,
      max: maxWordSpacing,
      notifierCallback: widget.labelProvider.setWordSpacing,
      style: widget.bodyProvider.value,
      icon: wordSpacingIcon,
      tooltip: l10n.tsWordSpacing,
    ),
  };

  /// Line height setting(s)
  late final Map<EzTextSettingType, EzFontDoubleSetting> lineHeightControllers =
      <EzTextSettingType, EzFontDoubleSetting>{
    EzTextSettingType.display: EzFontDoubleSetting(
      key: ValueKey<String>(
          '$displayFontHeightKey-${widget.displayProvider.id}'),
      configKey: displayFontHeightKey,
      initialValue: widget.displayProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: widget.displayProvider.setHeight,
      style: widget.bodyProvider.value,
      icon: lineHeightIcon,
      tooltip: l10n.tsLineHeight,
    ),
    EzTextSettingType.headline: EzFontDoubleSetting(
      key: ValueKey<String>(
          '$headlineFontHeightKey-${widget.headlineProvider.id}'),
      configKey: headlineFontHeightKey,
      initialValue: widget.headlineProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: widget.headlineProvider.setHeight,
      style: widget.bodyProvider.value,
      icon: lineHeightIcon,
      tooltip: l10n.tsLineHeight,
    ),
    EzTextSettingType.title: EzFontDoubleSetting(
      key: ValueKey<String>('$titleFontHeightKey-${widget.titleProvider.id}'),
      configKey: titleFontHeightKey,
      initialValue: widget.titleProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: widget.titleProvider.setHeight,
      style: widget.bodyProvider.value,
      icon: lineHeightIcon,
      tooltip: l10n.tsLineHeight,
    ),
    EzTextSettingType.body: EzFontDoubleSetting(
      key: ValueKey<String>('$bodyFontHeightKey-${widget.bodyProvider.id}'),
      configKey: bodyFontHeightKey,
      initialValue: widget.bodyProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: widget.bodyProvider.setHeight,
      style: widget.bodyProvider.value,
      icon: lineHeightIcon,
      tooltip: l10n.tsLineHeight,
    ),
    EzTextSettingType.label: EzFontDoubleSetting(
      key: ValueKey<String>('$labelFontHeightKey-${widget.labelProvider.id}'),
      configKey: labelFontHeightKey,
      initialValue: widget.labelProvider.value.height!,
      min: minFontHeight,
      max: maxFontHeight,
      notifierCallback: widget.labelProvider.setHeight,
      style: widget.bodyProvider.value,
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
        spacer,

        // Style selector
        EzScrollView(
          scrollDirection: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          primary: false,
          children: <Widget>[
            EzText(
              l10n.gEditing,
              style: widget.labelProvider.value,
              textAlign: TextAlign.center,
            ),
            EzMargin(),
            EzDropdownMenu<EzTextSettingType>(
              widthEntries: styleChoices
                  .map(
                      (DropdownMenuEntry<EzTextSettingType> type) => type.label)
                  .toList(),
              textStyle: widget.labelProvider.value,
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
                style: widget.displayProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(widget.displayProvider.id),
                onTap: () {
                  editing = EzTextSettingType.display;
                  setState(() {});
                },
                hint: l10n.tsLinkHint(display),
              ),
              EzPlainText(text: l10n.tsDisplayP2),
            ],
            textBackground: false,
            style: widget.displayProvider.value,
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
                style: widget.headlineProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(widget.headlineProvider.id),
                onTap: () {
                  editing = EzTextSettingType.headline;
                  setState(() {});
                },
                hint: l10n.tsLinkHint(headline),
              ),
              EzPlainText(text: l10n.tsHeadlineP2),
            ],
            textBackground: false,
            style: widget.headlineProvider.value,
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
                style: widget.titleProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(widget.titleProvider.id),
                onTap: () {
                  editing = EzTextSettingType.title;
                  setState(() {});
                },
                hint: l10n.tsLinkHint(title),
              ),
            ],
            textBackground: false,
            style: widget.titleProvider.value,
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
                style: widget.bodyProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(widget.bodyProvider.id),
                onTap: () {
                  editing = EzTextSettingType.body;
                  setState(() {});
                },
                hint: l10n.tsLinkHint(body),
              ),
              EzPlainText(text: l10n.tsBodyP2),
            ],
            textBackground: false,
            style: widget.bodyProvider.value,
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
                style: widget.labelProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(widget.labelProvider.id),
                onTap: () {
                  editing = EzTextSettingType.label;
                  setState(() {});
                },
                hint: l10n.tsLinkHint(label),
              ),
              EzPlainText(text: l10n.tsLabelP2),
            ],
            textBackground: false,
            style: widget.labelProvider.value,
            textAlign: TextAlign.center,
          ),
          useSurface: true,
          margin: colMargin,
          borderRadius: ezPillShape,
        ),

        // Reset all
        widget.resetSpacer,
        EzResetButton(
          dialogTitle: l10n.tsResetAll,
          onConfirm: () async {
            final Set<String> textKeys = textStyleKeys.keys.toSet();

            if (isDark) {
              textKeys.remove(lightTextBackgroundOpacityKey);
              await EzConfig.removeKeys(textKeys);
              await EzConfig.remove(darkOnSurfaceKey);

              if (widget.darkThemeResetKeys != null) {
                EzConfig.removeKeys(widget.darkThemeResetKeys!);
              }
            } else {
              textKeys.remove(darkTextBackgroundOpacityKey);
              await EzConfig.removeKeys(textKeys);
              await EzConfig.remove(lightOnSurfaceKey);

              if (widget.lightThemeResetKeys != null) {
                EzConfig.removeKeys(widget.lightThemeResetKeys!);
              }
            }

            widget.displayProvider.reset();
            widget.headlineProvider.reset();
            widget.titleProvider.reset();
            widget.bodyProvider.reset();
            widget.labelProvider.reset();

            editing = EzTextSettingType.display;

            setState(() {});
          },
        ),
        separator,
      ],
    );
  }
}
