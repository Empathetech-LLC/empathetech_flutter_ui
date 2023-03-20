library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
          ezTextButton(
            () {},
            () {},
            'Preview: $currValue',
            getTextStyle(buttonStyleKey).copyWith(fontSize: currValue),
          ),
          Container(height: buttonSpacer),
        ];

      // Margin
      case SettingType.margin:
        return [
          Container(height: buttonSpacer),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              paddedText('Preview: $currValue', getTextStyle(dialogContentStyleKey)),
              Container(
                height: 160,
                width: 90,
                color: Color(AppConfig.prefs[themeTextColorKey]),
                margin: EdgeInsets.all(currValue),
                child: Container(color: Color(AppConfig.prefs[themeColorKey])),
              ),
            ],
          ),
          Container(height: buttonSpacer),
        ];

      case SettingType.padding:
        return [
          Container(height: buttonSpacer),
          ezTextButton(
            () {},
            () {},
            'Preview: $currValue',
            null,
            androidButton().copyWith(
              padding: MaterialStatePropertyAll(EdgeInsets.all(currValue)),
            ),
          ),
          Container(height: buttonSpacer),
        ];

      // Button height
      case SettingType.buttonHeight:
        return [
          Container(height: buttonSpacer),
          ezTextButton(
            () {},
            () {},
            'Preview: $currValue',
            null,
            ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth(context), currValue),
            ),
          ),
          Container(height: buttonSpacer),
        ];

      // Button spacing
      case SettingType.buttonSpacing:
        return [
          ezCenterScroll(
            [
              SizedBox(height: currValue),
              ezTextButton(() {}, () {}, 'Preview $currValue'),
              SizedBox(height: currValue),
              ezTextButton(() {}, () {}, 'Preview $currValue'),
              SizedBox(height: currValue),
            ],
          ),
        ];

      // Dialog spacing
      case SettingType.dialogSpacing:
        return [
          Container(height: buttonSpacer),
          ezTextButton(
            () => ezDialog(
              context,
              'Space preview',
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Button 1
                  ezTextButton(() {}, () {}, 'Preview: $currValue'),
                  Container(height: currValue),

                  // Button 2
                  ezTextButton(() {}, () {}, 'Preview: $currValue'),
                  Container(height: currValue),
                ],
              ),
            ),
            () {},
            'Press me',
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
      ezTextIconButton(
        () {
          AppConfig.preferences.remove(widget.prefsKey);
          setState(() {
            currValue = AppConfig.defaults[widget.prefsKey];
          });
        },
        () {},
        'Reset: ' + AppConfig.defaults[widget.prefsKey].toString(),
        PlatformIcons(context).refresh,
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
