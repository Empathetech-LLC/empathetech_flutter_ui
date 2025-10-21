/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzFontDoubleSetting extends StatefulWidget {
  /// The [EzConfig] key being edited
  final String configKey;

  /// Starting (aka current) value for [configKey]
  final double initialValue;

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

  /// Optionally include plus/minus buttons surrounding the [TextFormField]
  /// Increments/decrements based on [delta]
  final bool plusMinus;

  /// Only relevant if [plusMinus] is true
  final double delta;

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
    required this.initialValue,
    required this.min,
    required this.max,
    required this.notifierCallback,
    required this.icon,
    required this.tooltip,
    this.plusMinus = false,
    this.delta = 1.0,
    this.style,
    this.sizingString = sampleString,
  });

  @override
  State<EzFontDoubleSetting> createState() => _FontDoubleSettingState();
}

class _FontDoubleSettingState extends State<EzFontDoubleSetting> {
  // Gather the fixed theme data //

  late final double padding = EzConfig.get(paddingKey);

  late final Size sizeLimit = ezTextSize(
    widget.sizingString,
    style: widget.style ?? Theme.of(context).textTheme.bodyLarge,
    context: context,
  );

  late double formFieldWidth =
      max(sizeLimit.width + padding, kMinInteractiveDimension);
  late double formFieldHeight =
      max(sizeLimit.height + padding, kMinInteractiveDimension);

  late final EFUILang l10n = ezL10n(context);

  // Define the build data //

  late double currValue;
  final TextEditingController controller = TextEditingController();

  // Init //

  @override
  void initState() {
    super.initState();
    currValue = widget.initialValue;
    controller.text = currValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    // Gather the dynamic theme data //

    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Return the build //

    return Tooltip(
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

                          await EzConfig.setDouble(widget.configKey, currValue);
                          widget.notifierCallback(currValue);

                          setState(() {});
                        },
                        tooltip:
                            '${l10n.gDecrease} ${widget.tooltip.toLowerCase()}',
                        icon: EzIcon(PlatformIcons(context).remove),
                      )
                    : EzIconButton(
                        enabled: false,
                        tooltip: l10n.gMinimum,
                        icon: EzIcon(
                          PlatformIcons(context).remove,
                          color: colorScheme.outline,
                        ),
                      ),
                ezRowMargin,
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
                  style: widget.style ?? Theme.of(context).textTheme.bodyLarge,
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
                        formFieldWidth = (sizeLimit.width + padding) * 1.75;
                        formFieldHeight = (sizeLimit.height + padding) * 1.75;
                      });
                      return '${widget.min}  <->  ${widget.max}';
                    }

                    setState(() {
                      formFieldWidth = sizeLimit.width + padding;
                      formFieldHeight = sizeLimit.height + padding;
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

                    widget.notifierCallback(doubleVal);
                    setState(() {});
                  },
                ),
              ),

              if (widget.plusMinus) ...<Widget>[
                ezRowMargin,

                // Plus icon
                (currValue < widget.max)
                    ? EzIconButton(
                        onPressed: () async {
                          currValue += widget.delta;
                          controller.text = currValue.toString();

                          await EzConfig.setDouble(widget.configKey, currValue);
                          widget.notifierCallback(currValue);

                          setState(() {});
                        },
                        tooltip:
                            '${l10n.gIncrease} ${widget.tooltip.toLowerCase()}',
                        icon: EzIcon(PlatformIcons(context).add),
                      )
                    : EzIconButton(
                        enabled: false,
                        tooltip: l10n.gMaximum,
                        icon: EzIcon(
                          PlatformIcons(context).add,
                          color: colorScheme.outline,
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
}
