/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLink extends StatefulWidget {
  /// Link message
  final String text;

  final TextStyle style;

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

  /// On hover/focus hint
  /// Defaults to [semanticsLabel] (or [text])
  final String? tooltip;

  final WidgetStatesController? statesController;

  /// [TextButton] wrapper that acts like [Text] and either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// [semanticsLabel]; is required
  /// Always has a tool [tooltip]. If one is not provided, it will default to [semanticsLabel]
  /// Automatically colors [text] with [ColorScheme.primary] and adds an [TextDecoration.underline] on hover/focus
  /// The [color] can optionally be overwritten
  const EzLink(
    this.text, {
    super.key,
    required this.style,
    this.icon,
    this.color,
    this.textAlign,
    this.onTap,
    this.url,
    required this.semanticsLabel,
    this.tooltip,
    this.statesController,
  }) : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.');

  @override
  State<EzLink> createState() => _EzLinkState();
}

class _EzLinkState extends State<EzLink> {
  // Define theme updates //

  late final Color textColor =
      widget.color ?? Theme.of(context).colorScheme.primary;

  late TextStyle textStyle = widget.style.copyWith(
    color: textColor,
    decoration: TextDecoration.none,
    decorationColor: textColor,
  );

  // Define custom functions //

  void addUnderline(bool addIt) {
    textStyle = textStyle.copyWith(
      decoration: addIt ? TextDecoration.underline : TextDecoration.none,
    );
    setState(() {});
  }

  // Define build options //

  late final Widget textButton = TextButton(
    onPressed: widget.onTap ?? () => launchUrl(widget.url!),
    onLongPress: null,
    onHover: (bool isHovering) => addUnderline(isHovering),
    onFocusChange: (bool hasFocus) => addUnderline(hasFocus),
    child: Text(
      widget.text,
      style: textStyle,
      textAlign: widget.textAlign,
    ),
  );

  late final Widget iconTextButton = TextButton.icon(
    onPressed: widget.onTap ?? () => launchUrl(widget.url!),
    onLongPress: null,
    onHover: (bool isHovering) => addUnderline(isHovering),
    onFocusChange: (bool hasFocus) => addUnderline(hasFocus),
    icon: widget.icon,
    label: Text(
      widget.text,
      style: textStyle,
      textAlign: widget.textAlign,
    ),
  );

  // Return the build //

  @override
  Widget build(BuildContext context) {
    final String semantics = '${widget.text}; ${widget.semanticsLabel}';

    return Tooltip(
      message: widget.tooltip ?? widget.semanticsLabel,
      excludeFromSemantics: true,
      child: Semantics(
        link: true,
        hint: semantics,
        child: ExcludeSemantics(
          child: (widget.icon == null) ? textButton : iconTextButton,
        ),
      ),
    );
  }
}
