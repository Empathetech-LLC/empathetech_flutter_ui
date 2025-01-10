/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzFontFamilyBatchSetting extends StatefulWidget {
  const EzFontFamilyBatchSetting({super.key});

  @override
  State<EzFontFamilyBatchSetting> createState() =>
      _FontFamilyBatchSettingState();
}

class _FontFamilyBatchSettingState extends State<EzFontFamilyBatchSetting> {
  // Gather the theme data //

  late final ThemeData theme = Theme.of(context);
  late final EFUILang l10n = EFUILang.of(context)!;

  final double padding = EzConfig.get(paddingKey);

  late final DisplayTextStyleProvider displayProvider =
      context.watch<DisplayTextStyleProvider>();
  late final HeadlineTextStyleProvider headlineProvider =
      context.watch<HeadlineTextStyleProvider>();
  late final TitleTextStyleProvider titleProvider =
      context.watch<TitleTextStyleProvider>();
  late final BodyTextStyleProvider bodyProvider =
      context.watch<BodyTextStyleProvider>();
  late final LabelTextStyleProvider labelProvider =
      context.watch<LabelTextStyleProvider>();

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

  late String? currFontFamily = isUniform ? currFonts.values.first : null;

  // Define button functions //

  /// Builds an [EzAlertDialog] with [googleStyles] mapped to a list of [DropdownMenuEntry]s
  late final List<DropdownMenuEntry<String>> entries =
      googleStyles.entries.map((MapEntry<String, TextStyle> entry) {
    return DropdownMenuEntry<String>(
      value: entry.key,
      label: googleStyleNames[entry.key]!,
      style: TextButton.styleFrom(
        textStyle: entry.value,
        padding: EzInsets.wrap(padding),
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

        late final List<Widget> materialActions;
        late final List<Widget> cupertinoActions;

        (materialActions, cupertinoActions) = ezActionPairs(
          context: context,
          onConfirm: onConfirm,
          confirmIsDestructive: true,
          onDeny: onDeny,
        );

        return EzAlertDialog(
          title: Text(
            l10n.gAttention,
            textAlign: TextAlign.center,
          ),
          content: Text(
            l10n.tsBatchOverride(l10n.tsFontFamily),
            textAlign: TextAlign.center,
          ),
          materialActions: materialActions,
          cupertinoActions: cupertinoActions,
          needsClose: false,
        );
      },
    );
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: l10n.tsFontFamily,
      child: DropdownMenu<String>(
        width: dropdownWidth(context: context, entries: <String>[fingerPaint]),
        textStyle: bodyProvider.value,
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

          displayProvider.fuse(fontFamily);
          headlineProvider.fuse(fontFamily);
          titleProvider.fuse(fontFamily);
          bodyProvider.fuse(fontFamily);
          labelProvider.fuse(fontFamily);

          setState(() {});
        },
      ),
    );
  }
}
