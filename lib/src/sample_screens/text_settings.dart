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
  /// [allTextKeys] and [darkOnSurfaceKey] are included by default
  final Set<String>? darkThemeResetKeys;

  /// Optional additional reset keys for the light theme
  /// [allTextKeys] and [lightOnSurfaceKey] are included by default
  final Set<String>? lightThemeResetKeys;

  /// [EzResetButton.extraKeys] passthrough
  final List<String>? extraSaveKeys;

  /// [EzResetButton.appName] passthrough
  final String appName;

  /// [EzResetButton.androidPackage] passthrough
  final String? androidPackage;

  /// Whether the onSurfaceColor (quick) setting should be shown
  final bool showOnSurface;

  /// Optional additional quick settings
  /// Will appear just above the text block
  /// BYO leading spacer, trailing will be [textBlockSpacer]
  final List<Widget>? moreQuickHeaderSettings;

  /// Spacer above and below the text block (when [ScreenSize.medium] or smaller)
  final Widget textBlockSpacer;

  /// Whether the text background opacity (quick) setting should be shown
  final bool showOpacity;

  /// Optional additional quick settings
  /// Will appear just below the default quick settings
  /// BYO leading spacer, trailing will be [resetSpacer]
  final List<Widget>? moreQuickFooterSettings;

  /// Whether the [TextStyle] EzConfig.spacing controls should be shown in the advanced tab
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
    this.extraSaveKeys,
    required this.appName,
    this.androidPackage,

    // Quick
    this.showOnSurface = true,
    this.moreQuickHeaderSettings,
    this.textBlockSpacer = const EzDivider(),
    this.showOpacity = true,
    this.moreQuickFooterSettings,

    // Advanced
    this.showSpacing = true,
  });

  // Set the page title //

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: <ChangeNotifierProvider<dynamic>>[
          ChangeNotifierProvider<EzDisplayStyleProvider>(
            create: (_) => EzDisplayStyleProvider(),
          ),
          ChangeNotifierProvider<EzHeadlineStyleProvider>(
            create: (_) => EzHeadlineStyleProvider(),
          ),
          ChangeNotifierProvider<EzTitleStyleProvider>(
            create: (_) => EzTitleStyleProvider(null),
          ),
          ChangeNotifierProvider<EzBodyStyleProvider>(
            create: (_) => EzBodyStyleProvider(null),
          ),
          ChangeNotifierProvider<EzLabelStyleProvider>(
            create: (_) => EzLabelStyleProvider(null),
          ),
        ],
        child: _TextSettings(
          //Shared
          target: target,
          resetSpacer: resetSpacer,
          darkThemeResetKeys: darkThemeResetKeys,
          lightThemeResetKeys: lightThemeResetKeys,
          extraSaveKeys: extraSaveKeys,
          appName: appName,
          androidPackage: androidPackage,

          // Quick
          showOnSurface: showOnSurface,
          moreQuickHeaderSettings: moreQuickHeaderSettings,
          textBlockSpacer: textBlockSpacer,
          showOpacity: showOpacity,
          moreQuickFooterSettings: moreQuickFooterSettings,

          // Advanced
          showSpacing: showSpacing,
        ),
      );
}

class _TextSettings extends StatefulWidget {
  // Shared
  final EzTSType? target;
  final Widget resetSpacer;
  final Set<String>? darkThemeResetKeys;
  final Set<String>? lightThemeResetKeys;
  final List<String>? extraSaveKeys;
  final String appName;
  final String? androidPackage;

  // Quick
  final bool showOnSurface;
  final List<Widget>? moreQuickHeaderSettings;
  final Widget textBlockSpacer;
  final bool showOpacity;
  final List<Widget>? moreQuickFooterSettings;

  // Advanced
  final bool showSpacing;

  const _TextSettings({
    required this.target,
    required this.resetSpacer,
    required this.darkThemeResetKeys,
    required this.lightThemeResetKeys,
    required this.extraSaveKeys,
    required this.appName,
    this.androidPackage,
    required this.showOnSurface,
    required this.moreQuickHeaderSettings,
    required this.textBlockSpacer,
    required this.showOpacity,
    required this.moreQuickFooterSettings,
    required this.showSpacing,
  });

  @override
  State<_TextSettings> createState() => _TextSettingsState();
}

