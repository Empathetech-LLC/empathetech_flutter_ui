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

/// Creates a tool for updating any [prefsKey] value that would pair well with a [PlatformSlider]
/// Use the [preview] widgets for illustrating live changes to the user
class SliderSetting extends StatefulWidget {
  const SliderSetting({
    Key? key,
    required this.prefsKey,
    required this.type,
    required this.title,
    required this.min,
    required this.max,
    required this.steps,
  }) : super(key: key);

  final String prefsKey;
  final SettingType type;
  final String title;
  final double min;
  final double max;
  final int steps;

  @override
  _SliderSettingState createState() => _SliderSettingState();
}

class _SliderSettingState extends State<SliderSetting> {
  late TextStyle buttonTextStyle = getTextStyle(buttonStyleKey);

  late double currValue = AppConfig.prefs[widget.prefsKey];
  late double defaultValue = AppConfig.defaults[widget.prefsKey];
  late double buttonSpacer = AppConfig.prefs[buttonSpacingKey];

  late Color buttonColor = Color(AppConfig.prefs[buttonColorKey]);

  /// Return the preview [Widget]s for the passed [SettingType]
  List<Widget> preview() {
    switch (widget.type) {
      // Font size
      case SettingType.fontSize:
        return [
          EZButton(
            action: doNothing,
            body: Text(
              'Currently: $currValue',
              style: buttonTextStyle.copyWith(fontSize: currValue),
            ),
          ),
          Container(height: buttonSpacer),
        ];

      // Margin
      case SettingType.margin:
        double marginScale = 90.0 / screenWidth(context);
        double liveMargin = currValue * marginScale;

        return [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ezText(
                'Currently:\n$currValue\n\n(to scale)',
                style: getTextStyle(dialogContentStyleKey),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 160.0,
                width: 90.0,
                color: Color(AppConfig.prefs[themeTextColorKey]),
                child: Container(
                  color: Color(AppConfig.prefs[themeColorKey]),
                  margin: EdgeInsets.all(liveMargin),
                ),
              ),
            ],
          ),
          Container(height: buttonSpacer),
        ];

      // Padding
      case SettingType.padding:
        return [
          EZButton(
            action: doNothing,
            body: Padding(
              padding: EdgeInsets.all(currValue),
              child: Text(
                'Currently: $currValue',
                style: buttonTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            customStyle: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
          ),
          Container(height: buttonSpacer),
        ];

      // Button spacing
      case SettingType.buttonSpacing:
        return [
          ezScrollView(
            children: [
              EZButton(
                action: doNothing,
                body: Text('Currently: $currValue', style: buttonTextStyle),
              ),
              SizedBox(height: currValue),
              EZButton(
                action: doNothing,
                body: Text('Currently: $currValue', style: buttonTextStyle),
              ),
              SizedBox(height: currValue),
            ],
            centered: true,
          ),
        ];

      // Button height
      case SettingType.buttonHeight:
        return [
          EZButton(
            action: doNothing,
            body: Text('Currently: $currValue', style: buttonTextStyle),
            customStyle: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth(context), currValue),
            ),
          ),
          Container(height: buttonSpacer),
        ];

      // Dialog spacing
      case SettingType.dialogSpacing:
        return [
          EZButton(
            action: () => ezDialog(
              context,
              title: 'Space preview',
              content: [
                // Button 1
                EZButton(
                  action: doNothing,
                  body: Text('Currently: $currValue', style: buttonTextStyle),
                ),
                Container(height: currValue),

                // Button 2
                EZButton(
                  action: doNothing,
                  body: Text('Currently: $currValue', style: buttonTextStyle),
                ),
                Container(height: currValue),
              ],
            ),
            body: Text('Press me', style: buttonTextStyle),
          ),
          Container(height: buttonSpacer),
        ];

      default:
        return [Container(height: buttonSpacer)];
    }
  }

  /// Assemble the final list of widgets to build for [_SliderSettingState]
  /// [widget.title] + [preview] + [PlatformSlider] + reset [EZButton.icon]
  List<Widget> buildList() {
    List<Widget> toReturn = [ezText(widget.title, style: getTextStyle(subTitleStyleKey))];

    toReturn.addAll(preview());

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
            AppConfig.preferences.remove(widget.prefsKey);
          } else {
            AppConfig.preferences.setDouble(widget.prefsKey, value);
          }
        },

        // Form
        divisions: widget.steps,
        thumbColor: buttonColor,
        activeColor: buttonColor,
      ),
      Container(height: buttonSpacer),

      // Reset button
      EZButton.icon(
        action: () {
          AppConfig.preferences.remove(widget.prefsKey);
          setState(() {
            currValue = AppConfig.defaults[widget.prefsKey];
          });
        },
        icon: ezIcon(PlatformIcons(context).refresh),
        message: 'Reset: ' + AppConfig.defaults[widget.prefsKey].toString(),
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
