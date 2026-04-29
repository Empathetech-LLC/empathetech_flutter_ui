/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzMarginSetting extends StatelessWidget {
  /// Smallest value that can be set
  final double min;

  /// Largest value that can be set
  final double max;

  /// Number of divisions between [min] and [max]
  final int steps;

  /// Number of significant figures to display after the decimal point
  final int decimals;

  /// An ez to use margin setting
  const EzMarginSetting({
    super.key,
    required this.min,
    required this.max,
    required this.steps,
    required this.decimals,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final String configKey = EzConfig.isDark ? darkMarginKey : lightMarginKey;
    final double defaultValue = EzConfig.getDefault(configKey);

    double currValue = EzConfig.get(configKey);

    // Return the build //

    return EzElevatedIconButton(
      onPressed: () async {
        final double backup = currValue;

        await ezModal(
          context: context,
          builder: (_) => StatefulBuilder(
            builder: (BuildContext modalContext, StateSetter setModal) => EzScrollView(
              children: <Widget>[
                // Preview
                Semantics(
                  button: false,
                  readOnly: true,
                  label: EzConfig.l10n.gSetToValue(
                    EzConfig.l10n.dsMargin,
                    currValue.toStringAsFixed(decimals),
                  ),
                  child: ExcludeSemantics(
                    child: EzCol(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Title
                        Text(
                          EzConfig.l10n.dsMargin,
                          style: EzConfig.styles.titleLarge,
                          textAlign: TextAlign.center,
                        ),

                        // Preview
                        EzConfig.spacer,
                        EzTextBackground(
                          Text(
                            currValue.toStringAsFixed(decimals),
                            style: EzConfig.styles.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          padding: EzInsets.wrap(currValue),
                        ),
                        Container(
                          color: EzConfig.colors.onSurface,
                          height: heightOf(modalContext) * 0.25,
                          width: widthOf(modalContext) * 0.25,
                          child: Container(
                            decoration: BoxDecoration(
                              color: EzConfig.colors.surface,
                              image: (EzConfig.backgroundImagePath == noImageValue)
                                  ? null
                                  : EzConfig.backgroundImage,
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
                    min: min,
                    max: max,
                    divisions: steps,

                    // Slider functions
                    onChanged: (double value) => setModal(() => currValue = value),
                    onChangeEnd: (double value) async {
                      await EzConfig.setDouble(configKey, value);
                      if (EzConfig.updateBoth) {
                        await EzConfig.setDouble(
                            EzConfig.isDark ? lightMarginKey : darkMarginKey, value);
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
                      await EzConfig.remove(EzConfig.isDark ? lightMarginKey : darkMarginKey);
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
      icon: const Icon(Icons.margin),
      label: EzConfig.l10n.dsMargin,
    );
  }
}
