/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EzTextSettings extends StatelessWidget {
  /// Optional starting [EzTSType] target
  final EzTSType? target;

  /// [EzConfig.redrawUI]/[EzConfig.rebuildUI] passthrough
  final void Function() onUpdate;

  /// When true, updates both dark and light theme settings simultaneously
  final bool updateBoth;

  /// If provided, the "Editing: X theme" text will be a link with this callback
  final void Function()? themeLink;

  /// Spacer above the [EzResetButton] (shared by both tabs)
  final Widget resetSpacer;

  /// [EzResetButton.androidPackage] passthrough
  final String? androidPackage;

  /// [EzResetButton.appName] passthrough
  final String appName;

  /// Optional additional reset keys for the dark theme
  /// [allTextKeys] and [darkOnSurfaceKey] are included by default
  final Set<String>? resetExtraDark;

  /// Optional additional reset keys for the light theme
  /// [allTextKeys] and [lightOnSurfaceKey] are included by default
  final Set<String>? resetExtraLight;

  /// [EzResetButton.resetSkip] passthrough
  /// Shared for both themes
  final Set<String>? resetSkip;

  /// [EzResetButton.saveSkip] passthrough
  /// Shared for both themes
  final Set<String>? saveSkip;

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
    required this.onUpdate,
    this.updateBoth = false,
    this.themeLink,
    this.resetSpacer = const EzSeparator(),
    this.androidPackage,
    required this.appName,
    this.resetExtraDark,
    this.resetExtraLight,
    this.resetSkip,
    this.saveSkip,

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
            create: (_) => EzTitleStyleProvider(),
          ),
          ChangeNotifierProvider<EzBodyStyleProvider>(
            create: (_) => EzBodyStyleProvider(),
          ),
          ChangeNotifierProvider<EzLabelStyleProvider>(
            create: (_) => EzLabelStyleProvider(),
          ),
        ],
        child: _TextSettings(
          // Shared
          target: target,
          onUpdate: onUpdate,
          updateBoth: updateBoth,
          themeLink: themeLink,
          resetSpacer: resetSpacer,
          androidPackage: androidPackage,
          appName: appName,
          extraDark: resetExtraDark,
          extraLight: resetExtraLight,
          resetSkip: resetSkip,
          saveSkip: saveSkip,

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
  final void Function() onUpdate;
  final void Function()? themeLink;
  final bool updateBoth;
  final Widget resetSpacer;
  final String? androidPackage;
  final String appName;
  final Set<String>? extraDark;
  final Set<String>? extraLight;
  final Set<String>? resetSkip;
  final Set<String>? saveSkip;

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
    required this.onUpdate,
    required this.updateBoth,
    required this.themeLink,
    required this.resetSpacer,
    required this.androidPackage,
    required this.appName,
    required this.extraDark,
    required this.extraLight,
    required this.resetSkip,
    required this.saveSkip,
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

class _TextSettingsState extends State<_TextSettings> {
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

  void redraw() {
    widget.onUpdate();
    setState(() {});
  }

  // Init //

  @override
  void initState() {
    super.initState();
    ezWindowNamer(EzConfig.l10n.tsPageTitle);
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final String themeString = (widget.updateBoth
            ? EzConfig.l10n.gBothThemes
            : EzConfig.isDark
                ? EzConfig.l10n.gDarkTheme
                : EzConfig.l10n.gLightTheme)
        .toLowerCase();

    // Return the build //

    return EzScrollView(
      children: <Widget>[
        (widget.themeLink != null)
            ? EzLink(
                EzConfig.l10n.gEditing + themeString,
                onTap: widget.themeLink,
                hint: EzConfig.l10n.gEditingThemeHint,
                style: EzConfig.styles.labelLarge,
                textAlign: TextAlign.center,
              )
            : EzText(
                EzConfig.l10n.gEditing + themeString,
                style: EzConfig.styles.labelLarge,
                textAlign: TextAlign.center,
              ),
        EzConfig.margin,

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
            onUpdate: redraw,
            updateBoth: widget.updateBoth,
            showOnSurface: widget.showOnSurface,
            moreQuickHeaderSettings: widget.moreQuickHeaderSettings,
            textBlockSpacer: widget.textBlockSpacer,
            showOpacity: widget.showOpacity,
            moreQuickFooterSettings: widget.moreQuickFooterSettings,
            resetSpacer: widget.resetSpacer,
            extraDark: widget.extraDark,
            extraLight: widget.extraLight,
            appName: widget.appName,
            androidPackage: widget.androidPackage,
            resetSkip: widget.resetSkip,
            saveSkip: widget.saveSkip,
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
            onUpdate: redraw,
            updateBoth: widget.updateBoth,
            showSpacing: widget.showSpacing,
            resetSpacer: widget.resetSpacer,
            extraDark: widget.extraDark,
            extraLight: widget.extraLight,
            appName: widget.appName,
            androidPackage: widget.androidPackage,
            resetSkip: widget.resetSkip,
            saveSkip: widget.saveSkip,
          ),
      ],
    );
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
  final void Function() onUpdate;
  final bool updateBoth;
  final bool showOnSurface;
  final List<Widget>? moreQuickHeaderSettings;
  final Widget textBlockSpacer;
  final bool showOpacity;
  final List<Widget>? moreQuickFooterSettings;
  final Widget resetSpacer;
  final String appName;
  final String? androidPackage;
  final Set<String>? extraDark;
  final Set<String>? extraLight;
  final Set<String>? resetSkip;
  final Set<String>? saveSkip;

  const _QuickTextSettings({
    required this.displayProvider,
    required this.headlineProvider,
    required this.titleProvider,
    required this.bodyProvider,
    required this.labelProvider,
    required this.onUpdate,
    required this.updateBoth,
    required this.showOnSurface,
    required this.moreQuickHeaderSettings,
    required this.textBlockSpacer,
    required this.showOpacity,
    required this.moreQuickFooterSettings,
    required this.resetSpacer,
    required this.appName,
    required this.androidPackage,
    required this.extraDark,
    required this.extraLight,
    required this.resetSkip,
    required this.saveSkip,
  });

  @override
  State<_QuickTextSettings> createState() => _QuickTextSettingsState();
}

class _QuickTextSettingsState extends State<_QuickTextSettings> {
  // Gather the build data //

  late double backOpacity = EzConfig.get(EzConfig.isDark
      ? darkTextBackgroundOpacityKey
      : lightTextBackgroundOpacityKey);
  late Color backgroundColor =
      EzConfig.colors.surface.withValues(alpha: backOpacity);

  // Define custom functions //

  void redraw() {
    widget.onUpdate();
    setState(() {});
  }

  double? liveOpacity() => Theme.of(context)
      .textButtonTheme
      .style
      ?.backgroundColor
      ?.resolve(<WidgetState>{})?.a;

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final EdgeInsets colMargin = EzInsets.col(EzConfig.marginVal);
    final EdgeInsets wrapPadding = EdgeInsets.only(
      top: EzConfig.spacing,
      left: EzConfig.spacing / 2,
      right: EzConfig.spacing / 2,
    );

    final String themeString = (widget.updateBoth
            ? EzConfig.l10n.gBothThemes
            : EzConfig.isDark
                ? EzConfig.l10n.gDarkTheme
                : EzConfig.l10n.gLightTheme)
        .toLowerCase();

    // Return the build //

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
                updateBoth: widget.updateBoth,
                displayProvider: widget.displayProvider,
                headlineProvider: widget.headlineProvider,
                titleProvider: widget.titleProvider,
                bodyProvider: widget.bodyProvider,
                labelProvider: widget.labelProvider,
              ),
            ),

            // Optional onSurface Color setting
            if (!widget.updateBoth && widget.showOnSurface)
              Padding(
                padding: wrapPadding,
                child: EzColorSetting(
                  configKey:
                      EzConfig.isDark ? darkOnSurfaceKey : lightOnSurfaceKey,
                  onUpdate: (Color color) {
                    widget.displayProvider.redraw(color);
                    widget.headlineProvider.redraw(color);
                    widget.titleProvider.redraw(color);
                    widget.bodyProvider.redraw(color);
                    widget.labelProvider.redraw(color);

                    EzConfig.pingRebuild(ezTextRebuildCheck(context));
                    setState(() {});
                  },
                ),
              ),

            // Font size
            Padding(
              padding: wrapPadding,
              child: EzTextBackground(
                EzFontDoubleBatchSetting(
                  updateBoth: widget.updateBoth,
                  displayProvider: widget.displayProvider,
                  headlineProvider: widget.headlineProvider,
                  titleProvider: widget.titleProvider,
                  bodyProvider: widget.bodyProvider,
                  labelProvider: widget.labelProvider,
                ),
                backgroundColor: backgroundColor,
                borderRadius: ezPillEdge,
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
        EzConfig.spacer,

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
        EzConfig.spacer,

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
        EzConfig.spacer,

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
        EzConfig.spacer,

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
                  backgroundColor =
                      EzConfig.colors.surface.withValues(alpha: backOpacity);
                });
              },
              onChangeEnd: (double value) async {
                if (widget.updateBoth || EzConfig.isDark) {
                  await EzConfig.setDouble(darkTextBackgroundOpacityKey, value);
                }
                if (widget.updateBoth || !EzConfig.isDark) {
                  await EzConfig.setDouble(
                      lightTextBackgroundOpacityKey, value);
                }
                if (context.mounted) {
                  EzConfig.pingRebuild(ezTextRebuildCheck(context));
                }
              },

              // Slider semantics
              semanticFormatterCallback: (double value) =>
                  value.toStringAsFixed(2),
            ),
          ),
          EzConfig.spacer,
        ],

        // Icon size
        EzIconSizeSetting(updateBoth: widget.updateBoth),

        // Optional additional settings
        if (widget.moreQuickFooterSettings != null)
          ...widget.moreQuickFooterSettings!,

        // Reset all
        widget.resetSpacer,
        EzResetButton(
          redraw,
          androidPackage: widget.androidPackage,
          appName: widget.appName,
          dialogTitle: EzConfig.l10n.tsReset(widget.updateBoth &&
                  EzConfig.locale.languageCode == english.languageCode
              ? "$themeString'"
              : themeString),
          onConfirm: () async {
            if (widget.updateBoth || EzConfig.isDark) {
              EzConfig.removeKeys(darkTextKeys.keys.toSet());
              EzConfig.remove(darkOnSurfaceKey);

              if (widget.extraDark != null) {
                EzConfig.removeKeys(widget.extraDark!);
              }
            }

            if (widget.updateBoth || !EzConfig.isDark) {
              EzConfig.removeKeys(lightTextKeys.keys.toSet());
              EzConfig.remove(lightOnSurfaceKey);

              if (widget.extraLight != null) {
                EzConfig.removeKeys(widget.extraLight!);
              }
            }
          },
          resetBoth: widget.updateBoth,
          resetSkip: widget.resetSkip,
          saveSkip: widget.saveSkip,
        ),
        EzConfig.separator,
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
  final void Function() onUpdate;
  final bool updateBoth;
  final bool showSpacing;
  final Widget resetSpacer;
  final Set<String>? extraDark;
  final Set<String>? extraLight;
  final String appName;
  final String? androidPackage;
  final Set<String>? resetSkip;
  final Set<String>? saveSkip;

  const _AdvancedTextSettings({
    required this.displayProvider,
    required this.headlineProvider,
    required this.titleProvider,
    required this.bodyProvider,
    required this.labelProvider,
    required this.onUpdate,
    required this.updateBoth,
    required this.showSpacing,
    required this.resetSpacer,
    required this.extraDark,
    required this.extraLight,
    required this.appName,
    required this.androidPackage,
    required this.resetSkip,
    required this.saveSkip,
  });

  @override
  State<_AdvancedTextSettings> createState() => _AdvancedTextSettingsState();
}

