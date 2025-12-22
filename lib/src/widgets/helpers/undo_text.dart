/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Remind the user that reset/randomize/etc cannot be undone automatically
/// Includes and [EzInlineLink] to save current config to JSON
Widget ezRichUndoWarning(
  BuildContext context, {
  bool standalone = true,
  List<String>? extraKeys,
  required String appName,
  String? androidPackage,
}) {
  final TextTheme textTheme = Theme.of(context).textTheme;

  final EzRichText text = EzRichText(
    <InlineSpan>[
      EzPlainText(
        text: EzConfig.l10n.gUndoWarn1,
        style: textTheme.bodyLarge,
      ),
      EzInlineLink(
        EzConfig.l10n.gSave,
        onTap: () => ezConfigSaver(
          context,
          extraKeys: extraKeys,
          appName: appName,
          androidPackage: androidPackage,
        ),
        hint: EzConfig.l10n.gSaveHint,
        style: textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      EzPlainText(
        text: EzConfig.l10n.gUndoWarn2,
        style: textTheme.bodyLarge,
      ),
    ],
    textBackground: false,
    style: textTheme.bodyLarge,
    textAlign: TextAlign.center,
  );

  return standalone
      ? SizedBox(
          height: EzConfig.isApple
              ? (textTheme.bodyLarge?.fontSize ?? defaultBodySize) * 3
              : null,
          width: widthOf(context),
          child: text,
        )
      : text;
}
