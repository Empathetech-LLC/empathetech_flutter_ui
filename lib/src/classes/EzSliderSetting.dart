/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Enumerator for selecting the type of setting that is being updated
/// This will determine the preview [Widget]s
enum SettingType {
  margin,
  padding,
  circleSize,
  buttonSpacing,
  textSpacing,
}

/// Enumerator extension for getting the proper [String] name for [EzSliderSetting.type]
extension SettingName on SettingType {
  String get name {
    switch (this) {
      case SettingType.margin:
        return "margin";
      case SettingType.padding:
        return "padding";
      case SettingType.circleSize:
        return "circle button size";
      case SettingType.buttonSpacing:
        return "button spacing";
      case SettingType.textSpacing:
        return "text spacing.";
    }
  }
}

/// Enumerator extension for getting the proper [Semantics] label for [EzSliderSetting.type]
extension SettingLabel on SettingType {
  String get label {
    switch (this) {
      case SettingType.margin:
        return "margin. Margin is the distance between the edge of a view and its contents. The app window or a dialog pop up, for example.";
      case SettingType.padding:
        return "padding. Padding is the distance between paired items. A title and its description or a button and its label, for example.";
      case SettingType.circleSize:
        return "circle button size.";
      case SettingType.buttonSpacing:
        return "button spacing.";
      case SettingType.textSpacing:
        return "text spacing.";
    }
  }
}

class EzSliderSetting extends StatefulWidget {
  /// The [EzConfig] key whose value is being updated
  final String prefsKey;

  /// Custom enum for determining the preview widget's required
  final SettingType type;

  /// [String] that will be displayed above the [Slider]
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
  // Gather values //

  late double currValue = EzConfig.instance.prefs[widget.prefsKey];
  late double defaultValue = EzConfig.instance.defaults[widget.prefsKey];

  late double margin = EzConfig.instance.prefs[marginKey];
  late double padding = EzConfig.instance.prefs[paddingKey];
  late double buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  late double textSpacer = EzConfig.instance.prefs[textSpacingKey];

