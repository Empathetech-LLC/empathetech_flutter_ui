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

  late bool isItalic = EzConfig.get(widget.configKey) ?? false;

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  // Define the build //

  void swapState() async {
    isItalic = !isItalic;
    await EzConfig.setBool(widget.configKey, isItalic);
    widget.notifierCallback(isItalic);
    setState(() {});
  }

  late final String tooltip = EFUILang.of(context)!.tsItalic;

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return isItalic
        ? IconButton(
            icon: const Icon(Icons.format_italic),
            color: colorScheme.primary,
            iconSize: widget.size,
            onPressed: swapState,
            tooltip: tooltip,
          )
        : IconButton(
            icon: const Icon(Icons.format_italic_outlined),
            color: colorScheme.outline,
            iconSize: widget.size,
            onPressed: swapState,
            tooltip: tooltip,
          );
  }
}
