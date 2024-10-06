/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzItalicSetting extends StatefulWidget {
  final String configKey;

  /// Use this to live update the [TextStyle] on your UI
  final void Function(bool italic) notifierCallback;

  /// Optional iconSize
  final double? size;

  /// Standardized tool for updating the [TextStyle.fontStyle] for the passed [configKey]
  const EzItalicSetting({
    super.key,
    required this.configKey,
    required this.notifierCallback,
    this.size,
  });

  @override
  State<EzItalicSetting> createState() => _EzItalicSettingState();
}

class _EzItalicSettingState extends State<EzItalicSetting> {
  // Gather the theme data //

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  late bool isItalic = EzConfig.get(widget.configKey) ?? false;

  // Define the build //

  late final String tooltip = EFUILang.of(context)!.tsItalic;

  void swapState() async {
    isItalic = !isItalic;
    await EzConfig.setBool(widget.configKey, isItalic);
    widget.notifierCallback(isItalic);
    setState(() {});
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return isItalic
        ? IconButton(
            style: IconButton.styleFrom(
              foregroundColor: colorScheme.primary,
              side: BorderSide(color: colorScheme.primaryContainer),
              iconSize: widget.size,
            ),
            onPressed: swapState,
            tooltip: tooltip,
            icon: const Icon(Icons.format_italic),
          )
        : IconButton(
            style: IconButton.styleFrom(
              foregroundColor: colorScheme.outline,
              side: BorderSide(color: colorScheme.primaryContainer),
              iconSize: widget.size,
            ),
            onPressed: swapState,
            tooltip: tooltip,
            icon: const Icon(Icons.format_italic_outlined),
          );
  }
}
