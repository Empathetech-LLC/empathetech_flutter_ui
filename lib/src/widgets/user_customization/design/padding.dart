/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzPaddingSetting extends StatelessWidget {
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
    required this.min,
    required this.max,
    required this.steps,
    required this.decimals,
    this.titleStyle,
    this.bodyStyle,
  });

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
              children: <Widget>[
                // Preview
                Semantics(
                  button: false,
                  readOnly: true,
                  label: EzConfig.l10n.gSetToValue(
                    EzConfig.l10n.dsPadding,
                    currValue.toStringAsFixed(decimals),
                  ),
                  child: ExcludeSemantics(
                    child: EzCol(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Title
                        Text(
                          EzConfig.l10n.dsPadding,
                          style: titleStyle ?? EzConfig.styles.titleLarge,
                          textAlign: TextAlign.center,
                        ),

                        // Preview
                        EzConfig.spacer,
                        EzScrollView(
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
                              text: currValue.toStringAsFixed(decimals),
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
                    min: min,
                    max: max,
                    divisions: steps,

                    // Slider functions
                    onChanged: (double value) => setModal(() => currValue = value),
                    onChangeEnd: (double value) async {
                      await EzConfig.setDouble(configKey, value);
                      if (EzConfig.updateBoth) {
                        await EzConfig.setDouble(
                            EzConfig.isDark ? lightPaddingKey : darkPaddingKey, value);
                      }
                    },

                    // Slider semantics
                    semanticFormatterCallback: (double value) => value.toStringAsFixed(decimals),
                  ),
                ),
                EzConfig.spacer,

                // Reset button
                EzElevatedIconButton(
                  onPressed: () async {
                    await EzConfig.remove(configKey);
                    if (EzConfig.updateBoth) {
                      await EzConfig.remove(EzConfig.isDark ? lightPaddingKey : darkPaddingKey);
                    }
                    setModal(() => currValue = defaultValue);
                  },
                  icon: const Icon(Icons.refresh),
                  label: '${EzConfig.l10n.gResetTo} ${defaultValue.toStringAsFixed(decimals)}',
                ),
                EzConfig.separator,
              ],
            ),
          ),
        );

        if (currValue != backup) await EzConfig.rebuildUI();
      },
      icon: const Icon(Icons.padding),
      label: EzConfig.l10n.dsPadding,
    );
  }
}