class _AdvancedTextSettingsState extends State<_AdvancedTextSettings> {
  // Gather the build data //

  late EzTextSettingType editing = EzTextSettingType.display;

  // Define custom functions //

  void redraw() {
    widget.onUpdate();
    setState(() {});
  }

  /// [ThemeMode] string
  String tS() => EzConfig.isDark ? 'dark_' : 'light_';

  /// Font family setting
  EzFontSetting familyController(
    BuildContext context,
    EzTextSettingType source,
  ) {
    switch (source) {
      case EzTextSettingType.display:
        return EzFontSetting(
          key: ValueKey<String>('${tS()}font_display'),
          type: EzTextSettingType.display,
          baseStyle: widget.bodyProvider.value,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.displayProvider.fuse,
        );
      case EzTextSettingType.headline:
        return EzFontSetting(
          key: ValueKey<String>('${tS()}font_headline'),
          type: EzTextSettingType.headline,
          baseStyle: widget.bodyProvider.value,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.headlineProvider.fuse,
        );
      case EzTextSettingType.title:
        return EzFontSetting(
          key: ValueKey<String>('${tS()}font_title'),
          type: EzTextSettingType.title,
          baseStyle: widget.bodyProvider.value,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.titleProvider.fuse,
        );
      case EzTextSettingType.body:
        return EzFontSetting(
          key: ValueKey<String>('${tS()}font_body'),
          type: EzTextSettingType.body,
          baseStyle: widget.bodyProvider.value,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.bodyProvider.fuse,
        );
      case EzTextSettingType.label:
        return EzFontSetting(
          key: ValueKey<String>('${tS()}font_label'),
          type: EzTextSettingType.label,
          baseStyle: widget.bodyProvider.value,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.labelProvider.fuse,
        );
    }
  }

