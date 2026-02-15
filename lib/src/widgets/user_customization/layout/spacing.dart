/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzSpacingSetting extends StatefulWidget {
  /// [EzConfig.rebuildUI]/[EzConfig.redrawUI] passthrough
  final void Function() onUpdate;

  /// Whether to update both themes
  final bool updateBoth;

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

  /// An easy to use spacing setting
  const EzSpacingSetting({
    super.key,
    required this.onUpdate,
    required this.updateBoth,
    required this.min,
    required this.max,
    required this.steps,
    required this.decimals,
    this.titleStyle,
    this.bodyStyle,
  });

  @override
  State<EzSpacingSetting> createState() => _LayoutSettingState();
}

class _LayoutSettingState extends State<EzSpacingSetting> {
  // Define custom functions //

  void redraw() {
    widget.onUpdate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final String configKey = EzConfig.isDark ? darkSpacingKey : lightSpacingKey;
    final double defaultValue = EzConfig.getDefault(configKey);

    double currValue = EzConfig.get(configKey);

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
                    EzConfig.l10n.lsSpacing,
                    currValue.toStringAsFixed(widget.decimals),
                  ),
                  child: ExcludeSemantics(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Title
                        Text(
                          EzConfig.l10n.lsSpacing,
                          style:
                              widget.titleStyle ?? EzConfig.styles.titleLarge,
                          textAlign: TextAlign.center,
                        ),

                        // Preview
                        EzSpacer(space: currValue),

                        EzScrollView(
                          mainAxisSize: MainAxisSize.min,
                          scrollDirection: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            EzElevatedButton(
                                enabled: false, text: EzConfig.l10n.gCurrently),
                            EzSpacer(space: currValue, vertical: false),
                            EzElevatedButton(
                              enabled: false,
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder()),
                              text: currValue.toStringAsFixed(widget.decimals),
                            ),
                          ],
                        ),

                        EzSpacer(space: currValue),
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
                    onChangeEnd: (double value) {
                      EzConfig.setDouble(configKey, value);
                      if (widget.updateBoth) {
                        EzConfig.setDouble(
                            EzConfig.isDark ? lightSpacingKey : darkSpacingKey,
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
                    if (widget.updateBoth) {
                      await EzConfig.remove(
                          EzConfig.isDark ? lightSpacingKey : darkSpacingKey);
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
      icon: const Icon(Icons.space_bar),
      label: EzConfig.l10n.lsSpacing,
    );
  }
}
