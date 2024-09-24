/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzFontDoubleSetting extends StatefulWidget {
  /// The [EzConfig] key being edited
  final String configKey;

  final double initialValue;
  final double min;
  final double max;

  /// Use this to live update the [TextStyle] on your UI
  final void Function(double) notifierCallback;

  /// Label [icon] below the [EzFontDoubleSetting]
  final Widget icon;

  /// Message for the on hover [Tooltip]
  final String tooltip;

  /// Optionally include plus/minus buttons surrounding the [TextFormField]
  /// Increments/decrements based on [delta]
  final bool plusMinus;

  /// Only relevant if [plusMinus] is true
  final double delta;

  /// [TextStyle] for the [TextFormField]
  final TextStyle? style;

  /// Optionally provide a [String] for setting the [EzFontDoubleSetting]s size using the results of [measureText] on [sizingString]
  /// Defaults to [sampleString]
  final String sizingString;

  /// Standardized tool for updating double [TextStyle] values for the passed [configKey]
  /// For example: [TextStyle.letterSpacing]
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
  // Gather the theme data //

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  late final String oKey =
      isDarkTheme(context) ? darkTextBackgroundOKey : lightTextBackgroundOKey;
  late final double fieldOpacity =
      EzConfig.get(oKey) ?? EzConfig.getDefault(oKey) ?? 0.0;
  late final Color fieldColor = colorScheme.surface.withOpacity(fieldOpacity);

  late final double padding = EzConfig.get(paddingKey);

  late final EzSpacer pMSpacer = EzSpacer(
    space: padding / 2,
    vertical: false,
  );

  late final Size sizeLimit = measureText(
    widget.sizingString,
    style: style,
    context: context,
  );

  late double formFieldWidth = sizeLimit.width + padding;
  late double formFieldHeight = sizeLimit.height + padding;

  late final TextStyle? style =
      widget.style ?? Theme.of(context).textTheme.bodyLarge;

  late final EFUILang l10n = EFUILang.of(context)!;

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

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Minus
              if (widget.plusMinus) ...<Widget>[
                IconButton(
                  style: IconButton.styleFrom(
                    side: BorderSide(color: colorScheme.primaryContainer),
                  ),
                  onPressed: (currValue > widget.min)
                      ? () async {
                          currValue -= widget.delta;
                          controller.text = currValue.toString();

                          await EzConfig.setDouble(widget.configKey, currValue);
                          widget.notifierCallback(currValue);

                          setState(() {});
                        }
                      : doNothing,
                  tooltip: '${l10n.tsDecrease} ${widget.tooltip.toLowerCase()}',
                  icon: Icon(
                    PlatformIcons(context).remove,
                    color: (currValue > widget.min)
                        ? colorScheme.primary
                        : colorScheme.outline,
                  ),
                ),
                pMSpacer,
              ],

              // Text field
              Container(
                constraints: BoxConstraints(
                  maxWidth: formFieldWidth,
                  maxHeight: formFieldHeight,
                ),
                decoration: BoxDecoration(
                  color: fieldColor,
                  borderRadius: ezRoundEdge,
                ),
                child: TextFormField(
                  controller: controller,
                  style: style,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
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
                        formFieldWidth = (sizeLimit.width + padding) * 2;
                        formFieldHeight = (sizeLimit.height + padding) * 2;
                      });
                      return '${widget.min} <--> ${widget.max}';
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
                        doubleVal < widget.min) return;

                    currValue = doubleVal;
                    await EzConfig.setDouble(widget.configKey, doubleVal);

                    widget.notifierCallback(doubleVal);
                    setState(() {});
                  },
                ),
              ),

              if (widget.plusMinus) ...<Widget>[
                pMSpacer,

                // Plus icon
                IconButton(
                  style: IconButton.styleFrom(
                    side: BorderSide(color: colorScheme.primaryContainer),
                  ),
                  onPressed: (currValue < widget.max)
                      ? () async {
                          currValue += widget.delta;
                          controller.text = currValue.toString();

                          await EzConfig.setDouble(widget.configKey, currValue);
                          widget.notifierCallback(currValue);

                          setState(() {});
                        }
                      : doNothing,
                  tooltip: '${l10n.tsIncrease} ${widget.tooltip.toLowerCase()}',
                  icon: Icon(
                    PlatformIcons(context).add,
                    color: (currValue < widget.max)
                        ? colorScheme.primary
                        : colorScheme.outline,
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
