library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzColorSetting extends StatefulWidget {
  final Key? key;

  /// [EzConfig] key whose value will be updated
  final String toControl;

  /// Label [String] to display with on the [ElevatedButton]
  final String message;

  /// Optional [EzConfig] key of whatever will be this colors background
  /// In the event that [toControl] is a [Text]colorKey
  final String? textBackgroundKey;

  /// Creates a tool for updating the value of [toControl] in [EzConfig]
  /// The [EzColorSetting] title is the passed [message] and is paired with a
  /// preview of the starting color ([toControl]) which, on click, opens an [ezColorPicker]
  /// If a [textBackgroundKey] is provided, it will be used to generate a recommended color pair
  const EzColorSetting({
    this.key,
    required this.toControl,
    required this.message,
    this.textBackgroundKey,
  }) : super(key: key);

  @override
  _ColorSettingState createState() => _ColorSettingState();
}

class _ColorSettingState extends State<EzColorSetting> {
  late Color currColor = Color(EzConfig.instance.prefs[widget.toControl]);

  /// Opens an [ezColorPicker] for updating [currColor]
  /// Returns the [Color.value] of what was chosen (null otherwise)
  Future<dynamic> _openColorPicker() {
    return ezColorPicker(
      context: context,
      startColor: currColor,
      onColorChange: (chosenColor) {
        // Update currColor
        setState(() {
          currColor = chosenColor;
        });
      },
      apply: () {
        // Update the user's setting
        EzConfig.instance.preferences.setInt(widget.toControl, currColor.value);
        popScreen(context: context, pass: currColor.value);
      },
      cancel: () => popScreen(context: context),
    );
  }

  /// Opens an [EzDialog] for the user to choose their next action
  /// Returns the [Color.value] of what was chosen (null if none)
  Future<dynamic> _changeColor() {
    final double space = EzConfig.instance.prefs[buttonSpacingKey];

    if (widget.textBackgroundKey != null) {
      // Color is a text color
      // Provide the user with the recommended contrast color based on the
      // Passed background color key

      final String pathKey = widget.textBackgroundKey as String;

      Color backgroundColor = Color(
          EzConfig.instance.preferences.getInt(pathKey) ??
              EzConfig.instance.prefs[pathKey]);

      int recommended = EzContrastColor(backgroundColor).value;

      return showPlatformDialog(
        context: context,
        builder: (context) => EzDialog(
          title: const EzSelectableText('Use recommended?'),
          contents: [
            // Recommended preview
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Color(recommended),
                border: Border.all(color: backgroundColor),
              ),
            ),
            EzSpacer(space),

            // Confirm/deny
            EzYesNo(
              onConfirm: () {
                EzConfig.instance.preferences
                    .setInt(widget.toControl, recommended);
                setState(() {
                  currColor = Color(recommended);
                });
                popScreen(context: context, pass: recommended);
              },
              onDeny: () async {
                dynamic chosen = await _openColorPicker();
                popScreen(context: context, pass: chosen);
              },
              denyIcon: Icon(PlatformIcons(context).edit),
              denyMsg: 'Use custom',
            ),
          ],
          needsClose: true,
        ),
      );
    } else {
      // Non-text color, simply return color picker

      return _openColorPicker();
    }
  }

  /// Opens an [EzDialog] for confirming a reset to [toControl]'s value in [EzConfig.instance.defaults]
  /// A preview of the reset color is shown
  /// Returns the [Color.value] of the "reset color" from [EzConfig.instance.defaults] (null otherwise)
  Future<dynamic> _reset() {
    final Color resetColor =
        Color(EzConfig.instance.defaults[widget.toControl]);
    final double space = EzConfig.instance.prefs[buttonSpacingKey];

    return showPlatformDialog(
      context: context,
      builder: (context) => EzDialog(
        title: const EzSelectableText('Reset to...'),
        contents: [
          // Color preview
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: resetColor,
              border: Border.all(color: EzContrastColor(resetColor)),
            ),
          ),
          EzSpacer(space),

          EzYesNo(
            onConfirm: () {
              // Remove the user's setting and reset the current state
              EzConfig.instance.preferences.remove(widget.toControl);

              setState(() {
                currColor = resetColor;
              });

              popScreen(context: context, pass: resetColor);
            },
            onDeny: () => popScreen(context: context),
            denyMsg: 'Use custom',
            denyIcon: Icon(PlatformIcons(context).edit),
          ),
        ],
        needsClose: false,
      ),
    );
  }

  final double space = EzConfig.instance.prefs[buttonSpacingKey];

  late final TextStyle? style = Theme.of(context).dropdownMenuTheme.textStyle;
  final double diameter = EzConfig.instance.prefs[circleDiameterKey];

  @override
  Widget build(BuildContext context) {
    return EzRow(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Color label
        EzSelectableText(widget.message, style: style),
        EzSpacer.row(space),

        // Color preview/edit button
        ElevatedButton(
          onPressed: _changeColor,
          onLongPress: _reset,
          child: Icon(
            PlatformIcons(context).edit,
            color: EzContrastColor(currColor),
            size: diameter / 3,
          ),
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                backgroundColor: MaterialStatePropertyAll(currColor),
                shape: MaterialStatePropertyAll(const CircleBorder()),
                fixedSize: MaterialStatePropertyAll(Size(diameter, diameter)),
              ),
        ),
      ],
    );
  }
}
