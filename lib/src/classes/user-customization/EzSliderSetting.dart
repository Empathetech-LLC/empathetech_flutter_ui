/* empathetech_flutter_ui
 * Copyright (c) 2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzSliderSetting extends StatefulWidget {
  /// The [EzConfig] key whose value is being updated
  final String prefsKey;

  /// enum for determining the preview Widget(s) required
  final SliderSettingType type;

  /// Smallest value that can be set
  final double min;

  /// Largest value that can be set
  final double max;

  /// Number of divisions between [min] and [max]
  final int steps;

  /// Number of significant figures to display AFTER the decimal point
  final int decimals;

  /// Creates a tool for updating any [prefsKey] value that would pair well with a [PlatformSlider]
  /// Use the [type] enum for generating the appropriate preview [Widget]s
  const EzSliderSetting({
    Key? key,
    required this.prefsKey,
    required this.type,
    required this.min,
    required this.max,
    required this.steps,
    required this.decimals,
  }) : super(key: key);

  @override
  _SliderSettingState createState() => _SliderSettingState();
}

class _SliderSettingState extends State<EzSliderSetting> {
  // Gather the theme data //

  late final double _defaultValue = EzConfig.getDefault(widget.prefsKey);
  late double currValue = EzConfig.get(widget.prefsKey);

  final double buttonSpace = EzConfig.get(buttonSpacingKey);
  late final EzSpacer _buttonSpacer = EzSpacer(buttonSpace);

  late final String _label = sstName(context, widget.type);

  // Define build functions //

  /// Return the preview Widget(s) for the passed [SliderSettingType]
  List<Widget> _buildPreview(BuildContext context, TextStyle? style) {
    String currLabel =
        "${EFUILang.of(context)!.gCurrently} ${currValue.toStringAsFixed(widget.decimals)}";

    switch (widget.type) {
      // Margin
      case SliderSettingType.margin:
        final double previewHeight = 160.0;
        final double previewWidth = 90.0;

        double marginScale = previewWidth / widthOf(context);
        double liveMargin = currValue * marginScale;

        return [
          _buttonSpacer,

          // Live preview && label
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Label
              Text(
                currLabel,
                style: style,
                textAlign: TextAlign.center,
              ),
              EzSpacer.row(buttonSpace * 2),

              // Preview
              Container(
                color: Theme.of(context).colorScheme.onBackground,
                height: previewHeight,
                width: previewWidth,
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  margin: EdgeInsets.all(liveMargin),
                ),
              ),
            ],
          ),
          _buttonSpacer,
        ];

      // Padding
      case SliderSettingType.padding:
        return [
          _buttonSpacer,

          // Live label && preview
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: doNothing,
                child: Text(EFUILang.of(context)!.gCurrently),
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      padding: MaterialStateProperty.all(EdgeInsets.all(currValue)),
                    ),
              ),
              EzSpacer.row(buttonSpace),
              ElevatedButton(
                onPressed: doNothing,
                child: Text(currValue.toStringAsFixed(widget.decimals)),
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      padding: MaterialStateProperty.all(EdgeInsets.all(currValue)),
                      shape: MaterialStatePropertyAll(const CircleBorder()),
                    ),
              ),
            ],
          ),

          _buttonSpacer,
        ];

      // Button spacing
      case SliderSettingType.buttonSpacing:
        return [
          // Preview 1
          EzSpacer(currValue),

          // Label
          ElevatedButton(
            onPressed: doNothing,
            child: Text(currLabel),
          ),

          // Preview 2
          EzSpacer(currValue),
        ];
    }
  }

  /// Assemble the final list of widgets to build for [_SliderSettingState]
  /// [widget.title] + [_buildPreview] + [PlatformSlider] + reset [ElevatedButton.icon]
  List<Widget> _buildSheet({
    required BuildContext context,
    required StateSetter modalSheetState,
    required TextStyle? style,
  }) {
    // Gather preview widgets//

    List<Widget> toReturn = [
      Semantics(
        button: false,
        readOnly: true,
        label: EFUILang.of(context)!.gSetToValue(
          _label,
          currValue.toStringAsFixed(widget.decimals),
        ),
        child: ExcludeSemantics(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EzSpacer(EzConfig.get(marginKey)),
              Text(
                _label,
                style: style,
                textAlign: TextAlign.center,
              ),
              ..._buildPreview(context, style),
            ],
          ),
        ),
      ),
    ];

    // Add slider && reset button //

    toReturn.addAll([
      // Slider
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 700, // Chosen via visual inspection
        ),
        child: Slider(
          // Slider values
          value: currValue,
          min: widget.min,
          max: widget.max,
          divisions: widget.steps,

          // Slider functions
          onChanged: (double value) {
            // Just update the on screen value while sliding around
            modalSheetState(() {
              currValue = value;
            });
          },
          onChangeEnd: (double value) {
            // When finished, write the result
            if (value == _defaultValue) {
              EzConfig.remove(widget.prefsKey);
            } else {
              EzConfig.setDouble(widget.prefsKey, value);
            }
          },

          // Slider semantics
          semanticFormatterCallback: (double value) => value.toStringAsFixed(widget.decimals),
        ),
      ),
      _buttonSpacer,

      // Reset button
      ElevatedButton.icon(
        onPressed: () {
          EzConfig.remove(widget.prefsKey);
          modalSheetState(() {
            currValue = _defaultValue;
          });
        },
        icon: Icon(PlatformIcons(context).refresh),
        label: Text(
          "${EFUILang.of(context)!.gReset} ${_defaultValue.toStringAsFixed(widget.decimals)}",
        ),
      ),
      _buttonSpacer,
    ]);

    return toReturn;
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSheetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildSheet(
                context: context,
                modalSheetState: modalSheetState,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            );
          },
        ),
      ),
      icon: widget.type.icon,
      label: Text(_label),
    );
  }
}
