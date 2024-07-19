/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzFontFamilyBatchSetting extends StatefulWidget {
  /// All [EzConfig] keys being edited paired with their default values
  final Map<String, String> keysNDefaults;

  /// Use this to live update the [TextStyle] on your UI
  /// Recommended to use [fuseWithGFont]
  final void Function(String) notifierCallback;

  final String? tooltip;

  /// Standardized tool for batch updating the [TextStyle.fontFamily] for the passed [keysNDefaults]
  /// [EzFontFamilyBatchSetting] options are built from [googleStyles]
  const EzFontFamilyBatchSetting({
    super.key,
    required this.keysNDefaults,
    required this.notifierCallback,
    this.tooltip,
  });

  @override
  State<EzFontFamilyBatchSetting> createState() =>
      _FontFamilyBatchSettingState();
}

class _FontFamilyBatchSettingState extends State<EzFontFamilyBatchSetting> {
  // Gather the theme data //

  late final ThemeData theme = Theme.of(context);
  late final EFUILang l10n = EFUILang.of(context)!;

  // Define the build data //

  late final Map<String, String> startingFonts = widget.keysNDefaults.map(
    (String key, String value) => MapEntry<String, String>(
      key,
      EzConfig.get(key) ?? value,
    ),
  );

  late bool isUniform = startingFonts.values
      .every((String font) => font == startingFonts.values.first);

  late String currFont = isUniform
      ? startingFonts.values.first
      : mostCommonOrBodyFont(startingFonts.values.toList());

  // Define button functions //

  /// Lazily returns the most common font, or the body font if all are unique
  String mostCommonOrBodyFont(List<String> fonts) {
    final String body = EzConfig.getDefault(bodyFontFamilyKey);

    if (fonts.isEmpty) return body;

    final Map<String, int> fontCount = <String, int>{};
    String? mostCommon;
    int highestCount = 0;

    for (final String font in fonts) {
      final int count = (fontCount[font] ?? 0) + 1;
      fontCount[font] = count;

      if (count > highestCount) {
        mostCommon = font;
        highestCount = count;
      }
    }

    if (highestCount <= 1) {
      return body;
    } else {
      return mostCommon!;
    }
  }

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

  /// Only activated if the user has already edited the font families in the advanced settings, and the changes aren't uniform
  // Confirm that the user wants to continue with batch editing, which will force uniformity
  Future<bool> confirmBatchOverride() async {
    return await showPlatformDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        void onConfirm() => Navigator.of(dialogContext).pop(true);

        void onDeny() => Navigator.of(dialogContext).pop(false);

        return EzAlertDialog(
          title: Text(
            l10n.ssLanguages,
            textAlign: TextAlign.center,
          ),
          content: Text(
            l10n.tsBatchOverride(l10n.tsFontFamily),
            textAlign: TextAlign.center,
          ),
          materialActions: ezMaterialActions(
            context: dialogContext,
            onConfirm: onConfirm,
            onDeny: onDeny,
          ),
          cupertinoActions: ezCupertinoActions(
            context: dialogContext,
            onConfirm: onConfirm,
            onDeny: onDeny,
          ),
          needsClose: false,
        );
      },
    );
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip ?? EFUILang.of(context)!.tsFontFamily,
      child: DropdownMenu<String>(
        initialSelection: currFont,
        dropdownMenuEntries: entries,
        onSelected: (String? fontFamily) async {
          if (fontFamily == null) return;

          if (!isUniform) {
            final bool override = await confirmBatchOverride();

            if (override) {
              isUniform = true;
            } else {
              return;
            }
          }

          currFont = fontFamily;
          widget.notifierCallback(fontFamily);

          for (final MapEntry<String, String> entry
              in widget.keysNDefaults.entries) {
            EzConfig.setString(entry.key, fontFamily);
          }

          setState(() {});
        },
        textStyle: googleStyles[currFont]?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        width: smallBreakpoint / 4,
      ),
    );
  }
}
