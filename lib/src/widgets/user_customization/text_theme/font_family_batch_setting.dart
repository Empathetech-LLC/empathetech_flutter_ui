/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzFontFamilyBatchSetting extends StatefulWidget {
  final EzDisplayStyleProvider displayProvider;
  final EzHeadlineStyleProvider headlineProvider;
  final EzTitleStyleProvider titleProvider;
  final EzBodyStyleProvider bodyProvider;
  final EzLabelStyleProvider labelProvider;

  /// Optional [EzDropdownMenu.iconSize] passthrough
  final double? iconSize;

  /// Standardized tool for updating the 5 [TextStyle.fontFamily]s
  const EzFontFamilyBatchSetting({
    super.key,
    required this.displayProvider,
    required this.headlineProvider,
    required this.titleProvider,
    required this.bodyProvider,
    required this.labelProvider,
    this.iconSize,
  });

  @override
  State<EzFontFamilyBatchSetting> createState() =>
      _FontFamilyBatchSettingState();
}

class _FontFamilyBatchSettingState extends State<EzFontFamilyBatchSetting> {
  // Define the build data //

  late Map<String, String?> currFonts = EzConfig.isDark
      ? <String, String?>{
          darkDisplayFontFamilyKey:
              widget.displayProvider.value.fontFamily == null
                  ? null
                  : ezClassToCamel(
                      ezFirstWord(widget.displayProvider.value.fontFamily!)),
          darkHeadlineFontFamilyKey:
              widget.headlineProvider.value.fontFamily == null
                  ? null
                  : ezClassToCamel(
                      ezFirstWord(widget.headlineProvider.value.fontFamily!)),
          darkTitleFontFamilyKey: widget.titleProvider.value.fontFamily == null
              ? null
              : ezClassToCamel(
                  ezFirstWord(widget.titleProvider.value.fontFamily!)),
          darkBodyFontFamilyKey: widget.bodyProvider.value.fontFamily == null
              ? null
              : ezClassToCamel(
                  ezFirstWord(widget.bodyProvider.value.fontFamily!)),
          darkLabelFontFamilyKey: widget.labelProvider.value.fontFamily == null
              ? null
              : ezClassToCamel(
                  ezFirstWord(widget.labelProvider.value.fontFamily!)),
        }
      : <String, String?>{
          lightDisplayFontFamilyKey:
              widget.displayProvider.value.fontFamily == null
                  ? null
                  : ezClassToCamel(
                      ezFirstWord(widget.displayProvider.value.fontFamily!)),
          lightHeadlineFontFamilyKey:
              widget.headlineProvider.value.fontFamily == null
                  ? null
                  : ezClassToCamel(
                      ezFirstWord(widget.headlineProvider.value.fontFamily!)),
          lightTitleFontFamilyKey: widget.titleProvider.value.fontFamily == null
              ? null
              : ezClassToCamel(
                  ezFirstWord(widget.titleProvider.value.fontFamily!)),
          lightBodyFontFamilyKey: widget.bodyProvider.value.fontFamily == null
              ? null
              : ezClassToCamel(
                  ezFirstWord(widget.bodyProvider.value.fontFamily!)),
          lightLabelFontFamilyKey: widget.labelProvider.value.fontFamily == null
              ? null
              : ezClassToCamel(
                  ezFirstWord(widget.labelProvider.value.fontFamily!)),
        };

  late bool isUniform =
      currFonts.values.every((String? font) => font == currFonts.values.first);

  late String? currFontFamily = isUniform ? currFonts.values.first : null;

  // Define button functions //

  /// Builds an [EzAlertDialog] with [googleStyles] mapped to a list of [DropdownMenuEntry]s
  late final List<DropdownMenuEntry<String>> entries = googleStyles.entries.map(
    (MapEntry<String, TextStyle> entry) {
      return DropdownMenuEntry<String>(
        value: entry.key,
        label: ezCamelToTitle(entry.key),
        style: TextButton.styleFrom(textStyle: entry.value),
      );
    },
  ).toList();

  /// Only activated if the user has already edited the font families in the advanced settings, and the changes aren't uniform
  // Confirm that the user wants to continue with batch editing, which will force uniformity
  Future<bool> confirmBatchOverride() async {
    return await showDialog(
      context: context,
      builder: (BuildContext dContext) => EzAlertDialog(
        title: Text(EzConfig.l10n.gAttention, textAlign: TextAlign.center),
        content: Text(
          EzConfig.l10n.tsBatchOverride(EzConfig.l10n.tsFontFamily),
          textAlign: TextAlign.center,
        ),
        actions: ezActionPair(
          context: context,
          onConfirm: () => Navigator.of(dContext).pop(true),
          confirmIsDestructive: true,
          onDeny: () => Navigator.of(dContext).pop(false),
        ),
        needsClose: false,
      ),
    );
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: EzConfig.l10n.tsFontFamily,
      child: EzDropdownMenu<String>(
        widthEntries: <String>[fingerPaint],
        iconSize: widget.iconSize,
        textStyle: widget.bodyProvider.value,
        dropdownMenuEntries: entries,
        enableSearch: false,
        initialSelection: currFontFamily,
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

          widget.displayProvider.fuse(fontFamily);
          widget.headlineProvider.fuse(fontFamily);
          widget.titleProvider.fuse(fontFamily);
          widget.bodyProvider.fuse(fontFamily);
          widget.labelProvider.fuse(fontFamily);

          setState(() {});
        },
      ),
    );
  }
}
