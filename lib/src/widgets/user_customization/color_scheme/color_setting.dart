/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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

  late final EFUILang l10n = ezL10n(context);

  late final int? _prefsValue = EzConfig.get(widget.configKey);

  late Color currColor = (_prefsValue == null)
      ? getLiveColor(context, widget.configKey)
      : Color(_prefsValue);

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
      onConfirm: () async {
        await EzConfig.setInt(widget.configKey, currColor.toARGB32());
        widget.onUpdate?.call(currColor);
      },
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
    } else {
      // 'on' (aka text) color //
      final String backgroundKey = widget.configKey.replaceAll(
        textColorPrefix,
        '',
      );

      // Find the recommended contrast color for the background
      final int? backgroundColorValue = EzConfig.get(backgroundKey);
      final Color backgroundColor = (backgroundColorValue == null)
          ? getLiveColor(context, backgroundKey)
          : Color(backgroundColorValue);

      final int recommended = getTextColor(backgroundColor).toARGB32();

      // Just open a color picker if the value is already what's recommended
      if (recommended == currColor.toARGB32()) return openColorPicker(context);

      return showPlatformDialog(
        context: context,
        builder: (BuildContext dContext) {
          void onConfirm() async {
            final dynamic chosen = await openColorPicker(context);

            if (dContext.mounted) {
              Navigator.of(dContext).pop(chosen);
            }
          }

          void onDeny() async {
            // Update the user's configKey
            currColor = Color(recommended);
            await EzConfig.setInt(widget.configKey, recommended);
            setState(() {});
            widget.onUpdate?.call(currColor);

            if (dContext.mounted) {
              Navigator.of(dContext).pop(recommended);
            }
          }

          late final List<Widget> materialActions;
          late final List<Widget> cupertinoActions;

          (materialActions, cupertinoActions) = ezActionPairs(
            context: context,
            confirmMsg: l10n.csUseCustom,
            onConfirm: onConfirm,
            confirmIsDestructive: true,
            denyMsg: l10n.gYes,
            denyIsDefault: true,
            onDeny: onDeny,
          );

          return EzAlertDialog(
            title: Text(
              l10n.csRecommended,
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
            materialActions: materialActions,
            cupertinoActions: cupertinoActions,
          );
        },
      );
    }
  }

  /// Opens an [EzAlertDialog] for resetting the [widget.configKey] to default
  /// If there is no [EzConfig.defaults] value, the key will simply be removed from [EzConfig.prefs]
  /// If a value is found, a preview of the reset color is shown and the user can confirm/deny
  Future<dynamic> reset(BuildContext context) async {
    return showPlatformDialog(
      context: context,
      builder: (BuildContext dContext) {
        final int? resetValue = EzConfig.getDefault(widget.configKey);
        final String currColorLabel =
            currColor.toARGB32().toRadixString(16).toUpperCase().substring(2);

        void onConfirm() async {
          // Remove the user's configKey and reset the current state
          await EzConfig.remove(widget.configKey);
          if (resetValue != null) currColor = Color(resetValue);
          setState(() {});

          if (dContext.mounted) Navigator.of(dContext).pop();
        }

        void onDeny() => Navigator.of(dContext).pop();

        late final List<Widget> materialActions;
        late final List<Widget> cupertinoActions;

        (materialActions, cupertinoActions) = ezActionPairs(
          context: context,
          onConfirm: onConfirm,
          confirmIsDestructive: true,
          onDeny: onDeny,
        );

        return EzAlertDialog(
          title: Text(
            l10n.gResetValue(
              getColorName(widget.configKey).toLowerCase(),
            ),
            textAlign: TextAlign.center,
          ),
          contents: <Widget>[
            Text(l10n.csCurrVal, textAlign: TextAlign.center),
            EzMargin(),
            EzTextIconButton(
              onPressed: () => Clipboard.setData(
                ClipboardData(text: currColorLabel),
              ),
              icon: EzIcon(Icons.copy),
              label: currColorLabel,
            ),
          ],
          materialActions: materialActions,
          cupertinoActions: cupertinoActions,
          needsClose: false,
        );
      },
    );
  }

  /// Opens an [EzAlertDialog] with the all optional actions
  /// Currently: remove from list and reset to default
  Future<dynamic> options(BuildContext context) => (widget.onRemove == null)
      ? reset(context)
      : showPlatformDialog(
          context: context,
          builder: (BuildContext dContext) => EzAlertDialog(
            title: Text(
              l10n.gOptions,
              textAlign: TextAlign.center,
            ),
            contents: <Widget>[
              // Remove from list
              EzElevatedIconButton(
                onPressed: () {
                  widget.onRemove!();
                  Navigator.of(dContext).pop();
                },
                icon: EzIcon(PlatformIcons(context).delete),
                label: l10n.gRemove,
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
                icon: EzIcon(PlatformIcons(context).refresh),
                label: l10n.gReset,
              ),
            ],
          ),
        );

  @override
  Widget build(BuildContext context) {
    // Gather the contextual theme data //

    final double padding = EzConfig.padding;
    final double iconRadius = EzConfig.iconSize / 2;

    final ThemeData theme = Theme.of(context);
    final String label = getColorName(widget.configKey);

    // Return the build //

    return Semantics(
      label: label,
      button: true,
      hint: l10n.csPickerHint,
      child: ExcludeSemantics(
        child: EzElevatedIconButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(padding * 0.75),
          ),
          onPressed: () => changeColor(context),
          onLongPress: () => options(context),
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: theme.colorScheme.primaryContainer),
            ),
            child: currColor == Colors.transparent
                ? CircleAvatar(
                    backgroundColor: theme.colorScheme.surface,
                    foregroundColor: theme.colorScheme.onSurface,
                    radius: iconRadius + padding,
                    child: EzIcon(PlatformIcons(context).eyeSlash),
                  )
                : CircleAvatar(
                    backgroundColor: currColor,
                    radius: iconRadius + padding,
                  ),
          ),
          label: label,
        ),
      ),
    );
  }
}
