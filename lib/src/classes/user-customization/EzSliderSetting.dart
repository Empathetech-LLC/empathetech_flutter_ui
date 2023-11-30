/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
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

  /// [String] that will be displayed at the top of the [BottomSheet]
  final String title;

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
    required this.title,
    required this.min,
    required this.max,
    required this.steps,
    required this.decimals,
  }) : super(key: key);

  @override
  _SliderSettingState createState() => _SliderSettingState();
}

class _SliderSettingState extends State<EzSliderSetting> {
  // Gather theme data //

  late double currValue = EzConfig.instance.prefs[widget.prefsKey];
  late double _defaultValue = EzConfig.instance.defaults[widget.prefsKey];

  late double _margin = EzConfig.instance.prefs[marginKey];
  late double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  late double _textSpacer = EzConfig.instance.prefs[textSpacingKey];

  late final TextStyle? style = Theme.of(context).appBarTheme.titleTextStyle;

  // Define build functions //

  /// Return the preview Widget(s) for the passed [SliderSettingType]
  List<Widget> _buildPreview(BuildContext context, TextStyle? style) {
    switch (widget.type) {
      // Button spacing
      case SliderSettingType.buttonSpacing:
        return [
          // Live preview 1
          EzSpacer(currValue),

          // Live label
          ElevatedButton(
            onPressed: doNothing,
            child: Text(EFUILang.of(context)!.gCurrently +
                currValue.toStringAsFixed(widget.decimals)),
          ),

          // Live preview 2
          EzSpacer(currValue),
        ];

      // Circle size
      case SliderSettingType.circleSize:
        return [
          EzSpacer(_buttonSpacer),

          // Live preview && label
          ElevatedButton(
            onPressed: doNothing,
            child: Text(
              currValue.toStringAsFixed(widget.decimals),
            ),
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  shape: MaterialStatePropertyAll(const CircleBorder()),
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  fixedSize: MaterialStatePropertyAll(
                    Size(currValue, currValue),
                  ),
                ),
          ),
          EzSpacer(_buttonSpacer),
        ];

      // Margin
      case SliderSettingType.margin:
        final double previewHeight = 160.0;
        final double previewWidth = 90.0;

        double marginScale = previewWidth / widthOf(context);
        double liveMargin = currValue * marginScale;

        return [
          EzSpacer(_buttonSpacer),

          // Live preview && label
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Label
              Text(
                EFUILang.of(context)!.gCurrently +
                    currValue.toStringAsFixed(widget.decimals),
                style: style,
                textAlign: TextAlign.center,
              ),
              EzSpacer.row(_textSpacer),

              // Preview
              Container(
                color: Theme.of(context).appBarTheme.titleTextStyle?.color,
                height: previewHeight,
                width: previewWidth,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  margin: EdgeInsets.all(liveMargin),
                ),
              ),
            ],
          ),
          EzSpacer(_buttonSpacer),
        ];

      // Padding
      case SliderSettingType.padding:
        return [
          EzSpacer(_buttonSpacer),

          // Live label && preview
          ElevatedButton(
            onPressed: doNothing,
            child: Text(EFUILang.of(context)!.gCurrently +
                currValue.toStringAsFixed(widget.decimals)),
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  padding: MaterialStateProperty.all(EdgeInsets.all(currValue)),
                ),
          ),

          EzSpacer(_buttonSpacer),
        ];

      // Text spacing
      case SliderSettingType.textSpacing:
        return [
          // Preview 1
          EzSpacer(currValue),

          // Label 1
          Text(
            EFUILang.of(context)!.gCurrently +
                currValue.toStringAsFixed(widget.decimals),
            style: style,
            textAlign: TextAlign.center,
          ),
          // Preview 2
          EzSpacer(currValue),

          // Label 2
          Text(
            EFUILang.of(context)!.gCurrently +
                currValue.toStringAsFixed(widget.decimals),
            style: style,
            textAlign: TextAlign.center,
          ),
          EzSpacer(_buttonSpacer),
        ];
    }
  }

  /// Assemble the final list of widgets to build for [_SliderSettingState]
  /// [widget.title] + [_buildPreview] + [PlatformSlider] + reset [ElevatedButton.icon]
  List<Widget> _buildSheet(
    StateSetter modalSheetSetState,
    BuildContext context,
    TextStyle? style,
  ) {
    // Gather preview widgets//

    List<Widget> toReturn = [
      Semantics(
        button: false,
        readOnly: true,
        label: EFUILang.of(context)!.gSetToValue(
          sstName(context, widget.type),
          currValue.toStringAsFixed(widget.decimals),
        ),
        child: ExcludeSemantics(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EzSpacer(_margin),
              Text(
                widget.title,
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
            modalSheetSetState(() {
              currValue = value;
            });
          },
          onChangeEnd: (double value) {
            // When finished, write the result
            if (value == _defaultValue) {
              EzConfig.instance.preferences.remove(widget.prefsKey);
            } else {
              EzConfig.instance.preferences.setDouble(widget.prefsKey, value);
            }
          },

          // Slider semantics
          semanticFormatterCallback: (double value) =>
              value.toStringAsFixed(widget.decimals),
        ),
      ),
      EzSpacer(_buttonSpacer),

      // Reset button
      Semantics(
        button: true,
        hint: EFUILang.of(context)!.gResetToValue(
          sstName(context, widget.type),
          _defaultValue.toStringAsFixed(widget.decimals),
        ),
        child: ExcludeSemantics(
          child: ElevatedButton.icon(
            onPressed: () {
              EzConfig.instance.preferences.remove(widget.prefsKey);
              modalSheetSetState(() {
                currValue = _defaultValue;
              });
            },
            icon: Icon(PlatformIcons(context).refresh),
            label: Text(EFUILang.of(context)!.gReset +
                _defaultValue.toStringAsFixed(widget.decimals)),
          ),
        ),
      ),
      EzSpacer(_buttonSpacer),
    ]);

    return toReturn;
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      hint: sstName(context, widget.type),
      child: ExcludeSemantics(
        child: ElevatedButton.icon(
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (BuildContext context, StateSetter modalSheetSetState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildSheet(modalSheetSetState, context, style),
                );
              },
            ),
          ),
          icon: widget.type.icon,
          label: Text(widget.title),
        ),
      ),
    );
  }
}
