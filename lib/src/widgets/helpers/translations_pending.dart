/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzTranslationsPendingNotice extends StatelessWidget {
  /// Defaults to [EFUILang.gTranslationsPending]
  final String? message;

  /// Defaults to [TextTheme.labelLarge]
  final TextStyle? style;

  final TextAlign textAlign;

  /// Won't appear for this locale
  final Locale defaultLocale;

  /// Spacing widget to place below the message
  final Widget footer;

  /// Caw
  const EzTranslationsPendingNotice({
    super.key,
    this.message,
    this.style,
    this.textAlign = TextAlign.center,
    this.defaultLocale = english,
    this.footer = const EzSeparator(),
  });

  @override
  Widget build(BuildContext context) {
    // Gather theme data //

    final Locale currLocale = EzConfig.getLocale() ?? defaultLocale;

    return (currLocale == defaultLocale)
        ? const SizedBox.shrink()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                message ?? EFUILang.of(context)!.gTranslationsPending,
                style: style ?? Theme.of(context).textTheme.labelLarge,
                textAlign: textAlign,
              ),
              footer,
            ],
          );
  }
}
