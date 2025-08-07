/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzItalicSetting extends StatefulWidget {
  /// The [EzConfig] whose value is being updated
  final String configKey;

  /// Optional callback to live update the [TextStyle] on your UI
  final void Function(bool italic) notifierCallback;

  /// Optional override
  /// Defaults to [ThemeData.iconButtonTheme]s value
  final double? size;

  /// Standardized tool for toggling [FontStyle.italic] in the [TextStyle.fontStyle] that matches [configKey]
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

  late final double padding = EzConfig.get(paddingKey);

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  late bool isItalic = EzConfig.get(widget.configKey) ?? false;

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzIconButton(
      style: isItalic
          ? IconButton.styleFrom(
              foregroundColor: colorScheme.primary,
              side: BorderSide(color: colorScheme.primaryContainer),
              padding: EzInsets.wrap(padding),
            )
          : IconButton.styleFrom(
              foregroundColor: colorScheme.outline,
              side: BorderSide(color: colorScheme.outlineVariant),
              padding: EzInsets.wrap(padding),
            ),
      onPressed: () async {
        isItalic = !isItalic;
        await EzConfig.setBool(widget.configKey, isItalic);
        widget.notifierCallback(isItalic);
        setState(() {});
      },
      tooltip: ezL10n(context).tsItalic,
      iconSize: widget.size,
      icon: const Icon(Icons.format_italic),
    );
  }
}
