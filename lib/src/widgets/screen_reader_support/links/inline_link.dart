/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzInlineLink extends WidgetSpan {
  /// [EzLink.text] passthrough
  final String text;

  /// [EzLink.key] passthrough
  final Key? key;

  /// [EzLink.textColor] passthrough
  final Color? textColor;

  /// [EzLink.decorationColor] passthrough
  final Color? decorationColor;

  /// Defaults to [Colors.transparent]
  final Color backgroundColor;

  /// [EzLink.textAlign] passthrough
  final TextAlign? textAlign;

  /// [EzLink.onTap] passthrough
  final void Function()? onTap;

  /// [EzLink.url] passthrough
  final Uri? url;

  /// [EzLink.hint] passthrough
  /// Don't repeat [text] here, it is appended automatically
  final String hint;

  /// [EzLink.tooltip] passthrough
  final String? tooltip;

  /// Message for screen readers when the parent [EzRichText] is focused
  final String? richLabel;

  /// [WidgetSpan] extension with an [EzLink] for a child
  /// The [EzLink] has zero padding and custom [Semantics] for [EzRichText]; [richLabel]
  EzInlineLink(
    // EzLink
    this.text, {
    this.key,
    super.style,
    this.textColor,
    this.decorationColor,
    this.backgroundColor = Colors.transparent,
    this.textAlign,
    this.onTap,
    this.url,
    required this.hint,
    this.tooltip,
    this.richLabel, // Not used here, but in EzRichText
    super.alignment = PlaceholderAlignment.middle,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super(
          child: EzLink(
            text,
            key: key,
            style: style,
            textColor: textColor,
            decorationColor: decorationColor,
            backgroundColor: backgroundColor,
            textAlign: textAlign,
            padding: EdgeInsets.zero,
            onTap: onTap,
            url: url,
            hint: hint,
            tooltip: tooltip,
          ),
        );
}
