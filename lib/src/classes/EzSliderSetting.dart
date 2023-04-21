library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Enumerator for selecting the type of setting that is being updated
/// This will determine the preview [Widget]s
enum SettingType {
  fontSize,
  margin,
  padding,
  buttonHeight,
  buttonSpacing,
  dialogSpacing,
}

class EzSliderSetting extends StatefulWidget {
  /// The [EzConfig.prefs] key whose value is being updated
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

  /// Creates a tool for updating any [prefsKey] value that would pair well with a [PlatformSlider]
  /// Use the [type] enum for generating the appropriate preview [Widget]s
  EzSliderSetting({
    Key? key,
    required this.prefsKey,
    required this.type,
    required this.title,
    required this.min,
    required this.max,
    required this.steps,
  }) : super(key: key);

  @override
  _SliderSettingState createState() => _SliderSettingState();
}

class _SliderSettingState extends State<EzSliderSetting> {
  late double currValue = EzConfig.prefs[widget.prefsKey];
  late double defaultValue = EzConfig.defaults[widget.prefsKey];
  late double buttonSpacer = EzConfig.prefs[buttonSpacingKey];

  /// Return the preview [Widget]s for the passed [SettingType]
  List<Widget> _buildPreview() {
    switch (widget.type) {
      // Font size
      case SettingType.fontSize:
        return [
          EzButton(
            onPressed: doNothing,
            child: EzText.simple('Currently: $currValue'),
          ),
          Container(height: buttonSpacer),
        ];

      // Margin
      case SettingType.margin:
        double marginScale = 90.0 / widthOf(context);
        double liveMargin = currValue * marginScale;

        return [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EzText.simple('Currently:\n$currValue\n\n(to scale)'),
              Container(
                height: 160.0,
                width: 90.0,
                child: Container(margin: EdgeInsets.all(liveMargin)),
              ),
            ],
          ),
          Container(height: buttonSpacer),
        ];

      // Padding
      case SettingType.padding:
        return [
          EzButton(
            onPressed: doNothing,
            child: Padding(
              padding: EdgeInsets.all(currValue),
              child: EzText.simple('Currently: $currValue'),
            ),
            style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
          ),
          Container(height: buttonSpacer),
        ];

      // Button spacing
      case SettingType.buttonSpacing:
        return [
          EzScrollView(
            children: [
              EzButton(
                onPressed: doNothing,
                child: EzText.simple('Currently: $currValue'),
              ),
              SizedBox(height: currValue),
              EzButton(
                onPressed: doNothing,
                child: EzText.simple('Currently: $currValue'),
              ),
              SizedBox(height: currValue),
            ],
          ),
        ];

      // Button height
      case SettingType.buttonHeight:
        return [
          EzButton(
            onPressed: doNothing,
            child: EzText.simple('Currently: $currValue'),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(widthOf(context), currValue),
            ),
          ),
          Container(height: buttonSpacer),
        ];

      // Dialog spacing
      case SettingType.dialogSpacing:
        return [
          EzButton(
            onPressed: () => openDialog(
              context: context,
              dialog: EzDialog(
                title: EzText.simple('Space preview'),
                contents: [
                  // Button 1
                  EzButton(
                    onPressed: doNothing,
                    child: EzText.simple('Currently: $currValue'),
                  ),
                  Container(height: currValue),

                  // Button 2
                  EzButton(
                    onPressed: doNothing,
                    child: EzText.simple('Currently: $currValue'),
                  ),
                  Container(height: currValue),
                ],
              ),
            ),
            child: EzText.simple('Press me'),
          ),
          Container(height: buttonSpacer),
        ];

      default:
        return [Container(height: buttonSpacer)];
    }
  }

  /// Assemble the final list of widgets to build for [_SliderSettingState]
  /// [widget.title] + [_buildPreview] + [PlatformSlider] + reset [EzButton.icon]
  List<Widget> buildList() {
    List<Widget> toReturn = [EzText.simple(widget.title)];

    toReturn.addAll(_buildPreview());

    toReturn.addAll([
      // Value slider
      PlatformSlider(
        // Function
        value: currValue,

        min: widget.min,
        max: widget.max,

        onChanged: (double value) {
          // Just update the on screen value while sliding around
          setState(() {
            currValue = value;
          });
        },
        onChangeEnd: (double value) {
          // When finished, write the result
          if (value == defaultValue) {
            EzConfig.preferences.remove(widget.prefsKey);
          } else {
            EzConfig.preferences.setDouble(widget.prefsKey, value);
          }
        },

        // Form
        divisions: widget.steps,
      ),
      Container(height: buttonSpacer),

      // Reset button
      EzButton.icon(
        onPressed: () {
          EzConfig.preferences.remove(widget.prefsKey);
          setState(() {
            currValue = EzConfig.defaults[widget.prefsKey];
          });
        },
        icon: Icon(PlatformIcons(context).refresh),
        label: EzText.simple(
            'Reset: ' + EzConfig.defaults[widget.prefsKey].toString()),
      ),
    ]);

    // Build time!
    return toReturn;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buildList(),
    );
  }
}
