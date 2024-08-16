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
  final IconData icon;

  /// Message for the on hover [Tooltip]
  final String tooltip;

  /// Optionally include plus/minus buttons surrounding the [PlatformTextFormField]
  /// Increments/decrements based on [delta]
  final bool plusMinus;

  /// Only relevant if [plusMinus] is true
  final double delta;

  final TextStyle? style;

  /// Optionally provide a [String] for setting the [EzFontDoubleSetting]s size
  /// From the results of [measureText] on [sizingString]
  final String? sizingString;

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
    this.sizingString,
  });

  @override
  State<EzFontDoubleSetting> createState() => _FontDoubleSettingState();
}

class _FontDoubleSettingState extends State<EzFontDoubleSetting> {
  // Gather the theme data //

  late final TextStyle? style =
      widget.style ?? Theme.of(context).textTheme.bodyLarge;

  late final double padding = EzConfig.get(paddingKey);
  late final double lineHeight = style?.height ?? 1.5;

  late final EzSpacer pMSpacer = EzSpacer(
    space: padding / 4,
    vertical: false,
  );

  late final EFUILang l10n = EFUILang.of(context)!;

  late final Color onBackground = Theme.of(context).colorScheme.onSurface;
  late final Color outlineColor = Theme.of(context).colorScheme.outline;

  late final Size sizeLimit = measureText(
    widget.sizingString ?? widget.max.toString(),
    style: style,
    context: context,
  );

  late final double formFieldWidth = sizeLimit.width + padding;
  late final double formFieldHeight = sizeLimit.height * lineHeight + padding;

  // Define the build data //

  late double currValue;
  final TextEditingController controller = TextEditingController();

  // Return the build //

  @override
  void initState() {
    super.initState();
    currValue = widget.initialValue;
    controller.text = currValue.toString();
  }

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
              if (widget.plusMinus) ...<Widget>{
                IconButton(
                  icon: Icon(
                    PlatformIcons(context).remove,
                    color:
                        (currValue > widget.min) ? onBackground : outlineColor,
                  ),
                  onPressed: (currValue > widget.min)
                      ? () async {
                          currValue -= widget.delta;
                          await EzConfig.setDouble(widget.configKey, currValue);
                          controller.text = currValue.toString();
                          widget.notifierCallback(currValue);

                          setState(() {});
                        }
                      : doNothing,
                  tooltip: '${l10n.tsDecrease} ${widget.tooltip.toLowerCase()}',
                  alignment: Alignment.bottomCenter,
                ),
                pMSpacer,
              },

              // Text field
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: formFieldWidth,
                  maxHeight: formFieldHeight,
                ),
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(border: InputBorder.none),
                  onFieldSubmitted: (String stringVal) async {
                    final double? doubleVal = double.tryParse(stringVal);
                    if (doubleVal == null) return;

                    currValue = doubleVal;
                    await EzConfig.setDouble(widget.configKey, doubleVal);
                    widget.notifierCallback(doubleVal);
                    setState(() {});
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value == null) return null;

                    final double? doubleVale = double.tryParse(value);

                    if (doubleVale == null ||
                        doubleVale < widget.min ||
                        doubleVale > widget.max) {
                      return '${widget.min}-${widget.max}';
                    }

                    return null;
                  },
                  style: style,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),

              if (widget.plusMinus) ...<Widget>{
                pMSpacer,

                // Plus icon
                IconButton(
                  icon: Icon(
                    PlatformIcons(context).add,
                    color:
                        (currValue < widget.max) ? onBackground : outlineColor,
                  ),
                  onPressed: (currValue < widget.max)
                      ? () async {
                          currValue += widget.delta;
                          await EzConfig.setDouble(widget.configKey, currValue);
                          controller.text = currValue.toString();
                          widget.notifierCallback(currValue);

                          setState(() {});
                        }
                      : doNothing,
                  tooltip: '${l10n.tsIncrease} ${widget.tooltip.toLowerCase()}',
                  alignment: Alignment.bottomCenter,
                ),
              }
            ],
          ),
          EzSpacer(space: padding / 8),

          // Label icon
          Icon(
            widget.icon,
            size: formFieldHeight / 4,
            color: onBackground,
          ),
        ],
      ),
    );
  }
}
