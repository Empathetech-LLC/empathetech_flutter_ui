/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzFontDecorationSetting extends StatefulWidget {
  final String configKey;

  /// Standardized tool for updating the [TextStyle.decoration] for the passed [configKey]
  const EzFontDecorationSetting({super.key, required this.configKey});

  @override
  State<EzFontDecorationSetting> createState() => _FontDecorationSettingState();
}

class _FontDecorationSettingState extends State<EzFontDecorationSetting> {
  // Gather the theme data //

  late final String defaultFontDecoration =
      EzConfig.getDefault(widget.configKey);

  late String currFontDecoration =
      EzConfig.get(widget.configKey) ?? defaultFontDecoration;

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
    return DropdownMenu<String>(
      initialSelection: currFontDecoration,
      dropdownMenuEntries: entries,
      onSelected: (String? fontFamily) {
        if (fontFamily == null) return;
        EzConfig.setString(widget.configKey, fontFamily);
        setState(() {
          currFontDecoration = fontFamily;
        });
      },
      textStyle: googleStyles[currFontDecoration],
    );
  }
}
