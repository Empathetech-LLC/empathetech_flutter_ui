/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzPaddingSetting extends StatefulWidget {
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

  /// An ez to use padding setting
  const EzPaddingSetting({
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
  State<EzPaddingSetting> createState() => _LayoutSettingState();
}

class _LayoutSettingState extends State<EzPaddingSetting> {
  // Define custom functions //

  void redraw() {
    widget.onUpdate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final String configKey = EzConfig.isDark ? darkPaddingKey : lightPaddingKey;
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
                    EzConfig.l10n.lsPadding,
                    currValue.toStringAsFixed(widget.decimals),
                  ),
                  child: ExcludeSemantics(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Title
                        Text(
                          EzConfig.l10n.lsPadding,
                          style:
                              widget.titleStyle ?? EzConfig.styles.titleLarge,
                          textAlign: TextAlign.center,
                        ),

                        // Preview
                        EzConfig.spacer,
                        EzScrollView(
                          mainAxisSize: MainAxisSize.min,
                          scrollDirection: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            EzElevatedButton(
                              enabled: false,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(currValue),
                              ),
                              text: EzConfig.l10n.gCurrently,
                            ),
                            EzConfig.rowSpacer,
                            EzElevatedButton(
                              enabled: false,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(currValue),
                                shape: const CircleBorder(),
                              ),
                              text: currValue.toStringAsFixed(widget.decimals),
                            ),
                          ],
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
                      if (widget.updateBoth) {
                        await EzConfig.setDouble(
                            EzConfig.isDark ? lightPaddingKey : darkPaddingKey,
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
                          EzConfig.isDark ? lightPaddingKey : darkPaddingKey);
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
      icon: const Icon(Icons.padding),
      label: EzConfig.l10n.lsPadding,
    );
  }
}
