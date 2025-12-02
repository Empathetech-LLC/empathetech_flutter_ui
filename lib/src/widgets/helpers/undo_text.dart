/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Remind the user that reset/randomize/etc cannot be undone automatically
/// Includes and [EzInlineLink] to save current config to JSON
EzRichText ezRichUndoWarning(
  BuildContext context, {
  List<String>? extraKeys,
  required String appName,
  String? androidPackage,
}) {
  final EFUILang l10n = ezL10n(context);
  final TextTheme textTheme = Theme.of(context).textTheme;

  return EzRichText(
    <InlineSpan>[
      EzPlainText(
        text: l10n.gUndoWarn1,
        style: textTheme.bodyLarge,
      ),
      EzInlineLink(
        l10n.gSave,
        onTap: () => ezConfigSaver(
          context,
          extraKeys: extraKeys,
          appName: appName,
          androidPackage: androidPackage,
        ),
        hint:
            '', // TODO: Add a hint? Make this nullable? If yes (to nullable), audit others.
        style: textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      EzPlainText(
        text: l10n.gUndoWarn2,
        style: textTheme.bodyLarge,
      ),
    ],
    textBackground: false,
    style: textTheme.bodyLarge,
    textAlign: TextAlign.center,
  );
}
