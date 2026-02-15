/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Remind the user that reset/randomize/etc cannot be undone automatically
/// Includes and [EzInlineLink] to save current config to JSON
Widget ezRichUndoWarning(
  BuildContext context, {
  bool standalone = true,
  required String appName,
  String? androidPackage,
  Set<String>? skip,
}) {
  final EzRichText text = EzRichText(
    <InlineSpan>[
      // Cannot be undone
      EzPlainText(
        text: EzConfig.l10n.gUndoWarn1,
        style: EzConfig.styles.bodyLarge,
      ),

      // Save link
      EzInlineLink(
        EzConfig.l10n.gSave,
        onTap: () => EzConfig.saveConfig(
          context,
          appName: appName,
          androidPackage: androidPackage,
          skip: skip,
        ),
        hint: EzConfig.l10n.gSaveHint,
        style: EzConfig.styles.bodyLarge,
        textAlign: TextAlign.center,
      ),

      // Can restore manually
      EzPlainText(
        text: EzConfig.l10n.gUndoWarn2,
        style: EzConfig.styles.bodyLarge,
      ),
    ],
    textBackground: false,
    style: EzConfig.styles.bodyLarge,
    textAlign: TextAlign.center,
  );

  return standalone
      ? SizedBox(
          width: ezTextSize(
            EzConfig.l10n.gSave + EzConfig.l10n.gUndoWarn2,
            context: context,
            style: EzConfig.styles.bodyLarge,
          ).width,
          child: text,
        )
      : text;
}
