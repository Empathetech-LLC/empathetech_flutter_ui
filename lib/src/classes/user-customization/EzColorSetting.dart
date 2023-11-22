/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzColorSetting extends StatefulWidget {
  final Key? key;

  /// [EzConfig.instance] key whose value will be updated
  /// Provide [update] or [updating]
  final String? update;

  /// [EzConfig.instance] keys whose values will be updated
  /// Only provide keys whose values should always be identical
  /// [EzColorSetting] is lazy and will only use the first value for generating previews
  /// Provide [updating] or [update]
  final List<String>? updating;

  /// User-friendly [label] of the color whose value will be updated
  final String label;

  /// Optional [EzConfig.instance] key that controls the background color when [updating] text colors
  final String? textBackgroundKey;

  /// Optional [EzConfig.instance] key that controls the text color, assuming [update] or [updating] are surface keys
  /// If provided, when the base color is updated, [autoUpdateTextKey] will be set via [getTextColor]
  /// And/or will reset alongside the base color
  /// Note: if you have another [EzColorSetting] tracking the same key, the auto update will NOT visually update the other button
  final String? autoUpdateTextKey;

  /// Creates a tool for [updating] color values in [EzConfig]
  /// If [update] or [updating] are text Colors, provide [textBackgroundKey]
  /// [textBackgroundKey]s [EzConfig.instance] value will be used to generate a recommendation via [getTextColor]
  /// If [update] or [updating] are surface Colors, optionally provide [autoUpdateTextKey]
  /// If provided, when the base color is updated, [autoUpdateTextKey] will be set via [getTextColor]
  const EzColorSetting({
    this.key,
    this.update,
    this.updating,
    required this.label,
    this.textBackgroundKey,
    this.autoUpdateTextKey,
  })  : assert(
          (update == null) != (updating == null || updating.length == 0) &&
              (!(textBackgroundKey != null && autoUpdateTextKey != null)),
          'Either update or updating should be provided, but not both\nEither decoration or decorationImageKey can be provided, but not both.',
        ),
        super(key: key);

  @override
  _ColorSettingState createState() => _ColorSettingState();
}

class _ColorSettingState extends State<EzColorSetting> {
  // Gather theme data //

  late Color currColor = (widget.update == null)
      ? Color(EzConfig.instance.prefs[widget.updating![0]])
      : Color(EzConfig.instance.prefs[widget.update]);

  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  final double _diameter = EzConfig.instance.prefs[circleDiameterKey];

  late final TextStyle? _labelStyle =
      Theme.of(context).dropdownMenuTheme.textStyle;

  // Define button functions //

  /// Opens an [ezColorPicker] for updating [currColor]
  /// Returns the [Color.value] of what was chosen (null otherwise)
  Future<dynamic> _openColorPicker(BuildContext context) {
    return ezColorPicker(
      context: context,
      startColor: currColor,
      onColorChange: (chosenColor) {
        // Update currColor
        setState(() {
          currColor = chosenColor;
        });
      },
      onConfirm: () {
        // Update the user's setting
        if (widget.update == null) {
          for (String key in widget.updating!) {
            EzConfig.instance.preferences.setInt(key, currColor.value);
          }
        } else {
          EzConfig.instance.preferences.setInt(widget.update!, currColor.value);
        }

        if (widget.autoUpdateTextKey != null) {
          EzConfig.instance.preferences
              .setInt(widget.autoUpdateTextKey!, getTextColor(currColor).value);
        }

        popScreen(context: context, pass: currColor.value);
      },
      onDeny: () => popScreen(context: context),
    );
  }