class _TextSettingsState extends State<_TextSettings>
    with WidgetsBindingObserver {
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

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ezWindowNamer(context, EzConfig.l10n.tsPageTitle);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();

    final String key =
        isDarkTheme(context) ? darkOnSurfaceKey : lightOnSurfaceKey;
    final Color color = Color(EzConfig.get(key));

    displayProvider.redraw(color);
    headlineProvider.redraw(color);
    titleProvider.redraw(color);
    bodyProvider.redraw(color);
    labelProvider.redraw(color);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      children: <Widget>[
        EzHeader(),

        // Mode selector
        SegmentedButton<EzTSType>(
          segments: <ButtonSegment<EzTSType>>[
            ButtonSegment<EzTSType>(
              value: EzTSType.quick,
              label: Text(EzConfig.l10n.gQuick),
            ),
            ButtonSegment<EzTSType>(
              value: EzTSType.advanced,
              label: Text(EzConfig.l10n.gAdvanced),
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
            moreQuickHeaderSettings: widget.moreQuickHeaderSettings,
            textBlockSpacer: widget.textBlockSpacer,
            showOpacity: widget.showOpacity,
            opacityKey: isDarkTheme(context)
                ? darkTextBackgroundOpacityKey
                : lightTextBackgroundOpacityKey,
            moreQuickFooterSettings: widget.moreQuickFooterSettings,
            resetSpacer: widget.resetSpacer,
            darkThemeResetKeys: widget.darkThemeResetKeys,
            lightThemeResetKeys: widget.lightThemeResetKeys,
            extraSaveKeys: widget.extraSaveKeys,
            appName: widget.appName,
            androidPackage: widget.androidPackage,
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
            extraSaveKeys: widget.extraSaveKeys,
            appName: widget.appName,
            androidPackage: widget.androidPackage,
          ),
      ],
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class _QuickTextSettings extends StatefulWidget {
  // Providers
  final EzDisplayStyleProvider displayProvider;
  final EzHeadlineStyleProvider headlineProvider;
  final EzTitleStyleProvider titleProvider;
  final EzBodyStyleProvider bodyProvider;
  final EzLabelStyleProvider labelProvider;

  // Settings config
  final bool showOnSurface;
  final List<Widget>? moreQuickHeaderSettings;
  final Widget textBlockSpacer;
  final bool showOpacity;
  final String opacityKey;
  final List<Widget>? moreQuickFooterSettings;
  final Widget resetSpacer;
  final Set<String>? darkThemeResetKeys;
  final Set<String>? lightThemeResetKeys;
  final List<String>? extraSaveKeys;
  final String appName;
  final String? androidPackage;

  const _QuickTextSettings({
    required this.displayProvider,
    required this.headlineProvider,
    required this.titleProvider,
    required this.bodyProvider,
    required this.labelProvider,
    required this.showOnSurface,
    required this.moreQuickHeaderSettings,
    required this.textBlockSpacer,
    required this.showOpacity,
    required this.opacityKey,
    required this.moreQuickFooterSettings,
    required this.resetSpacer,
    required this.darkThemeResetKeys,
    required this.lightThemeResetKeys,
    required this.extraSaveKeys,
    required this.appName,
    this.androidPackage,
  });

  @override
  State<_QuickTextSettings> createState() => _QuickTextSettingsState();
}

class _QuickTextSettingsState extends State<_QuickTextSettings> {
  // Gather the build data //

  late double backOpacity = EzConfig.get(widget.opacityKey);
  late double iconSize = EzConfig.iconSize;

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    late final EdgeInsets colMargin = EzInsets.col(EzConfig.margin);
    late final EdgeInsets wrapPadding = EdgeInsets.only(
      top: EzConfig.spacing,
      left: EzConfig.spacing / 2,
      right: EzConfig.spacing / 2,
    );

    final bool isDark = isDarkTheme(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color surface = colorScheme.surface;

    // Return the build //

    Color backgroundColor = surface.withValues(alpha: backOpacity);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        EzSpacer(space: EzConfig.spacing / 2),

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
                iconSize: iconSize,
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
                  displayProvider: widget.displayProvider,
                  headlineProvider: widget.headlineProvider,
                  titleProvider: widget.titleProvider,
                  bodyProvider: widget.bodyProvider,
                  labelProvider: widget.labelProvider,
                  iconSize: iconSize,
                ),
                backgroundColor: backgroundColor,
                borderRadius: ezPillShape,
              ),
            ),
          ],
        ),

        // Optional additional settings
        if (widget.moreQuickHeaderSettings != null)
          ...widget.moreQuickHeaderSettings!,

        widget.textBlockSpacer,
        // Display preview
        EzTextBackground(
          Text(
            EzConfig.l10n.tsDisplayP1 +
                EzConfig.l10n.tsDisplayLink +
                EzConfig.l10n.tsDisplayP2,
            textAlign: TextAlign.center,
            style: widget.displayProvider.value,
          ),
          backgroundColor: backgroundColor,
          margin: colMargin,
        ),
        EzConfig.layout.spacer,

        // Headline preview
        EzTextBackground(
          Text(
            EzConfig.l10n.tsHeadlineP1 +
                EzConfig.l10n.tsHeadlineLink +
                EzConfig.l10n.tsHeadlineP2,
            textAlign: TextAlign.center,
            style: widget.headlineProvider.value,
          ),
          backgroundColor: backgroundColor,
          margin: colMargin,
        ),
        EzConfig.layout.spacer,

        // Title preview
        EzTextBackground(
          Text(
            EzConfig.l10n.tsTitleP1 + EzConfig.l10n.tsTitleLink,
            textAlign: TextAlign.center,
            style: widget.titleProvider.value,
          ),
          backgroundColor: backgroundColor,
          margin: colMargin,
        ),
        EzConfig.layout.spacer,

        // Body preview
        EzTextBackground(
          Text(
            EzConfig.l10n.tsBodyP1 +
                EzConfig.l10n.tsBodyLink +
                EzConfig.l10n.tsBodyP2,
            textAlign: TextAlign.center,
            style: widget.bodyProvider.value,
          ),
          backgroundColor: backgroundColor,
          margin: colMargin,
        ),
        EzConfig.layout.spacer,

        // Label preview
        EzTextBackground(
          Text(
            EzConfig.l10n.tsLabelP1 +
                EzConfig.l10n.tsLabelLink +
                EzConfig.l10n.tsLabelP2,
            textAlign: TextAlign.center,
            style: widget.labelProvider.value,
          ),
          backgroundColor: backgroundColor,
          margin: colMargin,
        ),
        widget.textBlockSpacer,

        // Text background opacity
        if (widget.showOpacity) ...<Widget>[
          // Label
          EzTextBackground(
            Text(
              EzConfig.l10n.tsTextBackground,
              style: widget.labelProvider.value,
              textAlign: TextAlign.center,
            ),
            backgroundColor: backgroundColor,
            margin: colMargin,
          ),

          // Slider
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
            child: Slider(
              // Slider values
              value: backOpacity,
              min: minOpacity,
              max: maxOpacity,
              divisions: 20,
              label: backOpacity.toStringAsFixed(2),

              // Slider functions
              onChanged: (double value) {
                setState(() {
                  backOpacity = value;
                  backgroundColor = surface.withValues(alpha: backOpacity);
                });
              },
              onChangeEnd: (double value) async {
                await EzConfig.setDouble(widget.opacityKey, value);
              },

              // Slider semantics
              semanticFormatterCallback: (double value) =>
                  value.toStringAsFixed(2),
            ),
          ),
          EzConfig.layout.spacer,
        ],

        // Icon size
        Tooltip(
          message: EzConfig.l10n.gCenterReset,
          child: GestureDetector(
            onLongPress: () async {
              iconSize = defaultIconSize;
              await EzConfig.setDouble(iconSizeKey, defaultIconSize);
              setState(() {});
            },
            child: EzTextBackground(
              Text(
                EzConfig.l10n.tsIconSize,
                style: widget.labelProvider.value,
                textAlign: TextAlign.center,
              ),
              backgroundColor: backgroundColor,
              margin: colMargin,
            ),
          ),
        ),
        EzTextBackground(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Minus
              (iconSize > minIconSize)
                  ? EzIconButton(
                      onPressed: () async {
                        iconSize -= iconDelta;
                        await EzConfig.setDouble(iconSizeKey, iconSize);
                        setState(() {});
                      },
                      tooltip:
                          '${EzConfig.l10n.gDecrease} ${EzConfig.l10n.tsIconSize.toLowerCase()}',
                      iconSize: iconSize,
                      icon: Icon(PlatformIcons(context).remove),
                    )
                  : EzIconButton(
                      enabled: false,
                      tooltip: EzConfig.l10n.gMinimum,
                      iconSize: iconSize,
                      icon: Icon(
                        PlatformIcons(context).remove,
                        color: colorScheme.outline,
                      ),
                    ),
              EzMargin(vertical: false),

              // Preview
              GestureDetector(
                onLongPress: () async {
                  iconSize = defaultIconSize;
                  await EzConfig.setDouble(iconSizeKey, defaultIconSize);
                  setState(() {});
                },
                child: Icon(
                  Icons.sync_alt,
                  size: iconSize,
                  color: colorScheme.onSurface,
                ),
              ),
              EzMargin(vertical: false),

              // Plus
              (iconSize < maxIconSize)
                  ? EzIconButton(
                      onPressed: () async {
                        iconSize += iconDelta;
                        await EzConfig.setDouble(iconSizeKey, iconSize);
                        setState(() {});
                      },
                      tooltip:
                          '${EzConfig.l10n.gIncrease} ${EzConfig.l10n.tsIconSize.toLowerCase()}',
                      iconSize: iconSize,
                      icon: Icon(PlatformIcons(context).add),
                    )
                  : EzIconButton(
                      enabled: false,
                      tooltip: EzConfig.l10n.gMaximum,
                      iconSize: iconSize,
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

        // Optional additional settings
        if (widget.moreQuickFooterSettings != null)
          ...widget.moreQuickFooterSettings!,

        // Reset all
        widget.resetSpacer,
        EzResetButton(
          dialogTitle: EzConfig.l10n.tsResetAll,
          onConfirm: () async {
            final Set<String> textKeys = allTextKeys.keys.toSet();

            if (isDark) {
              textKeys.remove(lightTextBackgroundOpacityKey);
              textKeys.add(darkOnSurfaceKey);

              if (widget.darkThemeResetKeys != null) {
                textKeys.addAll(widget.darkThemeResetKeys!);
              }
            } else {
              textKeys.remove(darkTextBackgroundOpacityKey);
              textKeys.add(lightOnSurfaceKey);

              if (widget.lightThemeResetKeys != null) {
                textKeys.addAll(widget.lightThemeResetKeys!);
              }
            }
            await EzConfig.removeKeys(textKeys);

            widget.displayProvider.reset();
            widget.headlineProvider.reset();
            widget.titleProvider.reset();
            widget.bodyProvider.reset();
            widget.labelProvider.reset();

            backOpacity = EzConfig.getDefault(widget.opacityKey);
            backgroundColor = surface.withValues(alpha: backOpacity);
            iconSize = EzConfig.getDefault(iconSizeKey);

            setState(() {});
          },
          extraKeys: widget.extraSaveKeys,
          appName: widget.appName,
          androidPackage: widget.androidPackage,
        ),
        EzConfig.layout.separator,
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
  final List<String>? extraSaveKeys;
  final String appName;
  final String? androidPackage;

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
    required this.extraSaveKeys,
    required this.appName,
    this.androidPackage,
  });

  @override
  State<_AdvancedTextSettings> createState() => _AdvancedTextSettingsState();
}

