/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

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

  /// Message for screen readers when the parent [EzRichText] is focused
  final String? richLabel;

  /// [EzLink.tooltip] passthrough
  final String? tooltip;

  /// [WidgetSpan] wrapper with an [EzLink] for a [WidgetSpan.child]
  /// If the link [text] is too short, spacing will be off due to the min [MaterialTapTargetSize]
  /// 6+ characters usually does the trick
  EzInlineLink(
    this.text, {
    super.alignment = PlaceholderAlignment.baseline,
    super.baseline = TextBaseline.alphabetic,
    super.style,

    // EzLink
    this.key,
    this.textColor,
    this.decorationColor,
    this.backgroundColor = Colors.transparent,
    this.textAlign,
    this.onTap,
    this.url,
    required this.hint,
    this.richLabel, // Not used here, but in EzRichText
    this.tooltip,
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