  /// Opens an [EzAlertDialog] for users to chose how they want to update the color
  /// Returns the [Color.value] of what was chosen (null if none)
  Future<dynamic> _changeColor(BuildContext context) {
    if (widget.textBackgroundKey == null) {
      // Base color //

      // Just open a color picker
      return _openColorPicker(context);
    } else {
      // "on" (aka text) color //

      // Find the recommended contrast color for the background
      Color backgroundColor = Color(
          EzConfig.instance.preferences.getInt(widget.textBackgroundKey!) ??
              EzConfig.instance.prefs[widget.textBackgroundKey!]);

      int recommended = getTextColor(backgroundColor).value;

      // Define action button parameters
      final String denyMsg = EFUILang.of(context)!.csUseCustom;

      final void Function() onConfirm = () {
        // Update the user's setting
        if (widget.update == null) {
          for (String key in widget.updating!) {
            EzConfig.instance.preferences.setInt(key, recommended);
          }
        } else {
          EzConfig.instance.preferences.setInt(widget.update!, recommended);
        }

        setState(() {
          currColor = Color(recommended);
        });

        popScreen(context: context, pass: recommended);
      };

      void Function() onDeny = () async {
        dynamic chosen = await _openColorPicker(context);
        popScreen(context: context, pass: chosen);
      };

      return showPlatformDialog(
        context: context,
        builder: (context) => EzAlertDialog(
          title: Text(
            EFUILang.of(context)!.csRecommended,
            textAlign: TextAlign.center,
          ),
          // Recommended color preview
          contents: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Color(recommended),
                border: Border.all(color: backgroundColor),
              ),
            ),
          ],
          materialActions: ezMaterialActions(
            context: context,
            onConfirm: onConfirm,
            onDeny: onDeny,
            denyMsg: denyMsg,
          ),
          cupertinoActions: ezCupertinoActions(
            context: context,
            onConfirm: onConfirm,
            onDeny: onDeny,
            denyMsg: denyMsg,
            confirmIsDestructive: true,
          ),
        ),
      );
    }
  }

  /// Opens an [EzAlertDialog] for confirming a reset to [update]'s value in [empathetechConfig]
  /// A preview of the reset color is shown
  Future<dynamic> _reset(BuildContext context) {
    final Color resetColor = Color(EzConfig.instance.defaults[widget.update]);

    // Define action button parameters //

    final void Function() onConfirm = () {
      // Remove the user's setting and reset the current state
      if (widget.update == null) {
        for (String key in widget.updating!) {
          EzConfig.instance.preferences.remove(key);
        }
      } else {
        EzConfig.instance.preferences.remove(widget.update!);
      }

      if (widget.autoUpdateTextKey != null) {
        EzConfig.instance.preferences.remove(widget.autoUpdateTextKey!);
      }

      setState(() {
        currColor = resetColor;
      });

      popScreen(context: context, pass: resetColor);
    };

    final void Function() onDeny = () => popScreen(context: context);

    return showPlatformDialog(
      context: context,
      builder: (context) => EzAlertDialog(
        title: Text(
          EFUILang.of(context)!.csResetTo,
          textAlign: TextAlign.center,
        ),
        // Reset color preview
        contents: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: resetColor,
              border: Border.all(color: getTextColor(resetColor)),
            ),
          ),
        ],
        materialActions: ezMaterialActions(
          context: context,
          onConfirm: onConfirm,
          onDeny: onDeny,
        ),
        cupertinoActions: ezCupertinoActions(
          context: context,
          onConfirm: onConfirm,
          onDeny: onDeny,
        ),
        needsClose: false,
      ),
    );
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzRow(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Color label
        SelectableText(
          widget.label,
          style: _labelStyle,
          textAlign: TextAlign.center,
        ),
        EzSpacer.row(_buttonSpacer),

        // Color preview/edit button
        Semantics(
          button: true,
          hint: EFUILang.of(context)!.csPickerSemantics(widget.label),
          child: ExcludeSemantics(
            child: ElevatedButton(
              onPressed: () => _changeColor(context),
              onLongPress: () => _reset(context),
              child: Center(
                child: Icon(
                  PlatformIcons(context).edit,
                  color: getTextColor(currColor),
                  size: _diameter / 2,
                ),
              ),
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    backgroundColor: MaterialStatePropertyAll(currColor),
                    shape: MaterialStatePropertyAll(const CircleBorder()),
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    fixedSize:
                        MaterialStatePropertyAll(Size(_diameter, _diameter)),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
