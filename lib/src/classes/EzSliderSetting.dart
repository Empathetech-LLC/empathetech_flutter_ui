/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  late double _padding = EzConfig.instance.prefs[paddingKey];
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
          // Title padding
          EzSpacer(_padding),

          // Live preview && label
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: doNothing,
                child: Text(AppLocalizations.of(context)!.currently +
                    currValue.toStringAsFixed(widget.decimals)),
              ),
              EzSpacer(currValue),
              ElevatedButton(
                onPressed: doNothing,
                child: Text(AppLocalizations.of(context)!.currently +
                    currValue.toStringAsFixed(widget.decimals)),
              ),
              EzSpacer(_buttonSpacer),
            ],
          ),
        ];

      // Circle size
      case SliderSettingType.circleSize:
        return [
          // Title padding
          EzSpacer(_padding),
          ElevatedButton(
            onPressed: doNothing,
            child: Text(
              currValue.toStringAsFixed(widget.decimals),
            ),
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  shape: MaterialStatePropertyAll(const CircleBorder()),
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  fixedSize: MaterialStatePropertyAll(Size(currValue, currValue)),
                ),
          ),
          EzSpacer(_buttonSpacer),
        ];

      // Margin
      case SliderSettingType.margin:
        double marginScale = 90.0 / widthOf(context);
        double liveMargin = currValue * marginScale;

        return [
          // Title padding
          EzSpacer(_padding),

          // Live preview && label
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Label
              EzSelectableText(
                AppLocalizations.of(context)!.currently +
                    currValue.toStringAsFixed(widget.decimals),
                style: style,
              ),
              EzSpacer.row(_textSpacer),

              // Preview
              Container(
                color: Theme.of(context).appBarTheme.titleTextStyle?.color,
                height: 160.0,
                width: 90.0,
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
          // Title padding && live preview part 1
          EzSpacer(currValue),

          // Live label && preview part 2
          ElevatedButton(
            onPressed: doNothing,
            child: Text(AppLocalizations.of(context)!.currently +
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
          // Title padding
          EzSpacer(_padding),

          // Live preview && label
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Thing 1
              EzSelectableText(
                  AppLocalizations.of(context)!.currently +
                      currValue.toStringAsFixed(widget.decimals),
                  style: style),
              SizedBox(height: currValue),

              // Thing 2
              EzSelectableText(
                  AppLocalizations.of(context)!.currently +
                      currValue.toStringAsFixed(widget.decimals),
                  style: style),
              SizedBox(height: _buttonSpacer),
            ],
          ),
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
        label: AppLocalizations.of(context)!.nameSetToValue(
          getSettingName(context, widget.type),
          currValue.toStringAsFixed(widget.decimals),
        ),
        child: ExcludeSemantics(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EzSpacer(_margin),
              EzSelectableText(widget.title, style: style),
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

          // Slider sementics
          semanticFormatterCallback: (double value) => value.toStringAsFixed(widget.decimals),
        ),
      ),
      EzSpacer(_buttonSpacer),

      // Reset button
      Semantics(
        button: true,
        hint: AppLocalizations.of(context)!.resetNameToValue(
          getSettingName(context, widget.type),
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
            label: Text(AppLocalizations.of(context)!.reset +
                _defaultValue.toStringAsFixed(widget.decimals)),
          ),
        ),
      ),
      EzSpacer(_margin),
    ]);

    return toReturn;
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      hint: getSettingName(context, widget.type),
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