class _AdvancedTextSettingsState extends State<_AdvancedTextSettings> {
  // Gather the build data //

  late EzTextSettingType editing = EzTextSettingType.display;

  late final String display = EzConfig.l10n.tsDisplay.toLowerCase();
  late final String headline = EzConfig.l10n.tsHeadline.toLowerCase();
  late final String title = EzConfig.l10n.tsTitle.toLowerCase();
  late final String body = EzConfig.l10n.tsBody.toLowerCase();
  late final String label = EzConfig.l10n.tsLabel.toLowerCase();

  late final List<DropdownMenuEntry<EzTextSettingType>> styleChoices =
      <DropdownMenuEntry<EzTextSettingType>>[
    DropdownMenuEntry<EzTextSettingType>(
      value: EzTextSettingType.display,
      label: display,
    ),
    DropdownMenuEntry<EzTextSettingType>(
      value: EzTextSettingType.headline,
      label: headline,
    ),
    DropdownMenuEntry<EzTextSettingType>(
      value: EzTextSettingType.title,
      label: title,
    ),
    DropdownMenuEntry<EzTextSettingType>(
      value: EzTextSettingType.body,
      label: body,
    ),
    DropdownMenuEntry<EzTextSettingType>(
      value: EzTextSettingType.label,
      label: label,
    ),
  ];

