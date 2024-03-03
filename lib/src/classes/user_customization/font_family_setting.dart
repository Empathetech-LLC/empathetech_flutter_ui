/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzFontFamilySetting extends StatefulWidget {
  final String styleKey;

  /// Standardized tool for updating the [TextStyle.fontFamily] for the passed [styleKey]
  /// [EzFontFamilySetting] options are built from [googleStyles]
  const EzFontFamilySetting({super.key, required this.styleKey});

  @override
  State<EzFontFamilySetting> createState() => _FontFamilySettingState();
}

class _FontFamilySettingState extends State<EzFontFamilySetting> {
  // Gather the theme data //

  late final EFUILang l10n = EFUILang.of(context)!;

  late final String defaultFontFamily = EzConfig.getDefault(widget.styleKey);

  late String currFontFamily =
      EzConfig.get(widget.styleKey) ?? EzConfig.getDefault(widget.styleKey);

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
      initialSelection: currFontFamily,
      dropdownMenuEntries: entries,
      onSelected: (String? fontFamily) {
        if (fontFamily == null) return;
        EzConfig.setString(widget.styleKey, fontFamily);
        setState(() {
          currFontFamily = fontFamily;
        });
      },
      textStyle: googleStyles[currFontFamily],
    );
  }
}
