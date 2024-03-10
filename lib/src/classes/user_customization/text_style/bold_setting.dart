/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzFontWeightSetting extends StatefulWidget {
  final String configKey;

  /// Standardized tool for updating the [TextStyle.fontWeight] for the passed [configKey]
  const EzFontWeightSetting({super.key, required this.configKey});

  @override
  State<EzFontWeightSetting> createState() => _FontWeightSettingState();
}

class _FontWeightSettingState extends State<EzFontWeightSetting> {
  // Gather the theme data //

  late bool isBold = EzConfig.get(widget.configKey) ?? false;

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  // Define the build //

  void swapState() {
    setState(() {
      isBold = !isBold;
    });
    EzConfig.setBool(widget.configKey, isBold);
  }

  late final String tooltip = EFUILang.of(context)!.tsBold;

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return isBold
        ? IconButton(
            icon: const Icon(Icons.format_bold),
            color: colorScheme.primary,
            onPressed: swapState,
            tooltip: tooltip,
          )
        : IconButton(
            icon: const Icon(Icons.format_bold_outlined),
            color: colorScheme.outline,
            onPressed: swapState,
            tooltip: tooltip,
          );
  }
}