  // Define the setting controllers //

  /// Font family setting(s)
  Map<EzTextSettingType, EzFontFamilySetting> buildFamilyControls() =>
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
  Map<EzTextSettingType, Widget> buildSizeControls() {
    final Widget fontSizeIcon = EzTextBackground(
      Icon(
        Icons.text_fields_sharp,
        color: Theme.of(context).colorScheme.onSurface,
        size: widget.labelProvider.value.fontSize,
      ),
      borderRadius: textFieldRadius,
    );

    return <EzTextSettingType, Widget>{
      EzTextSettingType.display: EzFontDoubleSetting(
        key: ValueKey<String>(
            '$displayFontSizeKey-${widget.displayProvider.id}'),
        configKey: displayFontSizeKey,
        initialValue: widget.displayProvider.value.fontSize!,
        min: minDisplay,
        max: maxDisplay,
        notifierCallback: widget.displayProvider.resize,
        style: widget.bodyProvider.value,
        icon: fontSizeIcon,
        plusMinus: true,
        tooltip: EzConfig.l10n.tsFontSize,
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
        tooltip: EzConfig.l10n.tsFontSize,
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
        tooltip: EzConfig.l10n.tsFontSize,
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
        tooltip: EzConfig.l10n.tsFontSize,
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
        tooltip: EzConfig.l10n.tsFontSize,
      ),
    };
  }

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

