/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzFontFamilyBatchSetting extends StatefulWidget {
  /// Whether both theme modes should be updated
  final bool updateBoth;

  /// Requires the provider to be in the widget tree/context
  /// Allows for efficient (local) live updates, to avoid constant [EzConfig.rebuildUI] calls
  final EzDisplayStyleProvider displayProvider;

  /// Requires the provider to be in the widget tree/context
  /// Allows for efficient (local) live updates, to avoid constant [EzConfig.rebuildUI] calls
  final EzHeadlineStyleProvider headlineProvider;

  /// Requires the provider to be in the widget tree/context
  /// Allows for efficient (local) live updates, to avoid constant [EzConfig.rebuildUI] calls
  final EzTitleStyleProvider titleProvider;

  /// Requires the provider to be in the widget tree/context
  /// Allows for efficient (local) live updates, to avoid constant [EzConfig.rebuildUI] calls
  final EzBodyStyleProvider bodyProvider;

  /// Requires the provider to be in the widget tree/context
  /// Allows for efficient (local) live updates, to avoid constant [EzConfig.rebuildUI] calls
  final EzLabelStyleProvider labelProvider;

  /// Standardized tool for updating the 5 [TextStyle.fontFamily]s
  const EzFontFamilyBatchSetting({
    super.key,
    required this.updateBoth,
    required this.displayProvider,
    required this.headlineProvider,
    required this.titleProvider,
    required this.bodyProvider,
    required this.labelProvider,
  });

  @override
  State<EzFontFamilyBatchSetting> createState() =>
      _FontFamilyBatchSettingState();
}

class _FontFamilyBatchSettingState extends State<EzFontFamilyBatchSetting> {
  // Define the build data //

  late final Map<String, String?> darkFonts = <String, String?>{
    darkDisplayFontFamilyKey: widget.displayProvider.value.fontFamily == null
        ? null
        : ezClassToCamel(ezFirstWord(widget.displayProvider.value.fontFamily!)),
    darkHeadlineFontFamilyKey: widget.headlineProvider.value.fontFamily == null
        ? null
        : ezClassToCamel(
            ezFirstWord(widget.headlineProvider.value.fontFamily!)),
    darkTitleFontFamilyKey: widget.titleProvider.value.fontFamily == null
        ? null
        : ezClassToCamel(ezFirstWord(widget.titleProvider.value.fontFamily!)),
    darkBodyFontFamilyKey: widget.bodyProvider.value.fontFamily == null
        ? null
        : ezClassToCamel(ezFirstWord(widget.bodyProvider.value.fontFamily!)),
    darkLabelFontFamilyKey: widget.labelProvider.value.fontFamily == null
        ? null
        : ezClassToCamel(ezFirstWord(widget.labelProvider.value.fontFamily!)),
  };
  late final Map<String, String?> lightFonts = <String, String?>{
    lightDisplayFontFamilyKey: widget.displayProvider.value.fontFamily == null
        ? null
        : ezClassToCamel(ezFirstWord(widget.displayProvider.value.fontFamily!)),
    lightHeadlineFontFamilyKey: widget.headlineProvider.value.fontFamily == null
        ? null
        : ezClassToCamel(
            ezFirstWord(widget.headlineProvider.value.fontFamily!)),
    lightTitleFontFamilyKey: widget.titleProvider.value.fontFamily == null
        ? null
        : ezClassToCamel(ezFirstWord(widget.titleProvider.value.fontFamily!)),
    lightBodyFontFamilyKey: widget.bodyProvider.value.fontFamily == null
        ? null
        : ezClassToCamel(ezFirstWord(widget.bodyProvider.value.fontFamily!)),
    lightLabelFontFamilyKey: widget.labelProvider.value.fontFamily == null
        ? null
        : ezClassToCamel(ezFirstWord(widget.labelProvider.value.fontFamily!)),
  };

  // Init //

  String? currFontFamily;
  bool isUniform = false;

  @override
  void initState() {
    super.initState();

    final Map<String, String?> currFonts =
        EzConfig.isDark ? darkFonts : lightFonts;
    isUniform = currFonts.values
        .every((String? font) => font == currFonts.values.first);
    if (isUniform) currFontFamily = currFonts.values.first;
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => Tooltip(
        message: EzConfig.l10n.tsFontFamily,
        child: EzDropdownMenu<String>(
          widthEntries: <String>[fingerPaint],
          textStyle: widget.bodyProvider.value,
          dropdownMenuEntries: googleStyles.entries
              .map((MapEntry<String, TextStyle> entry) =>
                  DropdownMenuEntry<String>(
                    value: entry.key,
                    label: ezCamelToTitle(entry.key),
                    style: TextButton.styleFrom(textStyle: entry.value),
                  ))
              .toList(),
          enableSearch: false,
          initialSelection: currFontFamily,
          onSelected: (String? fontFamily) async {
            if (fontFamily == null) return;

            if (!isUniform) {
              isUniform = true;
            }
            currFontFamily = fontFamily;

            final Map<String, String?> currFonts = widget.updateBoth
                ? <String, String?>{...darkFonts, ...lightFonts}
                : (EzConfig.isDark ? darkFonts : lightFonts);

            for (final String key in currFonts.keys) {
              await EzConfig.setString(key, fontFamily);
            }
            widget.displayProvider.fuse(fontFamily);
            widget.headlineProvider.fuse(fontFamily);
            widget.titleProvider.fuse(fontFamily);
            widget.bodyProvider.fuse(fontFamily);
            widget.labelProvider.fuse(fontFamily);

            EzConfig.pingRebuild(EzConfig.styles.displayLarge?.fontFamily !=
                    widget.displayProvider.value.fontFamily ||
                EzConfig.styles.headlineLarge?.fontFamily !=
                    widget.headlineProvider.value.fontFamily ||
                EzConfig.styles.titleLarge?.fontFamily !=
                    widget.titleProvider.value.fontFamily ||
                EzConfig.styles.bodyLarge?.fontFamily !=
                    widget.bodyProvider.value.fontFamily ||
                EzConfig.styles.labelLarge?.fontFamily !=
                    widget.labelProvider.value.fontFamily);
            setState(() {});
          },
        ),
      );
}
