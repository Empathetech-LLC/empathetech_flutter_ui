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
  // Initialize state

  late double currValue = AppConfig.prefs[widget.prefsKey];
  late double defaultValue = AppConfig.defaults[widget.prefsKey];
  late double buttonSpacer = AppConfig.prefs[buttonSpacingKey];

  /// Return the preview [Widget]s for the passed [SettingType]
  List<Widget> preview() {
    switch (widget.type) {
      // Font size
      case SettingType.fontSize:
        return [
          Container(height: buttonSpacer),
          ezButton(
            action: () {},
            body: Text(
              'Preview: $currValue',
              style: getTextStyle(buttonStyleKey).copyWith(fontSize: currValue),
            ),
          ),
          Container(height: buttonSpacer),
        ];

      // Margin
      case SettingType.margin:
        double marginScale = 90.0 / screenWidth(context);
        double liveMargin = currValue * marginScale;

        return [
          Container(height: buttonSpacer),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              paddedText(
                'Preview (to scale):\n$currValue',
                style: getTextStyle(dialogContentStyleKey),
                alignment: TextAlign.center,
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
          Container(height: buttonSpacer),
          ezButton(
            action: () {},
            body: Padding(
              padding: EdgeInsets.all(currValue),
              child: Text(
                'Preview: $currValue',
                style: getTextStyle(buttonStyleKey),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(height: buttonSpacer),
        ];

      // Button height
      case SettingType.buttonHeight:
        return [
          Container(height: buttonSpacer),
          ezButton(
            action: () {},
            body: Text('Preview $currValue'),
            customStyle: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth(context), currValue),
            ),
          ),
          Container(height: buttonSpacer),
        ];

      // Button spacing
      case SettingType.buttonSpacing:
        return [
          ezScrollView(
            children: [
              SizedBox(height: currValue),
              ezButton(action: () {}, body: Text('Preview $currValue')),
              SizedBox(height: currValue),
              ezButton(action: () {}, body: Text('Preview $currValue')),
              SizedBox(height: currValue),
            ],
            centered: true,
          ),
        ];

      // Dialog spacing
      case SettingType.dialogSpacing:
        return [
          Container(height: buttonSpacer),
          ezButton(
            action: () => ezDialog(
              context: context,
              title: 'Space preview',
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Button 1
                  ezButton(action: () {}, body: Text('Preview $currValue')),
                  Container(height: currValue),

                  // Button 2
                  ezButton(action: () {}, body: Text('Preview $currValue')),
                  Container(height: currValue),
                ],
              ),
            ),
            body: Text('Press me'),
          ),
          Container(height: buttonSpacer),
        ];

      default:
        return [Container(height: buttonSpacer)];
    }
  }

  /// Assemble the final list of widgets to build for [_SliderSettingState]
  /// [widget.title] + [preview] + [PlatformSlider] + reset [ezTextIconButton]
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
      ),
      Container(height: buttonSpacer),

      // Reset button
      ezIconButton(
        action: () {
          AppConfig.preferences.remove(widget.prefsKey);
          setState(() {
            currValue = AppConfig.defaults[widget.prefsKey];
          });
        },
        icon: Icon(PlatformIcons(context).refresh),
        body: Text('Reset: ' + AppConfig.defaults[widget.prefsKey].toString()),
      ),
      Container(height: buttonSpacer),
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