  /// Font size setting
  EzFontDoubleSetting sizeController(EzTextSettingType source) {
    final Widget icon = EzTextBackground(
      Icon(
        Icons.text_fields_sharp,
        color: EzConfig.colors.onSurface,
        size: widget.labelProvider.value.fontSize,
      ),
      borderRadius: ezTextFieldRadius,
    );

    switch (source) {
      case EzTextSettingType.display:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}size_display'),
          configKey: EzConfig.isDark
              ? darkDisplayFontSizeKey
              : lightDisplayFontSizeKey,
          initialValue: widget.displayProvider.value.fontSize!,
          min: minDisplay,
          max: maxDisplay,
          notifierCallback: widget.displayProvider.resize,
          style: widget.bodyProvider.value,
          icon: icon,
          plusMinus: true,
          tooltip: EzConfig.l10n.tsFontSize,
        );
      case EzTextSettingType.headline:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}size_headline'),
          configKey: EzConfig.isDark
              ? darkHeadlineFontSizeKey
              : lightHeadlineFontSizeKey,
          initialValue: widget.headlineProvider.value.fontSize!,
          min: minHeadline,
          max: maxHeadline,
          notifierCallback: widget.headlineProvider.resize,
          style: widget.bodyProvider.value,
          icon: icon,
          plusMinus: true,
          tooltip: EzConfig.l10n.tsFontSize,
        );
      case EzTextSettingType.title:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}size_title'),
          configKey:
              EzConfig.isDark ? darkTitleFontSizeKey : lightTitleFontSizeKey,
          initialValue: widget.titleProvider.value.fontSize!,
          min: minTitle,
          max: maxTitle,
          notifierCallback: widget.titleProvider.resize,
          style: widget.bodyProvider.value,
          icon: icon,
          plusMinus: true,
          tooltip: EzConfig.l10n.tsFontSize,
        );
      case EzTextSettingType.body:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}size_body'),
          configKey:
              EzConfig.isDark ? darkBodyFontSizeKey : lightBodyFontSizeKey,
          initialValue: widget.bodyProvider.value.fontSize!,
          min: minBody,
          max: maxBody,
          notifierCallback: widget.bodyProvider.resize,
          style: widget.bodyProvider.value,
          icon: icon,
          plusMinus: true,
          tooltip: EzConfig.l10n.tsFontSize,
        );
      case EzTextSettingType.label:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}size_label'),
          configKey:
              EzConfig.isDark ? darkLabelFontSizeKey : lightLabelFontSizeKey,
          initialValue: widget.labelProvider.value.fontSize!,
          min: minLabel,
          max: maxLabel,
          notifierCallback: widget.labelProvider.resize,
          style: widget.bodyProvider.value,
          icon: icon,
          plusMinus: true,
          tooltip: EzConfig.l10n.tsFontSize,
        );
    }
  }

  /// Bold (font weight) setting
  EzBoldSetting boldController(EzTextSettingType source) {
    switch (source) {
      case EzTextSettingType.display:
        return EzBoldSetting(
          key: ValueKey<String>('${tS()}bold_display'),
          type: EzTextSettingType.display,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.displayProvider.bold,
        );
      case EzTextSettingType.headline:
        return EzBoldSetting(
          key: ValueKey<String>('${tS()}bold_headline'),
          type: EzTextSettingType.headline,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.headlineProvider.bold,
        );
      case EzTextSettingType.title:
        return EzBoldSetting(
          key: ValueKey<String>('${tS()}bold_title'),
          type: EzTextSettingType.title,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.titleProvider.bold,
        );
      case EzTextSettingType.body:
        return EzBoldSetting(
          key: ValueKey<String>('${tS()}bold_body'),
          type: EzTextSettingType.body,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.bodyProvider.bold,
        );
      case EzTextSettingType.label:
        return EzBoldSetting(
          key: ValueKey<String>('${tS()}bold_label'),
          type: EzTextSettingType.label,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.labelProvider.bold,
        );
    }
  }

  /// Italic (font style) setting
  EzItalicSetting italicsController(EzTextSettingType source) {
    switch (source) {
      case EzTextSettingType.display:
        return EzItalicSetting(
          key: ValueKey<String>('${tS()}italic_display'),
          type: EzTextSettingType.display,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.displayProvider.italic,
        );
      case EzTextSettingType.headline:
        return EzItalicSetting(
          key: ValueKey<String>('${tS()}italic_headline'),
          type: EzTextSettingType.headline,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.headlineProvider.italic,
        );
      case EzTextSettingType.title:
        return EzItalicSetting(
          key: ValueKey<String>('${tS()}italic_title'),
          type: EzTextSettingType.title,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.titleProvider.italic,
        );
      case EzTextSettingType.body:
        return EzItalicSetting(
          key: ValueKey<String>('${tS()}italic_body'),
          type: EzTextSettingType.body,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.bodyProvider.italic,
        );
      case EzTextSettingType.label:
        return EzItalicSetting(
          key: ValueKey<String>('${tS()}italic_label'),
          type: EzTextSettingType.label,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.labelProvider.italic,
        );
    }
  }

  /// Underline (decoration) setting
  EzUnderlineSetting underlineController(EzTextSettingType source) {
    switch (source) {
      case EzTextSettingType.display:
        return EzUnderlineSetting(
          key: ValueKey<String>('${tS()}underline_display'),
          type: EzTextSettingType.display,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.displayProvider.underline,
        );
      case EzTextSettingType.headline:
        return EzUnderlineSetting(
          key: ValueKey<String>('${tS()}underline_headline'),
          type: EzTextSettingType.headline,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.headlineProvider.underline,
        );
      case EzTextSettingType.title:
        return EzUnderlineSetting(
          key: ValueKey<String>('${tS()}underline_title'),
          type: EzTextSettingType.title,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.titleProvider.underline,
        );
      case EzTextSettingType.body:
        return EzUnderlineSetting(
          key: ValueKey<String>('${tS()}underline_body'),
          type: EzTextSettingType.body,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.bodyProvider.underline,
        );
      case EzTextSettingType.label:
        return EzUnderlineSetting(
          key: ValueKey<String>('${tS()}underline_label'),
          type: EzTextSettingType.label,
          updateBoth: widget.updateBoth,
          notifierCallback: widget.labelProvider.underline,
        );
    }
  }

  /// Letter spacing setting
  EzFontDoubleSetting letterSpacingController(EzTextSettingType source) {
    final Widget icon = EzTextBackground(
      Icon(
        Icons.horizontal_distribute_sharp,
        color: EzConfig.colors.onSurface,
        size: widget.labelProvider.value.fontSize,
      ),
      borderRadius: ezTextFieldRadius,
    );
    switch (source) {
      case EzTextSettingType.display:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}letter_spacing_display'),
          configKey: EzConfig.isDark
              ? darkDisplayWordSpacingKey
              : lightDisplayWordSpacingKey,
          initialValue: widget.displayProvider.value.letterSpacing!,
          min: minLetterSpacing,
          max: maxLetterSpacing,
          notifierCallback: widget.displayProvider.setLetterSpacing,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsLetterSpacing,
        );
      case EzTextSettingType.headline:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}letter_spacing_headline'),
          configKey: EzConfig.isDark
              ? darkHeadlineWordSpacingKey
              : lightHeadlineWordSpacingKey,
          initialValue: widget.headlineProvider.value.letterSpacing!,
          min: minLetterSpacing,
          max: maxLetterSpacing,
          notifierCallback: widget.headlineProvider.setLetterSpacing,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsLetterSpacing,
        );
      case EzTextSettingType.title:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}letter_spacing_title'),
          configKey: EzConfig.isDark
              ? darkTitleWordSpacingKey
              : lightTitleWordSpacingKey,
          initialValue: widget.titleProvider.value.letterSpacing!,
          min: minLetterSpacing,
          max: maxLetterSpacing,
          notifierCallback: widget.titleProvider.setLetterSpacing,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsLetterSpacing,
        );
      case EzTextSettingType.body:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}letter_spacing_body'),
          configKey: EzConfig.isDark
              ? darkBodyWordSpacingKey
              : lightBodyWordSpacingKey,
          initialValue: widget.bodyProvider.value.letterSpacing!,
          min: minLetterSpacing,
          max: maxLetterSpacing,
          notifierCallback: widget.bodyProvider.setLetterSpacing,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsLetterSpacing,
        );
      case EzTextSettingType.label:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}letter_spacing_label'),
          configKey: EzConfig.isDark
              ? darkLabelWordSpacingKey
              : lightLabelWordSpacingKey,
          initialValue: widget.labelProvider.value.letterSpacing!,
          min: minLetterSpacing,
          max: maxLetterSpacing,
          notifierCallback: widget.labelProvider.setLetterSpacing,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsLetterSpacing,
        );
    }
  }

  /// Word spacing setting
  EzFontDoubleSetting wordSpacingController(EzTextSettingType source) {
    final Widget icon = EzTextBackground(
      Icon(
        Icons.space_bar_sharp,
        color: EzConfig.colors.onSurface,
        size: widget.labelProvider.value.fontSize,
      ),
      borderRadius: ezTextFieldRadius,
    );

    switch (source) {
      case EzTextSettingType.display:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}word_spacing_display'),
          configKey: EzConfig.isDark
              ? darkDisplayWordSpacingKey
              : lightDisplayWordSpacingKey,
          initialValue: widget.displayProvider.value.wordSpacing!,
          min: minWordSpacing,
          max: maxWordSpacing,
          notifierCallback: widget.displayProvider.setWordSpacing,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsWordSpacing,
        );
      case EzTextSettingType.headline:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}word_spacing_headline'),
          configKey: EzConfig.isDark
              ? darkHeadlineWordSpacingKey
              : lightHeadlineWordSpacingKey,
          initialValue: widget.headlineProvider.value.wordSpacing!,
          min: minWordSpacing,
          max: maxWordSpacing,
          notifierCallback: widget.headlineProvider.setWordSpacing,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsWordSpacing,
        );
      case EzTextSettingType.title:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}word_spacing_title'),
          configKey: EzConfig.isDark
              ? darkTitleWordSpacingKey
              : lightTitleWordSpacingKey,
          initialValue: widget.titleProvider.value.wordSpacing!,
          min: minWordSpacing,
          max: maxWordSpacing,
          notifierCallback: widget.titleProvider.setWordSpacing,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsWordSpacing,
        );
      case EzTextSettingType.body:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}word_spacing_body'),
          configKey: EzConfig.isDark
              ? darkBodyWordSpacingKey
              : lightBodyWordSpacingKey,
          initialValue: widget.bodyProvider.value.wordSpacing!,
          min: minWordSpacing,
          max: maxWordSpacing,
          notifierCallback: widget.bodyProvider.setWordSpacing,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsWordSpacing,
        );
      case EzTextSettingType.label:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}word_spacing_label'),
          configKey: EzConfig.isDark
              ? darkLabelWordSpacingKey
              : lightLabelWordSpacingKey,
          initialValue: widget.labelProvider.value.wordSpacing!,
          min: minWordSpacing,
          max: maxWordSpacing,
          notifierCallback: widget.labelProvider.setWordSpacing,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsWordSpacing,
        );
    }
  }

  /// Line height setting
  EzFontDoubleSetting lineHeightController(EzTextSettingType source) {
    final Widget icon = EzTextBackground(
      Icon(
        Icons.format_line_spacing_sharp,
        color: EzConfig.colors.onSurface,
        size: widget.labelProvider.value.fontSize,
      ),
      borderRadius: ezTextFieldRadius,
    );

    switch (source) {
      case EzTextSettingType.display:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}line_height_display'),
          configKey: EzConfig.isDark
              ? darkDisplayFontHeightKey
              : lightDisplayFontHeightKey,
          initialValue: widget.displayProvider.value.height!,
          min: minFontHeight,
          max: maxFontHeight,
          notifierCallback: widget.displayProvider.setHeight,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsLineHeight,
        );
      case EzTextSettingType.headline:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}line_height_headline'),
          configKey: EzConfig.isDark
              ? darkHeadlineFontHeightKey
              : lightHeadlineFontHeightKey,
          initialValue: widget.headlineProvider.value.height!,
          min: minFontHeight,
          max: maxFontHeight,
          notifierCallback: widget.headlineProvider.setHeight,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsLineHeight,
        );
      case EzTextSettingType.title:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}line_height_title'),
          configKey: EzConfig.isDark
              ? darkTitleFontHeightKey
              : lightTitleFontHeightKey,
          initialValue: widget.titleProvider.value.height!,
          min: minFontHeight,
          max: maxFontHeight,
          notifierCallback: widget.titleProvider.setHeight,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsLineHeight,
        );
      case EzTextSettingType.body:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}line_height_body'),
          configKey:
              EzConfig.isDark ? darkBodyFontHeightKey : lightBodyFontHeightKey,
          initialValue: widget.bodyProvider.value.height!,
          min: minFontHeight,
          max: maxFontHeight,
          notifierCallback: widget.bodyProvider.setHeight,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsLineHeight,
        );
      case EzTextSettingType.label:
        return EzFontDoubleSetting(
          key: ValueKey<String>('${tS()}line_height_label'),
          configKey: EzConfig.isDark
              ? darkLabelFontHeightKey
              : lightLabelFontHeightKey,
          initialValue: widget.labelProvider.value.height!,
          min: minFontHeight,
          max: maxFontHeight,
          notifierCallback: widget.labelProvider.setHeight,
          style: widget.bodyProvider.value,
          icon: icon,
          tooltip: EzConfig.l10n.tsLineHeight,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final EdgeInsets colMargin = EzInsets.col(EzConfig.marginVal);
    const EzSwapSpacer swapSpacer = EzSwapSpacer(breakpoint: ScreenSize.medium);

    final String themeString = (widget.updateBoth
            ? EzConfig.l10n.gBothThemes
            : EzConfig.isDark
                ? EzConfig.l10n.gDarkTheme
                : EzConfig.l10n.gLightTheme)
        .toLowerCase();

    // Return the build //

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        EzConfig.spacer,

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
            EzConfig.margin,
            EzDropdownMenu<EzTextSettingType>(
              widthEntries: <String>[EzConfig.l10n.tsHeadline],
              textStyle: widget.labelProvider.value,
              dropdownMenuEntries: <DropdownMenuEntry<EzTextSettingType>>[
                DropdownMenuEntry<EzTextSettingType>(
                  value: EzTextSettingType.display,
                  label: EzConfig.l10n.tsDisplay.toLowerCase(),
                ),
                DropdownMenuEntry<EzTextSettingType>(
                  value: EzTextSettingType.headline,
                  label: EzConfig.l10n.tsHeadline.toLowerCase(),
                ),
                DropdownMenuEntry<EzTextSettingType>(
                  value: EzTextSettingType.title,
                  label: EzConfig.l10n.tsTitle.toLowerCase(),
                ),
                DropdownMenuEntry<EzTextSettingType>(
                  value: EzTextSettingType.body,
                  label: EzConfig.l10n.tsBody.toLowerCase(),
                ),
                DropdownMenuEntry<EzTextSettingType>(
                  value: EzTextSettingType.label,
                  label: EzConfig.l10n.tsLabel.toLowerCase(),
                ),
              ],
              enableSearch: false,
              initialSelection: editing,
              onSelected: (EzTextSettingType? value) {
                if (value != null) setState(() => editing = value);
              },
            ),
          ],
        ),
        EzConfig.spacer,

        // Controls
        EzRowCol.sym(
          breakpoint: ScreenSize.medium,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Font family
            familyController(context, editing),
            swapSpacer,

            // Font size
            sizeController(editing),
            swapSpacer,

            // Font weight, style, and decoration
            EzScrollView(
              scrollDirection: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                boldController(editing),
                EzConfig.rowSpacer,
                italicsController(editing),
                EzConfig.rowSpacer,
                underlineController(editing),
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
                  letterSpacingController(editing),
                  EzConfig.rowSpacer,
                  wordSpacingController(editing),
                  EzConfig.rowSpacer,
                  lineHeightController(editing),
                ],
              ),
            ],
          ],
        ),
        EzConfig.separator,

        // Display preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: EzConfig.l10n.tsDisplayP1),
              EzInlineLink(
                EzConfig.l10n.tsDisplayLink,
                style: widget.displayProvider.value,
                textAlign: TextAlign.center,
                onTap: () =>
                    setState(() => editing = EzTextSettingType.display),
                hint: EzConfig.l10n
                    .tsLinkHint(EzConfig.l10n.tsDisplay.toLowerCase()),
              ),
              EzPlainText(text: EzConfig.l10n.tsDisplayP2),
            ],
            textBackground: false,
            style: widget.displayProvider.value,
            textAlign: TextAlign.center,
          ),
          useSurface: true,
          margin: colMargin,
          borderRadius: ezPillEdge,
        ),
        EzConfig.spacer,

        // Headline preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: EzConfig.l10n.tsHeadlineP1),
              EzInlineLink(
                EzConfig.l10n.tsHeadlineLink,
                style: widget.headlineProvider.value,
                textAlign: TextAlign.center,
                onTap: () =>
                    setState(() => editing = EzTextSettingType.headline),
                hint: EzConfig.l10n
                    .tsLinkHint(EzConfig.l10n.tsHeadline.toLowerCase()),
              ),
              EzPlainText(text: EzConfig.l10n.tsHeadlineP2),
            ],
            textBackground: false,
            style: widget.headlineProvider.value,
            textAlign: TextAlign.center,
          ),
          useSurface: true,
          margin: colMargin,
          borderRadius: ezPillEdge,
        ),
        EzConfig.spacer,

        // Title preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: EzConfig.l10n.tsTitleP1),
              EzInlineLink(
                EzConfig.l10n.tsTitleLink,
                style: widget.titleProvider.value,
                textAlign: TextAlign.center,
                onTap: () => setState(() => editing = EzTextSettingType.title),
                hint: EzConfig.l10n
                    .tsLinkHint(EzConfig.l10n.tsTitle.toLowerCase()),
              ),
            ],
            textBackground: false,
            style: widget.titleProvider.value,
            textAlign: TextAlign.center,
          ),
          useSurface: true,
          margin: colMargin,
          borderRadius: ezPillEdge,
        ),
        EzConfig.spacer,

        // Body preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: EzConfig.l10n.tsBodyP1),
              EzInlineLink(
                EzConfig.l10n.tsBodyLink,
                style: widget.bodyProvider.value,
                textAlign: TextAlign.center,
                onTap: () => setState(() => editing = EzTextSettingType.body),
                hint: EzConfig.l10n
                    .tsLinkHint(EzConfig.l10n.tsBody.toLowerCase()),
              ),
              EzPlainText(text: EzConfig.l10n.tsBodyP2),
            ],
            textBackground: false,
            style: widget.bodyProvider.value,
            textAlign: TextAlign.center,
          ),
          useSurface: true,
          margin: colMargin,
          borderRadius: ezPillEdge,
        ),
        EzConfig.spacer,

        // Label preview
        EzTextBackground(
          EzRichText(
            <InlineSpan>[
              EzPlainText(text: EzConfig.l10n.tsLabelP1),
              EzInlineLink(
                EzConfig.l10n.tsLabelLink,
                style: widget.labelProvider.value,
                textAlign: TextAlign.center,
                onTap: () => setState(() => editing = EzTextSettingType.label),
                hint: EzConfig.l10n
                    .tsLinkHint(EzConfig.l10n.tsLabel.toLowerCase()),
              ),
              EzPlainText(text: EzConfig.l10n.tsLabelP2),
            ],
            textBackground: false,
            style: widget.labelProvider.value,
            textAlign: TextAlign.center,
          ),
          useSurface: true,
          margin: colMargin,
          borderRadius: ezPillEdge,
        ),

        // Reset all
        widget.resetSpacer,
        EzResetButton(
          redraw,
          androidPackage: widget.androidPackage,
          appName: widget.appName,
          dialogTitle: EzConfig.l10n.tsReset(widget.updateBoth &&
                  EzConfig.locale.languageCode == english.languageCode
              ? "$themeString'"
              : themeString),
          onConfirm: () async {
            if (widget.updateBoth || EzConfig.isDark) {
              EzConfig.removeKeys(darkTextKeys.keys.toSet());
              EzConfig.remove(darkOnSurfaceKey);

              if (widget.extraDark != null) {
                EzConfig.removeKeys(widget.extraDark!);
              }
            }

            if (widget.updateBoth || !EzConfig.isDark) {
              EzConfig.removeKeys(lightTextKeys.keys.toSet());
              EzConfig.remove(lightOnSurfaceKey);

              if (widget.extraLight != null) {
                EzConfig.removeKeys(widget.extraLight!);
              }
            }

            setState(() => editing = EzTextSettingType.display);
          },
          resetBoth: widget.updateBoth,
          resetSkip: widget.resetSkip,
          saveSkip: widget.saveSkip,
        ),
        EzConfig.separator,
      ],
    );
  }
}
