/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';

/// Remind the user that reset/randomize/etc cannot be undone automatically
/// Includes and [EzInlineLink] to save current config to JSON
EzRichText ezRichUndoWarning({
  required BuildContext context,
  required List<String>? extraKeys,
  required String appName,
  required String androidPackage,
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
        onTap: () async {
          final List<String> keys = <String>[
            ...ezConfigKeys.keys,
            if (extraKeys != null) ...extraKeys,
          ];

          final Map<String, dynamic> config =
              Map<String, dynamic>.fromEntries(keys.map(
            (String key) => MapEntry<String, dynamic>(
              key,
              EzConfig.get(key),
            ),
          ));

          try {
            await FileSaver.instance.saveFile(
              name: '${ezTitleToSnake(appName)}_settings.json',
              bytes: utf8.encode(jsonEncode(config)),
              mimeType: MimeType.json,
            );
          } catch (e) {
            if (context.mounted) {
              ezLogAlert(context, message: e.toString());
            }
            return;
          }

          if (context.mounted) {
            ezSnackBar(
              context: context,
              message: l10n.ssConfigSaved(archivePath(
                appName: appName,
                androidPackage: androidPackage,
              )),
            );
          }
        },
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
