/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzFontFamilyBatchSetting extends StatefulWidget {
  /// Optional [Tooltip] message for the [DropdownMenu]
  final String? tooltip;

  /// Must have each iteration of [BaseTextStyleProvider] in this parent's widget tree
  /// Updates all font families at once
  const EzFontFamilyBatchSetting({super.key, this.tooltip});

  @override
  State<EzFontFamilyBatchSetting> createState() =>
      _FontFamilyBatchSettingState();
}

class _FontFamilyBatchSettingState extends State<EzFontFamilyBatchSetting> {
  // Gather the theme data //

  late final ThemeData theme = Theme.of(context);
  late final EFUILang l10n = EFUILang.of(context)!;

  late final DisplayTextStyleProvider displayProvider =
      Provider.of<DisplayTextStyleProvider>(context);
  late final HeadlineTextStyleProvider headlineProvider =
      Provider.of<HeadlineTextStyleProvider>(context);
  late final TitleTextStyleProvider titleProvider =
      Provider.of<TitleTextStyleProvider>(context);
  late final BodyTextStyleProvider bodyProvider =
      Provider.of<BodyTextStyleProvider>(context);
  late final LabelTextStyleProvider labelProvider =
      Provider.of<LabelTextStyleProvider>(context);

  // Define the build data //

  late Map<String, String> currFonts = <String, String>{
    displayFontFamilyKey: firstWord(
        displayProvider.value.fontFamily ?? EzConfig.get(displayFontFamilyKey)),
    headlineFontFamilyKey: firstWord(headlineProvider.value.fontFamily ??
        EzConfig.get(headlineFontFamilyKey)),
    titleFontFamilyKey: firstWord(
        titleProvider.value.fontFamily ?? EzConfig.get(titleFontFamilyKey)),
    bodyFontFamilyKey: firstWord(
        bodyProvider.value.fontFamily ?? EzConfig.get(bodyFontFamilyKey)),
    labelFontFamilyKey: firstWord(
        labelProvider.value.fontFamily ?? EzConfig.get(labelFontFamilyKey)),
  };

  late bool isUniform =
      currFonts.values.every((String font) => font == currFonts.values.first);

  late String currFontFamily = isUniform
      ? currFonts.values.first
      : mostCommonFont(currFonts.values.toList());

  // Define button functions //

  /// Lazily returns the most common font, or the body font if all are unique
  String mostCommonFont(List<String> fonts) {
    final String body = EzConfig.get(bodyFontFamilyKey) ??
        EzConfig.getDefault(bodyFontFamilyKey);

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

  /// Builds an [EzAlertDialog] with [googleStyles] mapped to a list of [DropdownMenuEntry]s
  late final List<DropdownMenuEntry<String>> entries =
      googleStyles.entries.map((MapEntry<String, TextStyle> entry) {
    return DropdownMenuEntry<String>(
      value: entry.key,
      label: googleStyleNames[entry.key]!,
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
        initialSelection: currFontFamily,
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

          currFontFamily = fontFamily;

          for (final String key in currFonts.keys) {
            await EzConfig.setString(key, fontFamily);
          }

          displayProvider.fuse(fontFamily);
          headlineProvider.fuse(fontFamily);
          titleProvider.fuse(fontFamily);
          bodyProvider.fuse(fontFamily);
          labelProvider.fuse(fontFamily);

          setState(() {});
        },
        textStyle: bodyProvider.value,
        width: smallBreakpoint / 4,
      ),
    );
  }
}