  /// Return the preview [Widget]s for the passed [SettingType]
  List<Widget> _buildPreview(BuildContext context, TextStyle? style) {
    switch (widget.type) {
      // Button spacing
      case SettingType.buttonSpacing:
        return [
          // Title padding
          EzSpacer(padding),

          // Live preview && label
          Semantics(
            button: false,
            readOnly: true,
            label:
                '${widget.type.name} is currently set to ${currValue.toStringAsFixed(widget.decimals)}',
            child: ExcludeSemantics(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: doNothing,
                    child: Text('Currently: ${currValue.toStringAsFixed(widget.decimals)}'),
                  ),
                  EzSpacer(currValue),
                  ElevatedButton(
                    onPressed: doNothing,
                    child: Text('Currently: ${currValue.toStringAsFixed(widget.decimals)}'),
                  ),
                  EzSpacer(buttonSpacer),
                ],
              ),
            ),
          ),
        ];

      // Circle size
      case SettingType.circleSize:
        return [
          // Title padding
          EzSpacer(padding),

          // Live preview && label
          Semantics(
            button: false,
            readOnly: true,
            label:
                '${widget.type.name} is currently set to ${currValue.toStringAsFixed(widget.decimals)}',
            child: ExcludeSemantics(
              child: ElevatedButton(
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
            ),
          ),
          EzSpacer(buttonSpacer),
        ];

      // Margin
      case SettingType.margin:
        double marginScale = 90.0 / widthOf(context);
        double liveMargin = currValue * marginScale;

        return [
          // Title padding
          EzSpacer(padding),

          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Live label
              EzSelectableText(
                'Currently: ${currValue.toStringAsFixed(widget.decimals)}',
                style: style,
                semanticsLabel:
                    '${widget.type.name} is currently set to ${currValue.toStringAsFixed(widget.decimals)}',
              ),
              EzSpacer.row(textSpacer),

              // Live preview
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
          EzSpacer(buttonSpacer),
        ];

      // Padding
      case SettingType.padding:
        return [
          // Live preview
          EzSpacer(currValue),

          // Live label
          Semantics(
            button: false,
            readOnly: true,
            label:
                '${widget.type.name} is currently set to ${currValue.toStringAsFixed(widget.decimals)}',
            child: ExcludeSemantics(
              child: ElevatedButton(
                onPressed: doNothing,
                child: Text('Currently: ${currValue.toStringAsFixed(widget.decimals)}'),
              ),
            ),
          ),
          EzSpacer(buttonSpacer),
        ];

      // Text spacing
      case SettingType.textSpacing:
        return [
          // Title padding
          EzSpacer(padding),

          // Live preview && label
          Semantics(
            button: false,
            readOnly: true,
            label:
                '${widget.type.name} is currently set to ${currValue.toStringAsFixed(widget.decimals)}',
            child: ExcludeSemantics(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Thing 1
                  EzSelectableText('Currently: ${currValue.toStringAsFixed(widget.decimals)}',
                      style: style),
                  SizedBox(height: currValue),

                  // Thing 2
                  EzSelectableText('Currently: ${currValue.toStringAsFixed(widget.decimals)}',
                      style: style),
                  SizedBox(height: buttonSpacer),
                ],
              ),
            ),
          ),
        ];
    }
  }

  /// Assemble the final list of widgets to build for [_SliderSettingState]
  /// [widget.title] + [_buildPreview] + [PlatformSlider] + reset [ElevatedButton.icon]
  List<Widget> _buildView(
    StateSetter modalSheetSetState,
    BuildContext context,
    TextStyle? style,
  ) {
    List<Widget> toReturn = [
      EzSpacer(margin),
      EzSelectableText(widget.title, style: style),
    ];

    toReturn.addAll(_buildPreview(context, style));

    toReturn.addAll([
      // Value slider
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 700, // Chosen via visual inspection
        ),
        child: Slider(
          // Values
          value: currValue,
          min: widget.min,
          max: widget.max,
          divisions: widget.steps,

          // Functions
          onChanged: (double value) {
            // Just update the on screen value while sliding around
            modalSheetSetState(() {
              currValue = value;
            });
          },
          onChangeEnd: (double value) {
            // When finished, write the result
            if (value == defaultValue) {
              EzConfig.instance.preferences.remove(widget.prefsKey);
            } else {
              EzConfig.instance.preferences.setDouble(widget.prefsKey, value);
            }
          },

          // Sementics
          semanticFormatterCallback: (double value) => value.toStringAsFixed(widget.decimals),
        ),
      ),
      EzSpacer(buttonSpacer),

      // Reset button
      Semantics(
        button: true,
        hint: 'Reset ${widget.type.name} to ${defaultValue.toStringAsFixed(widget.decimals)}',
        child: ExcludeSemantics(
          child: ElevatedButton.icon(
            onPressed: () {
              EzConfig.instance.preferences.remove(widget.prefsKey);
              modalSheetSetState(() {
                currValue = defaultValue;
              });
            },
            icon: Icon(PlatformIcons(context).refresh),
            label: Text('Reset: ${defaultValue.toStringAsFixed(widget.decimals)}'),
          ),
        ),
      ),
      EzSpacer(margin),
    ]);

    // Build time!
    return toReturn;
  }

  Icon _buildIcon() {
    switch (widget.type) {
      case SettingType.margin:
        return const Icon(Icons.margin);
      case SettingType.padding:
        return const Icon(Icons.padding);
      case SettingType.circleSize:
        return const Icon(Icons.circle);
      case SettingType.buttonSpacing:
        return const Icon(Icons.space_bar);
      case SettingType.textSpacing:
        return const Icon(Icons.space_bar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? style = Theme.of(context).appBarTheme.titleTextStyle;

    return Semantics(
      button: true,
      hint: "Customize the app's " + widget.type.label,
      child: ExcludeSemantics(
        child: ElevatedButton.icon(
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (BuildContext context, StateSetter modalSheetSetState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _buildView(modalSheetSetState, context, style),
                );
              },
            ),
          ),
          icon: _buildIcon(),
          label: Text(widget.title),
        ),
      ),
    );
  }
}
