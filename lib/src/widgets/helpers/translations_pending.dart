/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTranslationsPendingNotice extends StatelessWidget {
  /// Defaults to [EFUILang.gMachineTranslated]
  final String? message;

  /// Defaults to [TextTheme.labelLarge]
  final TextStyle? style;

  /// Shout-out: [TextAlign.start] >> [TextAlign.left] || [TextAlign.right]
  final TextAlign textAlign;

  /// Won't appear for this locale
  final Locale defaultLocale;

  /// Spacing widget to place above the message
  final Widget header;

  /// Spacing widget to place below the message
  final Widget footer;

  /// Include in pages with translated material that still requires human review
  const EzTranslationsPendingNotice({
    super.key,
    this.message,
    this.style,
    this.textAlign = TextAlign.center,
    this.defaultLocale = english,
    this.header = const SizedBox.shrink(),
    this.footer = const EzSeparator(),
  });

  @override
  Widget build(BuildContext context) => (EzConfig.locale == defaultLocale)
      ? const SizedBox.shrink()
      : Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            header,
            Text(
              message ?? EzConfig.l10n.gMachineTranslated,
              style: style ?? Theme.of(context).textTheme.labelLarge,
              textAlign: textAlign,
            ),
            footer,
          ],
        );
}
