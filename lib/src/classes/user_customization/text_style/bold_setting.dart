/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzBoldSetting extends StatefulWidget {
  final String configKey;

  /// Use this to live update the [TextStyle] on your UI
  final void Function(bool bold) notifierCallback;

  /// Standardized tool for updating the [TextStyle.fontWeight] for the passed [configKey]
  const EzBoldSetting({
    super.key,
    required this.configKey,
    required this.notifierCallback,
  });

  @override
  State<EzBoldSetting> createState() => _EzBoldSettingState();
}

class _EzBoldSettingState extends State<EzBoldSetting> {
  // Gather the theme data //

  late bool isBold = EzConfig.get(widget.configKey) ?? false;

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  // Define the build //

  void swapState() {
    setState(() {
      isBold = !isBold;
      widget.notifierCallback(isBold);
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
