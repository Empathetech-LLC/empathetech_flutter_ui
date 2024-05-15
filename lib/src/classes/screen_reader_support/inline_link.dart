/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzInlineLink extends WidgetSpan {
  final String text;
  final Key? key;
  final Color? color;
  final TextAlign? textAlign;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  /// Message for screen readers
  /// Don't repeat [text] here, it is appended automatically
  final String semanticsLabel;

  /// Updates [text]'s [Semantics] readout in [EzRichText]
  final String? textFix;

  /// Optional tooltip override
  final String? tooltip;

  final WidgetStatesController? statesController;

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
    this.color,
    this.textAlign,
    this.onTap,
    this.url,
    required this.semanticsLabel,
    this.textFix, // For screen readers, handled by EzRichText
    this.tooltip,
    this.statesController,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super(
          child: EzLink(
            text,
            key: key,
            style: style,
            color: color,
            textAlign: textAlign,
            onTap: onTap,
            url: url,
            semanticsLabel: semanticsLabel,
            tooltip: tooltip,
            statesController: statesController,
          ),
        );
}
