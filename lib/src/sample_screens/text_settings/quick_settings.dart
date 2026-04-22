/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class QuickTextSettings extends StatefulWidget {
  // Providers
  final EzDisplayStyleProvider displayProvider;
  final EzHeadlineStyleProvider headlineProvider;
  final EzTitleStyleProvider titleProvider;
  final EzBodyStyleProvider bodyProvider;
  final EzLabelStyleProvider labelProvider;

  // Settings config
  final void Function() onUpdate;

  final List<Widget>? moreQuickHeaderSettings;
  final Widget textBlockHeader;
  final Widget textBlockFooter;
  final bool showOpacity;
  final List<Widget>? moreQuickFooterSettings;
  final Widget resetSpacer;
  final String appName;
  final String? androidPackage;
  final Set<String>? extraDark;
  final Set<String>? extraLight;
  final Set<String>? resetSkip;
  final Set<String>? saveSkip;

  const QuickTextSettings({
    super.key,
    required this.displayProvider,
    required this.headlineProvider,
    required this.titleProvider,
    required this.bodyProvider,
    required this.labelProvider,
    required this.onUpdate,
    required this.moreQuickHeaderSettings,
    required this.textBlockHeader,
    required this.textBlockFooter,
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
  State<QuickTextSettings> createState() => _QuickTextSettingsState();
}

class _QuickTextSettingsState extends State<QuickTextSettings> {
  // Gather the build data //

  late double backOpacity = EzConfig.textBackgroundOpacity;
  late Color backgroundColor =
      EzConfig.colors.surface.withValues(alpha: backOpacity);

  // Define custom functions //

  void redraw() {
    widget.onUpdate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final EdgeInsets colMargin = EzInsets.col(EzConfig.marginVal);
    final EdgeInsets wrapPadding = EdgeInsets.only(
      left: EzConfig.spacing / 2,
      right: EzConfig.spacing / 2,
      bottom: EzConfig.spacing,
    );

    // Return the build //

    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      // Required batch settings
      Wrap(children: <Widget>[
        // Font family
        Padding(
          padding: wrapPadding,
          child: EzFontFamilyBatchSetting(
            displayProvider: widget.displayProvider,
            headlineProvider: widget.headlineProvider,
            titleProvider: widget.titleProvider,
            bodyProvider: widget.bodyProvider,
            labelProvider: widget.labelProvider,
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
            ),
            backgroundColor: backgroundColor,
            buttonShape: true,
            padding: EdgeInsets.zero,
          ),
        ),
      ]),

      // Optional additional settings
      if (widget.moreQuickHeaderSettings != null)
        ...widget.moreQuickHeaderSettings!,

      widget.textBlockHeader,
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
        padding: colMargin,
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
        padding: colMargin,
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
        padding: colMargin,
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
        padding: colMargin,
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
        padding: colMargin,
      ),
      widget.textBlockFooter,

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
          padding: colMargin,
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
              if (EzConfig.updateBoth || EzConfig.isDark) {
                await EzConfig.setDouble(darkTextBackgroundOpacityKey, value);
              }
              if (EzConfig.updateBoth || !EzConfig.isDark) {
                await EzConfig.setDouble(lightTextBackgroundOpacityKey, value);
              }

              if (context.mounted) {
                EzConfig.pingRebuild(ezTextRebuildCheck(context) ||
                    (value != EzConfig.textBackgroundOpacity));
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
      const EzIconSizeSetting(),

      // Optional additional settings
      if (widget.moreQuickFooterSettings != null)
        ...widget.moreQuickFooterSettings!,

      // Reset all
      widget.resetSpacer,
      EzResetButton(
        all: false,
        redraw,
        androidPackage: widget.androidPackage,
        appName: widget.appName,
        dynamicTitle: () => EzConfig.l10n.tsReset(ezThemeString(true)),
        onConfirm: () async {
          if (EzConfig.updateBoth || EzConfig.isDark) {
            await EzConfig.removeKeys(darkTextKeys.keys.toSet());
            await EzConfig.remove(darkOnSurfaceKey);

            if (widget.extraDark != null) {
              await EzConfig.removeKeys(widget.extraDark!);
            }
          }

          if (EzConfig.updateBoth || !EzConfig.isDark) {
            await EzConfig.removeKeys(lightTextKeys.keys.toSet());
            await EzConfig.remove(lightOnSurfaceKey);

            if (widget.extraLight != null) {
              await EzConfig.removeKeys(widget.extraLight!);
            }
          }
        },
        resetSkip: widget.resetSkip,
        saveSkip: widget.saveSkip,
      ),
    ]);
  }
}
