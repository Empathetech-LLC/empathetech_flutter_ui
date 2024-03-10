/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzFontStyleSetting extends StatefulWidget {
  final String configKey;

  /// Standardized tool for updating the [TextStyle.fontStyle] for the passed [configKey]
  const EzFontStyleSetting({super.key, required this.configKey});

  @override
  State<EzFontStyleSetting> createState() => _FontStyleSettingState();
}

class _FontStyleSettingState extends State<EzFontStyleSetting> {
  // Gather the theme data //

  late bool isItalic = EzConfig.get(widget.configKey) ?? false;

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  // Define the build //

  void swapState() {
    setState(() {
      isItalic = !isItalic;
    });
    EzConfig.setBool(widget.configKey, isItalic);
  }

  late final String tooltip = EFUILang.of(context)!.tsItalic;

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return isItalic
        ? IconButton(
            icon: const Icon(Icons.format_italic),
            color: colorScheme.primary,
            onPressed: swapState,
            tooltip: tooltip,
          )
        : IconButton(
            icon: const Icon(Icons.format_italic_outlined),
            color: colorScheme.outline,
            onPressed: swapState,
            tooltip: tooltip,
          );
  }
}
