/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzFontFamilySetting extends StatefulWidget {
  final String configKey;

  /// Use this to live update the [TextStyle] on your UI
  /// Recommended to use [fuseWithGFont]
  final void Function(String) notifierCallback;

  final String? tooltip;

  /// Standardized tool for updating the [TextStyle.fontFamily] for the passed [configKey]
  /// [EzFontFamilySetting] options are built from [googleStyles]
  const EzFontFamilySetting({
    super.key,
    required this.configKey,
    required this.notifierCallback,
    this.tooltip,
  });

  @override
  State<EzFontFamilySetting> createState() => _FontFamilySettingState();
}

class _FontFamilySettingState extends State<EzFontFamilySetting> {
  // Gather the theme data //

  late final String defaultFontFamily = EzConfig.getDefault(widget.configKey);

  late String currFontFamily =
      EzConfig.get(widget.configKey) ?? defaultFontFamily;

  // Define button functions //

  /// Builds an [EzAlertDialog] with [googleStyles] mapped to a list of [ElevatedButton]s

  late final List<DropdownMenuEntry<String>> entries =
      googleStyles.entries.map((MapEntry<String, TextStyle> entry) {
    return DropdownMenuEntry<String>(
      value: entry.key,
      label: entry.key,
      style: Theme.of(context).textButtonTheme.style?.copyWith(
            textStyle: MaterialStatePropertyAll<TextStyle>(entry.value),
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
        onSelected: (String? fontFamily) {
          if (fontFamily == null) return;
          EzConfig.setString(widget.configKey, fontFamily);
          setState(() {
            currFontFamily = fontFamily;
            widget.notifierCallback(fontFamily);
          });
        },
        textStyle: googleStyles[currFontFamily],
        width: smallBreakpoint / 4,
      ),
    );
  }
}
