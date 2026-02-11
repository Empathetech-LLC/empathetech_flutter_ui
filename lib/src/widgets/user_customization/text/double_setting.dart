/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

class EzFontDoubleSetting extends StatefulWidget {
  /// The [EzConfig] key being edited
  final String configKey;

  /// An alt to updateBoth
  final String? mirrorKey;

  /// Starting (aka current) value for [configKey]
  final double initialValue;

  /// Only relevant if [plusMinus] is true
  /// Absolute amount to scale on each click
  final double delta;

  /// Optionally include plus/minus buttons surrounding the [TextFormField]
  /// Increments/decrements based on [delta]
  final bool plusMinus;

  /// Lower limit for the new value(s)
  final double min;

  /// Upper limit for the new value(s)
  final double max;

  /// Use this to live update the [TextStyle] on your UI
  final void Function(double) notifierCallback;

  /// Label [icon] below the [EzFontDoubleSetting]
  final Widget icon;

  /// [Tooltip.message] passthrough
  final String tooltip;

  /// [TextStyle] for the [TextFormField]
  final TextStyle? style;

  /// Optionally provide a [String] for setting the [EzFontDoubleSetting]s size using the results of [ezTextSize] on [sizingString]
  /// Defaults to [sampleString]
  final String sizingString;

  /// Standardized tool for updating double [TextStyle] values for the passed [configKey]
  /// For example: [TextStyle.fontSize], [TextStyle.letterSpacing], [TextStyle.wordSpacing], and [TextStyle.height]
  const EzFontDoubleSetting({
    super.key,
    required this.configKey,
    this.mirrorKey,
    required this.initialValue,
    this.delta = 1.0,
    this.plusMinus = false,
    required this.min,
    required this.max,
    required this.notifierCallback,
    required this.icon,
    required this.tooltip,
    required this.style,
    this.sizingString = sampleString,
  });

  @override
  State<EzFontDoubleSetting> createState() => _FontDoubleSettingState();
}

class _FontDoubleSettingState extends State<EzFontDoubleSetting> {
  // Define the build data //

  late double currValue;
  final TextEditingController controller = TextEditingController();

  late final Size sizeLimit = ezTextSize(
    widget.sizingString,
    context: context,
    style: widget.style,
  );

  late double formFieldWidth =
      max(sizeLimit.width + EzConfig.padding, kMinInteractiveDimension);
  late double formFieldHeight =
      max(sizeLimit.height + EzConfig.padding, kMinInteractiveDimension);

  // Init //

  @override
  void initState() {
    super.initState();
    currValue = widget.initialValue;
    controller.text = currValue.toString();
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => Tooltip(
        message: widget.tooltip,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            EzScrollView(
              scrollDirection: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Minus
                if (widget.plusMinus) ...<Widget>[
                  (currValue > widget.min)
                      ? EzIconButton(
                          onPressed: () async {
                            currValue -= widget.delta;
                            controller.text = currValue.toString();

                            await EzConfig.setDouble(
                              widget.configKey,
                              currValue,
                            );
                            if (widget.mirrorKey != null) {
                              await EzConfig.setDouble(
                                widget.mirrorKey!,
                                currValue,
                              );
                            }

                            widget.notifierCallback(currValue);
                            setState(() {});
                          },
                          tooltip:
                              '${EzConfig.l10n.gDecrease} ${widget.tooltip.toLowerCase()}',
                          icon: const Icon(Icons.remove),
                        )
                      : EzIconButton(
                          enabled: false,
                          tooltip: EzConfig.l10n.gMinimum,
                          icon: Icon(
                            Icons.remove,
                            color: EzConfig.colors.outline,
                          ),
                        ),
                  EzConfig.rowMargin,
                ],

                // Text field
                Container(
                  constraints: BoxConstraints(
                    maxWidth: formFieldWidth,
                    maxHeight: formFieldHeight,
                  ),
                  decoration: const BoxDecoration(borderRadius: ezRoundEdge),
                  child: TextFormField(
                    controller: controller,
                    style: widget.style,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.top,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    validator: (String? value) {
                      if (value == null) return null;
                      final double? doubleVale = double.tryParse(value);

                      if (doubleVale == null ||
                          doubleVale < widget.min ||
                          doubleVale > widget.max) {
                        setState(() {
                          formFieldWidth =
                              (sizeLimit.width + EzConfig.padding) * 1.75;
                          formFieldHeight =
                              (sizeLimit.height + EzConfig.padding) * 1.75;
                        });
                        return '${widget.min}  <->  ${widget.max}';
                      }

                      setState(() {
                        formFieldWidth = sizeLimit.width + EzConfig.padding;
                        formFieldHeight = sizeLimit.height + EzConfig.padding;
                      });
                      return null;
                    },
                    onFieldSubmitted: (String stringVal) async {
                      final double? doubleVal = double.tryParse(stringVal);

                      if (doubleVal == null ||
                          doubleVal > widget.max ||
                          doubleVal < widget.min) {
                        return;
                      }
                      currValue = doubleVal;

                      await EzConfig.setDouble(widget.configKey, doubleVal);
                      if (widget.mirrorKey != null) {
                        await EzConfig.setDouble(widget.mirrorKey!, doubleVal);
                      }

                      widget.notifierCallback(doubleVal);
                      setState(() {});
                    },
                  ),
                ),

                if (widget.plusMinus) ...<Widget>[
                  EzConfig.rowMargin,

                  // Plus icon
                  (currValue < widget.max)
                      ? EzIconButton(
                          onPressed: () async {
                            currValue += widget.delta;
                            controller.text = currValue.toString();

                            await EzConfig.setDouble(
                              widget.configKey,
                              currValue,
                            );
                            if (widget.mirrorKey != null) {
                              await EzConfig.setDouble(
                                widget.mirrorKey!,
                                currValue,
                              );
                            }

                            widget.notifierCallback(currValue);
                            setState(() {});
                          },
                          tooltip:
                              '${EzConfig.l10n.gIncrease} ${widget.tooltip.toLowerCase()}',
                          icon: const Icon(Icons.add),
                        )
                      : EzIconButton(
                          enabled: false,
                          tooltip: EzConfig.l10n.gMaximum,
                          icon: Icon(
                            Icons.add,
                            color: EzConfig.colors.outline,
                          ),
                        ),
                ],
              ],
            ),

            // Label icon
            widget.icon,
          ],
        ),
      );
}
