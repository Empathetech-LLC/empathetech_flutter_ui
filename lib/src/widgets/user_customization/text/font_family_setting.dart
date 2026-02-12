/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzFontSetting extends StatefulWidget {
  /// Which [TextStyle] to update
  final EzTextSettingType type;

  /// Callback to live update the [TextStyle] on your UI
  final void Function(String font) notifierCallback;

  /// Whether both [ThemeMode]s should be updated
  final bool updateBoth;

  /// Base [TextStyle] for the [DropdownMenu]
  /// Will be provided to [fuseWithGFont] alongside the current selection
  final TextStyle baseStyle;

  /// Standardized tool for updating the [TextStyle.fontFamily] that matches [type]
  /// [EzFontSetting] options are built from [googleStyles]
  const EzFontSetting({
    required super.key,
    required this.type,
    required this.baseStyle,
    required this.updateBoth,
    required this.notifierCallback,
  });

  @override
  State<EzFontSetting> createState() => _FontSettingState();
}

class _FontSettingState extends State<EzFontSetting> {
  late String? currFont = EzConfig.get(widget.type.fontKey) == null
      ? null
      : ezClassToCamel(ezFirstWord(EzConfig.get(widget.type.fontKey)));

  @override
  Widget build(BuildContext context) => Tooltip(
        message: EzConfig.l10n.tsFontFamily,
        child: EzDropdownMenu<String>(
          widthEntries: <String>[fingerPaint],
          textStyle: fuseWithGFont(
            starter: widget.baseStyle,
            gFont: currFont ?? EzConfig.get(widget.type.fontKey),
          ),
          dropdownMenuEntries: googleStyles.entries
              .map((MapEntry<String, TextStyle> entry) =>
                  DropdownMenuEntry<String>(
                    value: entry.key,
                    label: ezCamelToTitle(entry.key),
                    style: TextButton.styleFrom(textStyle: entry.value),
                  ))
              .toList(),
          enableSearch: false,
          initialSelection: currFont,
          onSelected: (String? font) async {
            if (font == null) return;
            currFont = font;

            await EzConfig.setString(widget.type.fontKey, font);
            if (widget.updateBoth) {
              await EzConfig.setString(widget.type.fontMirror, font);
            }

            widget.notifierCallback(font);
            if (context.mounted) {
              EzConfig.pingRebuild(font == widget.type.liveFont(context));
            }

            setState(() {});
          },
        ),
      );
}
