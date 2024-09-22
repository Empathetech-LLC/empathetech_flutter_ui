/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzInlineLink extends WidgetSpan {
  /// Link message
  final String text;

  final Key? key;

  // super.style;

  /// Optional icon [Widget]
  /// Will make the [TextButton] wrapper a [TextButton.icon] wrapper
  final Widget? icon;

  /// Optional [Color] to overwrite the default [ColorScheme.primary]
  final Color? color;

  final TextAlign? textAlign;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  /// Message for screen readers
  /// Don't repeat [text] here, it is appended automatically
  final String semanticsLabel;

  /// Message for screen readers when the parent [EzRichText] is focused
  final String? richSemanticsLabel;

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
    required super.style,

    // EzLink
    this.key,
    this.icon,
    this.color,
    this.textAlign,
    this.onTap,
    this.url,
    required this.semanticsLabel,
    this.richSemanticsLabel, // Not used here, but in EzRichText
    this.tooltip,
    this.statesController,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        assert(style != null,
            "Style cannot be null. It claims it can be because we're using the super constructor; apologies for any confusion."),
        super(
          child: EzLink(
            text,
            key: key,
            style: style!,
            icon: icon,
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
