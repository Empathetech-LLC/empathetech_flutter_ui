library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ValueSetting extends StatefulWidget {
  const ValueSetting({
    Key? key,
    required this.prefsKey,
    required this.title,
    required this.min,
    required this.max,
    required this.steps,
    this.preview,
  }) : super(key: key);

  final String prefsKey;
  final String title;
  final double min;
  final double max;
  final int steps;
  final List<Widget>? preview;

  @override
  _ValueSettingState createState() => _ValueSettingState();
}

class _ValueSettingState extends State<ValueSetting> {
  //// Initialize state

  late double currValue = AppConfig.prefs[widget.prefsKey];
  late double defaultValue = AppConfig.defaults[widget.prefsKey];
  late double buttonSpacer = AppConfig.prefs[buttonSpacingKey];

  //// Draw state

  // Return the widget build for the current value type
  List<Widget> preview() {
    if (widget.preview != null) return widget.preview!;

    switch (widget.prefsKey) {
      // Font size
      case fontSizeKey:
        return [
          Container(height: buttonSpacer),
          ezButton(
            () {},
            () {},
            Text(
              'Preview: $currValue',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: currValue),
            ),
          ),
          Container(height: buttonSpacer),
        ];

      // Button && signal spacing
      case buttonSpacingKey:
        return [
          ezCenterScroll(
            [
              SizedBox(height: currValue),
              ezButton(() {}, () {}, Text('Preview $currValue')),
              SizedBox(height: currValue),
              ezButton(() {}, () {}, Text('Preview $currValue')),
              SizedBox(height: currValue),
            ],
          ),
        ];

      // Dialog spacing
      case dialogSpacingKey:
        return [
          Container(height: buttonSpacer),
          ezButton(
            () => ezDialog(
              context,
              'Space preview',
              [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Button 1
                    ezButton(() {}, () {}, Text('Preview: $currValue')),
                    Container(height: currValue),

                    // Button 2
                    ezButton(() {}, () {}, Text('Preview: $currValue')),
                    Container(height: currValue),
                  ],
                ),
              ],
            ),
            () {},
            Text('Press me'),
          ),
          Container(height: buttonSpacer),
        ];

      // Default
      default:
        return [Container(height: buttonSpacer)];
    }
  }

  // Build the list of widgets to draw based on the value type
  List<Widget> buildList() {
    List<Widget> toReturn = [Text(widget.title, style: getTextStyle(subTitleStyleKey))];

    toReturn.addAll(preview());

    toReturn.addAll([
      // Value slider
      PlatformSlider(
        value: currValue,
        min: widget.min,
        max: widget.max,
        divisions: widget.steps,
        onChanged: (double value) {
          // Just update the on screen value while sliding around
          setState(() {
            currValue = value;
          });
        },
        onChangeEnd: (double value) {
          // When finished, write the result
          if (value == defaultValue) {
            AppConfig.preferences.remove(widget.prefsKey);
          } else {
            AppConfig.preferences.setDouble(widget.prefsKey, value);
          }
        },
        material: (context, platform) => MaterialSliderData(label: currValue.toString()),
      ),
      Container(height: buttonSpacer),

      // Reset button
      ezIconButton(
        () {
          AppConfig.preferences.remove(widget.prefsKey);
          setState(() {
            currValue = AppConfig.defaults[widget.prefsKey];
          });
        },
        () {},
        Icon(PlatformIcons(context).refresh),
        Icon(PlatformIcons(context).refresh),
        Text('Reset: ' + AppConfig.defaults[widget.prefsKey].toString()),
      ),
      Container(height: buttonSpacer),
    ]);

    // Build time!
    return toReturn;
  }

  @override
  Widget build(BuildContext context) {
    // Font setting UI
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buildList(),
    );
  }
}
