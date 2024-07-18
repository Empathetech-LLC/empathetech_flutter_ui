/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzFontFamilyBatchSetting extends StatefulWidget {
  final List<String> configKeys;

  /// Use this to live update the [TextStyle] on your UI
  /// Recommended to use [fuseWithGFont]
  final void Function(String) notifierCallback;

  final String? tooltip;

  /// Standardized tool for updating the [TextStyle.fontFamily] for the passed [configKey]
  /// [EzFontFamilyBatchSetting] options are built from [googleStyles]
  const EzFontFamilyBatchSetting({
    super.key,
    required this.configKeys,
    required this.notifierCallback,
    this.tooltip,
  });

  @override
  State<EzFontFamilyBatchSetting> createState() =>
      _FontFamilyBatchSettingState();
}

class _FontFamilyBatchSettingState extends State<EzFontFamilyBatchSetting> {
  // Gather the theme data //

  late final String defaultFontFamily =
      EzConfig.getDefault(widget.configKeys.first);

  late String currFontFamily =
      //  EzConfig.get(widget.configKey) ??
      defaultFontFamily;

  late final ThemeData theme = Theme.of(context);

  // Define button functions //

  /// Builds an [EzAlertDialog] with [googleStyles] mapped to a list of [ElevatedButton]s
  late final List<DropdownMenuEntry<String>> entries =
      googleStyles.entries.map((MapEntry<String, TextStyle> entry) {
    return DropdownMenuEntry<String>(
      value: entry.key,
      label: entry.key,
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
        onSelected: (String? fontFamily) {
          if (fontFamily == null) return;
          currFontFamily = fontFamily;
          widget.notifierCallback(fontFamily);
          // EzConfig.setString(widget.configKey, fontFamily);
          setState(() {});
        },
        textStyle: googleStyles[currFontFamily]?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        width: smallBreakpoint / 4,
      ),
    );
  }
}
