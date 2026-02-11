/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzMarginSetting extends StatefulWidget {
  /// [EzConfig.rebuildUI]/[EzConfig.redrawUI] passthrough
  final void Function() onUpdate;

  /// Whether to update both themes
  final bool setBoth;

  /// Smallest value that can be set
  final double min;

  /// Largest value that can be set
  final double max;

  /// Number of divisions between [min] and [max]
  final int steps;

  /// Number of significant figures to display after the decimal point
  final int decimals;

  /// Defaults to [TextTheme.titleLarge]
  final TextStyle? titleStyle;

  /// Defaults to [TextTheme.bodyLarge]
  final TextStyle? bodyStyle;

  /// An ez to use margin setting
  const EzMarginSetting({
    super.key,
    required this.onUpdate,
    required this.setBoth,
    required this.min,
    required this.max,
    required this.steps,
    required this.decimals,
    this.titleStyle,
    this.bodyStyle,
  });

  @override
  State<EzMarginSetting> createState() => _LayoutSettingState();
}

class _LayoutSettingState extends State<EzMarginSetting> {
  // Define custom functions //

  void redraw() {
    widget.onUpdate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final String configKey = EzConfig.isDark ? darkMarginKey : lightMarginKey;
    final double defaultValue = EzConfig.getDefault(configKey);

    double currValue = EzConfig.get(configKey);

    late final String? backgroundImagePath = EzConfig.get(
        EzConfig.isDark ? darkBackgroundImageKey : lightBackgroundImageKey);

    late final BoxFit? backgroundImageFit = boxFitLib[EzConfig.get(
        EzConfig.isDark
            ? '$darkBackgroundImageKey$boxFitSuffix'
            : '$lightBackgroundImageKey$boxFitSuffix')];

    // Return the build //

    return EzElevatedIconButton(
      onPressed: () async {
        final double backup = currValue;

        await ezModal(
          context: context,
          builder: (_) => StatefulBuilder(
            builder: (_, StateSetter setModal) => EzScrollView(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Preview
                Semantics(
                  button: false,
                  readOnly: true,
                  label: EzConfig.l10n.gSetToValue(
                    EzConfig.l10n.lsMargin,
                    currValue.toStringAsFixed(widget.decimals),
                  ),
                  child: ExcludeSemantics(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Title
                        Text(
                          EzConfig.l10n.lsMargin,
                          style:
                              widget.titleStyle ?? EzConfig.styles.titleLarge,
                          textAlign: TextAlign.center,
                        ),

                        // Preview
                        EzConfig.spacer,
                        EzTextBackground(
                          Text(
                            currValue.toStringAsFixed(widget.decimals),
                            style: widget.bodyStyle ??
                                EzConfig.styles.bodyLarge
                                    ?.copyWith(color: EzConfig.colors.surface),
                            textAlign: TextAlign.center,
                          ),
                          margin: EzInsets.wrap(currValue),
                          backgroundColor: EzConfig.colors.onSurface,
                        ),
                        EzSpacer(space: currValue),
                        Container(
                          color: EzConfig.colors.onSurface,
                          height: heightOf(context) * 0.25,
                          width: widthOf(context) * 0.25,
                          child: Container(
                            decoration: BoxDecoration(
                              color: EzConfig.colors.surface,
                              image: (backgroundImagePath == null ||
                                      backgroundImagePath == noImageValue)
                                  ? null
                                  : DecorationImage(
                                      image:
                                          ezImageProvider(backgroundImagePath),
                                      fit: backgroundImageFit,
                                    ),
                            ),
                            margin: EdgeInsets.all(currValue * 0.25),
                          ),
                        ),
                        EzConfig.spacer,
                      ],
                    ),
                  ),
                ),

                // Slider
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: ScreenSize.small.size),
                  child: Slider(
                    // Slider values
                    value: currValue,
                    min: widget.min,
                    max: widget.max,
                    divisions: widget.steps,

                    // Slider functions
                    onChanged: (double value) =>
                        setModal(() => currValue = value),
                    onChangeEnd: (double value) async {
                      await EzConfig.setDouble(configKey, value);
                      if (widget.setBoth) {
                        await EzConfig.setDouble(
                            EzConfig.isDark ? lightMarginKey : darkMarginKey,
                            value);
                      }
                    },

                    // Slider semantics
                    semanticFormatterCallback: (double value) =>
                        value.toStringAsFixed(widget.decimals),
                  ),
                ),
                EzConfig.spacer,

                // Reset button
                EzElevatedIconButton(
                  onPressed: () async {
                    await EzConfig.remove(configKey);
                    if (widget.setBoth) {
                      await EzConfig.remove(
                          EzConfig.isDark ? lightMarginKey : darkMarginKey);
                    }
                    setModal(() => currValue = defaultValue);
                  },
                  icon: const Icon(Icons.refresh),
                  label:
                      '${EzConfig.l10n.gResetTo} ${defaultValue.toStringAsFixed(widget.decimals)}',
                ),
                EzSpacer(space: EzConfig.spacing * 1.5),
              ],
            ),
          ),
        );

        if (currValue != backup) {
          await EzConfig.rebuildUI(redraw);
        }
      },
      icon: const Icon(Icons.margin),
      label: EzConfig.l10n.lsMargin,
    );
  }
}
