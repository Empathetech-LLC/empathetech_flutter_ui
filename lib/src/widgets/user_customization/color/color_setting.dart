/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EzColorSetting extends StatefulWidget {
  /// [EzConfig] key whose [Color] will be updated
  final String configKey;

  /// Optional callback function for when the color is updated
  final void Function(Color)? onUpdate;

  /// Optional callback for when the [configKey] is removed, if it is part of a dynamic set/list
  /// If null, the remove button will not be shown
  /// DO NOT include a pop() for the dialog, this is included automatically
  final void Function()? onRemove;

  /// Creates a tool for [configKey] ColorScheme values via [EzConfig]
  /// When [configKey] is a text color (has [textColorPrefix]), the base color will be used to generate a recommendation via [getTextColor]
  /// [EzColorSetting] inherits styling from the [ElevatedButton] and [AlertDialog] values in your [ThemeData]
  const EzColorSetting({
    super.key,
    required this.configKey,
    this.onUpdate,
    this.onRemove,
  });

  @override
  State<EzColorSetting> createState() => _ColorSettingState();
}

class _ColorSettingState extends State<EzColorSetting> {
  // Define the build data //

  late Color currColor = (EzConfig.get(widget.configKey) == null)
      ? getLiveColor(widget.configKey)
      : Color(EzConfig.get(widget.configKey));

  // Define custom functions //

  /// Opens an [ezColorPicker] for updating [currColor]
  /// Returns the [Color] of what was chosen (null otherwise)
  Future<dynamic> openColorPicker(BuildContext context) {
    final Color backup = currColor;

    return ezColorPicker(
      context,
      startColor: backup,
      onColorChange: (Color chosenColor) =>
          setState(() => currColor = chosenColor),
      onConfirm: () => EzConfig.setInt(widget.configKey, currColor.toARGB32()),
      onDeny: () => setState(() => currColor = backup),
    );
  }

  /// Opens an [EzAlertDialog] for users to chose how they want to update the color
  /// Returns the [Color] of what was chosen (null if none)
  Future<dynamic> changeColor(BuildContext context) {
    if (!widget.configKey.contains(textColorPrefix)) {
      // Base color //
      // Just open a color picker

      return openColorPicker(context);
    }
    // 'on' (aka text) color //

    // Get its background pair
    final String backgroundKey = widget.configKey.replaceAll(
      textColorPrefix,
      '',
    );

    // Find the recommended contrast color for the background
    final int? backgroundColorValue = EzConfig.get(backgroundKey);
    final Color backgroundColor = (backgroundColorValue == null)
        ? getLiveColor(backgroundKey)
        : Color(backgroundColorValue);

    final int recommended = getTextColor(backgroundColor).toARGB32();

    // Just open a color picker if the value is already what's recommended
    if (recommended == currColor.toARGB32()) return openColorPicker(context);

    // Otherwise, let the user choose...
    // Recommended, custom, or cancel (close)
    return showDialog(
      context: context,
      builder: (BuildContext dContext) => EzAlertDialog(
        title: Text(
          EzConfig.l10n.csRecommended,
          textAlign: TextAlign.center,
        ),
        // Recommended color preview
        contents: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: backgroundColor),
            ),
            child: CircleAvatar(
              backgroundColor: Color(recommended),
              radius: (EzConfig.iconSize / 2) + EzConfig.padding,
            ),
          ),
        ],
        actions: <EzMaterialAction>[
          EzMaterialAction(
            text: EzConfig.l10n.gYes,
            onPressed: () async {
              // Update the user's configKey
              await EzConfig.setInt(widget.configKey, recommended);
              setState(() => currColor = Color(recommended));
              if (dContext.mounted) Navigator.of(dContext).pop(recommended);
            },
            isDefaultAction: true,
          ),
          EzMaterialAction(
            text: EzConfig.l10n.csUseCustom,
            onPressed: () async {
              final dynamic chosen = await openColorPicker(context);
              if (dContext.mounted) Navigator.of(dContext).pop(chosen);
            },
            isDestructiveAction: true,
          ),
        ],
      ),
    );
  }

  /// Opens an [EzAlertDialog] for resetting [configKey] to default
  /// If there is no default value, the key will simply be removed from [EzConfig.prefs]
  /// If a value is found, a preview of the reset color is shown and the user can confirm/deny
  Future<dynamic> reset(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext dContext) {
          final int? resetValue = EzConfig.getDefault(widget.configKey);
          final String currColorLabel =
              currColor.toARGB32().toRadixString(16).toUpperCase().substring(2);

          return EzAlertDialog(
            title: Text(
              EzConfig.l10n
                  .gResetValue(getColorName(widget.configKey).toLowerCase()),
              textAlign: TextAlign.center,
            ),
            contents: <Widget>[
              // Label
              Text(EzConfig.l10n.csCurrVal, textAlign: TextAlign.center),
              EzConfig.margin,

              // Copy-able value
              EzTextIconButton(
                onPressed: () =>
                    Clipboard.setData(ClipboardData(text: currColorLabel)),
                icon: const Icon(Icons.copy),
                label: currColorLabel,
              ),
            ],
            actions: ezActionPair(
              context: context,
              onConfirm: () async {
                // Remove the user's configKey and reset the current state
                await EzConfig.remove(widget.configKey);
                if (resetValue != null) currColor = Color(resetValue);
                setState(() {});

                if (dContext.mounted) Navigator.of(dContext).pop();
              },
              confirmIsDestructive: true,
              onDeny: () => Navigator.of(dContext).pop(),
            ),
            needsClose: false,
          );
        },
      );

  /// Opens an [EzAlertDialog] with the all optional actions
  /// Currently: remove from list and reset to default
  Future<dynamic> options(BuildContext context) => (widget.onRemove == null)
      ? reset(context)
      : showDialog(
          context: context,
          builder: (BuildContext dContext) => EzAlertDialog(
            title: Text(EzConfig.l10n.gOptions, textAlign: TextAlign.center),
            contents: <Widget>[
              // Remove from list
              EzElevatedIconButton(
                onPressed: () {
                  widget.onRemove!();
                  Navigator.of(dContext).pop();
                },
                icon: const Icon(Icons.delete),
                label: EzConfig.l10n.gRemove,
              ),
              EzConfig.spacer,

              // Reset to default
              EzElevatedIconButton(
                onPressed: () async {
                  final dynamic resetResponse = await reset(context);

                  if (dContext.mounted) {
                    Navigator.of(dContext).pop(resetResponse);
                  }
                },
                icon: const Icon(Icons.refresh),
                label: EzConfig.l10n.gReset,
              ),
            ],
          ),
        );

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final double iconRadius = EzConfig.iconSize / 2;
    final String label = getColorName(widget.configKey);

    return Semantics(
      label: label,
      button: true,
      hint: EzConfig.l10n.csPickerHint,
      child: ExcludeSemantics(
        child: EzElevatedIconButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(EzConfig.padding * 0.75),
          ),
          onPressed: () => changeColor(context),
          onLongPress: () => options(context),
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: EzConfig.colors.primaryContainer),
            ),
            child: currColor == Colors.transparent
                ? CircleAvatar(
                    backgroundColor: EzConfig.colors.surface,
                    foregroundColor: EzConfig.colors.onSurface,
                    radius: iconRadius + EzConfig.padding,
                    child: EzIcon(Icons.visibility_off),
                  )
                : CircleAvatar(
                    backgroundColor: currColor,
                    radius: iconRadius + EzConfig.padding,
                  ),
          ),
          label: label,
        ),
      ),
    );
  }
}
