library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Creates a tool for updating the value of [toControl]
/// The [ColorSetting] title is the passed [message] and is paired with a
/// preview of the starting color ([toControl]) which, on click, opens a [colorPicker]
class ColorSetting extends StatefulWidget {
  const ColorSetting({
    Key? key,
    required this.toControl,
    required this.message,
    this.textBackground,
  }) : super(key: key);

  final String toControl;
  final String message;
  final int? textBackground;

  @override
  _ColorSettingState createState() => _ColorSettingState();
}

class _ColorSettingState extends State<ColorSetting> {
  // Gather theme data

  late Color currColor = Color(AppConfig.prefs[widget.toControl]);
  late Color themeColor = Color(AppConfig.prefs[themeColorKey]);
  late Color themeTextColor = Color(AppConfig.prefs[themeTextColorKey]);
  late Color buttonColor = Color(AppConfig.prefs[buttonColorKey]);

  /// Opens an [ezColorPicker] for updating [currColor]
  void openColorPicker() {
    ezColorPicker(
      context,
      startColor: currColor,
      onColorChange: (chosenColor) {
        setState(() {
          currColor = chosenColor;
        });
      },
      apply: () {
        // Update the users setting
        AppConfig.preferences.setInt(widget.toControl, currColor.value);
        Navigator.of(context).pop();
      },
      cancel: () => Navigator.of(context).pop(),
    );
  }

  /// Opens an [ezColorPicker] for updating [currColor]
  /// If a [textBackground] is provided, it will be used to generate a recommended color pair
  void changeColor() {
    double buttonSpacer = AppConfig.prefs[buttonSpacingKey];
    double dialogSpcaer = AppConfig.prefs[dialogSpacingKey];

    if (widget.textBackground != null) {
      int background = widget.textBackground as int;
      int recommended = getContrastColor(Color(background)).value;

      ezDialog(
        context,
        title: 'Use recommended?',
        content: [
          // Recommended preview
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: Color(recommended),
              border: Border.all(color: Color(background)),
            ),
          ),
          Container(height: buttonSpacer),

          ezYesNo(
            context,
            onConfirm: () {
              popScreen(context);
              AppConfig.preferences.setInt(widget.toControl, recommended);
              setState(() {
                currColor = Color(recommended);
              });
            },
            onDeny: () {
              popScreen(context);
              openColorPicker();
            },
            customDeny: Icon(PlatformIcons(context).edit),
            denyMsg: 'Pick custom',
            axis: Axis.vertical,
            spacer: dialogSpcaer,
          ),
        ],
      );
    } else {
      openColorPicker();
    }
  }

  /// Opens an [ezDialog] for confirming a reset to [widget.toControl]'s value in [AppConfig.defaults]
  /// A preview of the reset color is shown
  void reset() {
    // Gather theme data

    Color resetColor = Color(AppConfig.defaults[widget.toControl]);
    double dialogSpacer = AppConfig.prefs[dialogSpacingKey];

    ezDialog(
      context,
      title: 'Reset to...',
      content: [
        // Color preview
        Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            color: resetColor,
            border: Border.all(color: getContrastColor(resetColor)),
          ),
        ),
        Container(height: dialogSpacer),

        ezYesNo(
          context,
          onConfirm: () {
            // Remove the user's setting and reset the current state
            AppConfig.preferences.remove(widget.toControl);

            setState(() {
              currColor = resetColor;
            });

            Navigator.of(context).pop();
          },
          onDeny: () => Navigator.of(context).pop(),
          axis: Axis.horizontal,
          spacer: dialogSpacer,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Color label
        ezText(
          widget.message,
          style: getTextStyle(dialogTitleStyleKey),
          textAlign: TextAlign.center,
        ),

        // Color preview/edit button
        EZButton(
          action: changeColor,
          longAction: reset,
          body: ezIcon(PlatformIcons(context).edit, color: getContrastColor(currColor)),
          customStyle: ElevatedButton.styleFrom(
            backgroundColor: currColor,
            padding: EdgeInsets.all(AppConfig.prefs[paddingKey] * 2),
          ),
        ),
      ],
    );
  }
}