  /// Letter EzConfig.spacing setting(s)
  Map<EzTextSettingType, EzFontDoubleSetting> buildLetterSpaceControls() {
    final Widget letterSpacingIcon = EzTextBackground(
      Icon(
        Icons.horizontal_distribute_sharp,
        color: Theme.of(context).colorScheme.onSurface,
        size: widget.labelProvider.value.fontSize,
      ),
      borderRadius: textFieldRadius,
    );

    return <EzTextSettingType, EzFontDoubleSetting>{
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
        tooltip: EzConfig.l10n.tsLetterSpacing,
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
        tooltip: EzConfig.l10n.tsLetterSpacing,
      ),
      EzTextSettingType.title: EzFontDoubleSetting(
        key: ValueKey<String>(
            '$titleLetterSpacingKey-${widget.titleProvider.id}'),
        configKey: titleLetterSpacingKey,
        initialValue: widget.titleProvider.value.letterSpacing!,
        min: minLetterSpacing,
        max: maxLetterSpacing,
        notifierCallback: widget.titleProvider.setLetterSpacing,
        style: widget.bodyProvider.value,
        icon: letterSpacingIcon,
        tooltip: EzConfig.l10n.tsLetterSpacing,
      ),
      EzTextSettingType.body: EzFontDoubleSetting(
        key:
            ValueKey<String>('$bodyLetterSpacingKey-${widget.bodyProvider.id}'),
        configKey: bodyLetterSpacingKey,
        initialValue: widget.bodyProvider.value.letterSpacing!,
        min: minLetterSpacing,
        max: maxLetterSpacing,
        notifierCallback: widget.bodyProvider.setLetterSpacing,
        style: widget.bodyProvider.value,
        icon: letterSpacingIcon,
        tooltip: EzConfig.l10n.tsLetterSpacing,
      ),
      EzTextSettingType.label: EzFontDoubleSetting(
        key: ValueKey<String>(
            '$labelLetterSpacingKey-${widget.labelProvider.id}'),
        configKey: labelLetterSpacingKey,
        initialValue: widget.labelProvider.value.letterSpacing!,
        min: minLetterSpacing,
        max: maxLetterSpacing,
        notifierCallback: widget.labelProvider.setLetterSpacing,
        style: widget.bodyProvider.value,
        icon: letterSpacingIcon,
        tooltip: EzConfig.l10n.tsLetterSpacing,
      ),
    };
  }

  /// Word EzConfig.spacing setting(s)
  Map<EzTextSettingType, EzFontDoubleSetting> buildWordSpaceControls() {
    final Widget wordSpacingIcon = EzTextBackground(
      Icon(
        Icons.space_bar_sharp,
        color: Theme.of(context).colorScheme.onSurface,
        size: widget.labelProvider.value.fontSize,
      ),
      borderRadius: textFieldRadius,
    );

    return <EzTextSettingType, EzFontDoubleSetting>{
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
        tooltip: EzConfig.l10n.tsWordSpacing,
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
        tooltip: EzConfig.l10n.tsWordSpacing,
      ),
      EzTextSettingType.title: EzFontDoubleSetting(
        key:
            ValueKey<String>('$titleWordSpacingKey-${widget.titleProvider.id}'),
        configKey: titleWordSpacingKey,
        initialValue: widget.titleProvider.value.wordSpacing!,
        min: minWordSpacing,
        max: maxWordSpacing,
        notifierCallback: widget.titleProvider.setWordSpacing,
        style: widget.bodyProvider.value,
        icon: wordSpacingIcon,
        tooltip: EzConfig.l10n.tsWordSpacing,
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
        tooltip: EzConfig.l10n.tsWordSpacing,
      ),
      EzTextSettingType.label: EzFontDoubleSetting(
        key:
            ValueKey<String>('$labelWordSpacingKey-${widget.labelProvider.id}'),
        configKey: labelWordSpacingKey,
        initialValue: widget.labelProvider.value.wordSpacing!,
        min: minWordSpacing,
        max: maxWordSpacing,
        notifierCallback: widget.labelProvider.setWordSpacing,
        style: widget.bodyProvider.value,
        icon: wordSpacingIcon,
        tooltip: EzConfig.l10n.tsWordSpacing,
      ),
    };
  }

  /// Line height setting(s)
  Map<EzTextSettingType, EzFontDoubleSetting> buildLineHeightControls() {
    final Widget lineHeightIcon = EzTextBackground(
      Icon(
        Icons.format_line_spacing_sharp,
        color: Theme.of(context).colorScheme.onSurface,
        size: widget.labelProvider.value.fontSize,
      ),
      borderRadius: textFieldRadius,
    );

    return <EzTextSettingType, EzFontDoubleSetting>{
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
        tooltip: EzConfig.l10n.tsLineHeight,
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
        tooltip: EzConfig.l10n.tsLineHeight,
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
        tooltip: EzConfig.l10n.tsLineHeight,
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
        tooltip: EzConfig.l10n.tsLineHeight,
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
        tooltip: EzConfig.l10n.tsLineHeight,
      ),
    };
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    const EzSwapSpacer swapSpacer = EzSwapSpacer(breakpoint: ScreenSize.medium);

    final EdgeInsets colMargin = EzInsets.col(EzConfig.margin);

    final Map<EzTextSettingType, EzFontFamilySetting> familyControllers =
        buildFamilyControls();
    final Map<EzTextSettingType, Widget> sizeControllers = buildSizeControls();
    final Map<EzTextSettingType, EzFontDoubleSetting> letterSpacingControllers =
        buildLetterSpaceControls();
    final Map<EzTextSettingType, EzFontDoubleSetting> wordSpacingControllers =
        buildWordSpaceControls();
    final Map<EzTextSettingType, EzFontDoubleSetting> lineHeightControllers =
        buildLineHeightControls();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        EzConfig.layout.spacer,

        // Style selector
        EzScrollView(
          scrollDirection: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          primary: false,
          children: <Widget>[
            EzText(
              EzConfig.l10n.gEditing,
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
        EzConfig.layout.spacer,

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
                EzConfig.layout.rowSpacer,
                italicsControllers[editing]!,
                EzConfig.layout.rowSpacer,
                underlineControllers[editing]!,
              ],
            ),

            // Letter, word, and line EzConfig.spacing
            if (widget.showSpacing) ...<Widget>[
              swapSpacer,
              EzScrollView(
                scrollDirection: Axis.horizontal,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  letterSpacingControllers[editing]!,
                  EzConfig.layout.rowSpacer,
                  wordSpacingControllers[editing]!,
                  EzConfig.layout.rowSpacer,
                  lineHeightControllers[editing]!,
                ],
              ),
            ],
          ],
        ),
        EzConfig.layout.separator,

        // Display preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: EzConfig.l10n.tsDisplayP1),
              EzInlineLink(
                EzConfig.l10n.tsDisplayLink,
                style: widget.displayProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(widget.displayProvider.id),
                onTap: () =>
                    setState(() => editing = EzTextSettingType.display),
                hint: EzConfig.l10n.tsLinkHint(display),
              ),
              EzPlainText(text: EzConfig.l10n.tsDisplayP2),
            ],
            textBackground: false,
            style: widget.displayProvider.value,
            textAlign: TextAlign.center,
          ),
          useSurface: true,
          margin: colMargin,
          borderRadius: ezPillShape,
        ),
        EzConfig.layout.spacer,

        // Headline preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: EzConfig.l10n.tsHeadlineP1),
              EzInlineLink(
                EzConfig.l10n.tsHeadlineLink,
                style: widget.headlineProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(widget.headlineProvider.id),
                onTap: () =>
                    setState(() => editing = EzTextSettingType.headline),
                hint: EzConfig.l10n.tsLinkHint(headline),
              ),
              EzPlainText(text: EzConfig.l10n.tsHeadlineP2),
            ],
            textBackground: false,
            style: widget.headlineProvider.value,
            textAlign: TextAlign.center,
          ),
          useSurface: true,
          margin: colMargin,
          borderRadius: ezPillShape,
        ),
        EzConfig.layout.spacer,

        // Title preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: EzConfig.l10n.tsTitleP1),
              EzInlineLink(
                EzConfig.l10n.tsTitleLink,
                style: widget.titleProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(widget.titleProvider.id),
                onTap: () => setState(() => editing = EzTextSettingType.title),
                hint: EzConfig.l10n.tsLinkHint(title),
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
        EzConfig.layout.spacer,

        // Body preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: EzConfig.l10n.tsBodyP1),
              EzInlineLink(
                EzConfig.l10n.tsBodyLink,
                style: widget.bodyProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(widget.bodyProvider.id),
                onTap: () => setState(() => editing = EzTextSettingType.body),
                hint: EzConfig.l10n.tsLinkHint(body),
              ),
              EzPlainText(text: EzConfig.l10n.tsBodyP2),
            ],
            textBackground: false,
            style: widget.bodyProvider.value,
            textAlign: TextAlign.center,
          ),
          useSurface: true,
          margin: colMargin,
          borderRadius: ezPillShape,
        ),
        EzConfig.layout.spacer,

        // Label preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: EzConfig.l10n.tsLabelP1),
              EzInlineLink(
                EzConfig.l10n.tsLabelLink,
                style: widget.labelProvider.value,
                textAlign: TextAlign.center,
                key: ValueKey<int>(widget.labelProvider.id),
                onTap: () => setState(() => editing = EzTextSettingType.label),
                hint: EzConfig.l10n.tsLinkHint(label),
              ),
              EzPlainText(text: EzConfig.l10n.tsLabelP2),
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
          dialogTitle: EzConfig.l10n.tsResetAll,
          onConfirm: () async {
            final Set<String> textKeys = allTextKeys.keys.toSet();

            if (isDarkTheme(context)) {
              textKeys.remove(lightTextBackgroundOpacityKey);
              textKeys.add(darkOnSurfaceKey);

              if (widget.darkThemeResetKeys != null) {
                textKeys.addAll(widget.darkThemeResetKeys!);
              }
            } else {
              textKeys.remove(darkTextBackgroundOpacityKey);
              textKeys.add(lightOnSurfaceKey);

              if (widget.lightThemeResetKeys != null) {
                textKeys.addAll(widget.lightThemeResetKeys!);
              }
            }
            await EzConfig.removeKeys(textKeys);

            widget.displayProvider.reset();
            widget.headlineProvider.reset();
            widget.titleProvider.reset();
            widget.bodyProvider.reset();
            widget.labelProvider.reset();

            editing = EzTextSettingType.display;

            setState(() {});
          },
          extraKeys: widget.extraSaveKeys,
          appName: widget.appName,
          androidPackage: widget.androidPackage,
        ),
        EzConfig.layout.separator,
      ],
    );
  }
}
