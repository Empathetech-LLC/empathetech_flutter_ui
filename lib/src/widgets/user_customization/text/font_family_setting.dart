/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EzFontFamilySetting extends StatefulWidget {
  /// The [EzConfig] key whose value is being updated
  final String configKey;

  /// An alt to updateBoth
  final String? mirrorKey;

  /// [Provider] tracking the [TextStyle] to be updated
  /// [EzFontFamilySetting] uses [EzTextStyleProvider.fuse]
  final EzTextStyleProvider provider;

  /// [Tooltip.message] passthrough
  final String? tooltip;

  /// Base [TextStyle] for the [DropdownMenu]
  /// Will be provided to [fuseWithGFont] alongside the current selection
  final TextStyle baseStyle;

  /// Standardized tool for updating the [TextStyle.fontFamily] for the passed [configKey] and [provider] combo
  /// [EzFontFamilySetting] options are built from [googleStyles]
  const EzFontFamilySetting({
    super.key,
    required this.configKey,
    this.mirrorKey,
    required this.provider,
    required this.baseStyle,
    this.tooltip,
  });

  @override
  State<EzFontFamilySetting> createState() => _FontFamilySettingState();
}

class _FontFamilySettingState extends State<EzFontFamilySetting> {
  // Return the build //

  late String? currFontFamily = widget.provider.value.fontFamily == null
      ? null
      : ezClassToCamel(ezFirstWord(widget.provider.value.fontFamily!));

  @override
  Widget build(BuildContext context) => Tooltip(
        message: widget.tooltip ?? EzConfig.l10n.tsFontFamily,
        child: EzDropdownMenu<String>(
          widthEntries: <String>[fingerPaint],
          textStyle: fuseWithGFont(
            starter: widget.baseStyle,
            gFont: currFontFamily ?? EzConfig.get(widget.configKey),
          ),
          dropdownMenuEntries:
              googleStyles.entries.map((MapEntry<String, TextStyle> entry) {
            return DropdownMenuEntry<String>(
              value: entry.key,
              label: ezCamelToTitle(entry.key),
              style: TextButton.styleFrom(textStyle: entry.value),
            );
          }).toList(),
          enableSearch: false,
          initialSelection: currFontFamily,
          onSelected: (String? fontFamily) async {
            if (fontFamily == null) return;
            currFontFamily = fontFamily;

            await EzConfig.setString(widget.configKey, fontFamily);
            if (widget.mirrorKey != null) {
              await EzConfig.setString(widget.mirrorKey!, fontFamily);
            }

            widget.provider.fuse(fontFamily);
            setState(() {});
          },
        ),
      );
}
