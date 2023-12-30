/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzInlineLink extends WidgetSpan {
  final String text;

  final Key? key;
  final TextStyle? style;
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

  final MaterialStatesController? statesController;

  /// [WidgetSpan] wrapper with an [EzLink] for a [WidgetSpan.child]
  /// Seems to prefer Strings of length 5+
  /// Smaller strings can sometimes have issues with text spacing
  EzInlineLink(
    this.text, {
    this.textFix,
    this.key,
    this.style,
    this.color,
    this.textAlign,
    this.onTap,
    this.url,
    required this.semanticsLabel,
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
            semanticsLabel: "${textFix ?? text}; $semanticsLabel",
            tooltip: tooltip ?? semanticsLabel,
            statesController: statesController,
          ),
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          style: style,
        );
}
