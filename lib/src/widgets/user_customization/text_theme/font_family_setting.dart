/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EzFontFamilySetting extends StatefulWidget {
  /// The [EzConfig] key for the [TextStyle.fontFamily] to be updated
  final String configKey;

  /// [Provider] tracking the [TextStyle] to be updated
  /// [EzFontFamilySetting] uses [BaseTextStyleProvider.fuse]
  final BaseTextStyleProvider provider;

  final String? tooltip;

  /// Base [TextStyle] for the [DropdownMenu]
  /// Will be provided to [fuseWithGFont] alongside the current selection
  final TextStyle baseStyle;

  /// Standardized tool for updating the [TextStyle.fontFamily] for the passed [configKey] and [provider] combo
  /// [EzFontFamilySetting] options are built from [googleStyles]
  const EzFontFamilySetting({
    super.key,
    required this.configKey,
    required this.provider,
    required this.baseStyle,
    this.tooltip,
  });

  @override
  State<EzFontFamilySetting> createState() => _FontFamilySettingState();
}

class _FontFamilySettingState extends State<EzFontFamilySetting> {
  // Gather the theme data //

  late final ThemeData theme = Theme.of(context);

  // Define the build data  //

  late String currFontFamily = firstWord(
      widget.provider.value.fontFamily ?? EzConfig.get(widget.configKey));

  /// Builds an [EzAlertDialog] with [googleStyles] mapped to a list of [DropdownMenuEntry]s
  late final List<DropdownMenuEntry<String>> entries =
      googleStyles.entries.map((MapEntry<String, TextStyle> entry) {
    return DropdownMenuEntry<String>(
      value: entry.key,
      label: googleStyleNames[entry.key]!,
      style: theme.textButtonTheme.style?.copyWith(
        textStyle: WidgetStatePropertyAll<TextStyle>(entry.value),
      ),
    );
  }).toList();

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip ?? EFUILang.of(context)!.tsFontFamily,
      child: DropdownMenu<String>(
        initialSelection: currFontFamily,
        dropdownMenuEntries: entries,
        onSelected: (String? fontFamily) async {
          if (fontFamily == null) return;
          currFontFamily = fontFamily;

          await EzConfig.setString(widget.configKey, fontFamily);

          widget.provider.fuse(fontFamily);

          setState(() {});
        },
        textStyle: fuseWithGFont(
          starter: widget.baseStyle,
          gFont: currFontFamily,
        ),
        width: smallBreakpoint / 4,
      ),
    );
  }
}
