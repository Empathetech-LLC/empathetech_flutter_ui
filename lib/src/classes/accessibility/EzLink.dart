import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EzLink extends StatelessWidget {
  final Key? key;

  /// Link message
  final String text;

  final TextStyle? style;
  final TextAlign? textAlign;
  final ButtonStyle? buttonStyle;

  /// Destination function
  final void Function()? onTap;

  /// Destination URL
  final Uri? url;

  final void Function()? onLongPress;

  /// Message for screen readers
  final String semanticsLabel;

  final void Function(bool)? onHover;
  final void Function(bool)? onFocusChange;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final MaterialStatesController? statesController;

  /// [TextButton] wrapper that acts like [Text] and either opens an internal link via [onTap]
  /// Or an external link to [url]
  /// Requires [semanticsLabel] for screen readers
  EzLink(
    this.text, {
    this.key,
    this.style,
    this.textAlign,
    this.buttonStyle,
    this.onTap,
    this.url,
    this.onLongPress,
    required this.semanticsLabel,
    this.onHover,
    this.onFocusChange,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
  })  : assert((onTap == null) != (url == null),
            'Either onTap or url should be provided, but not both.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      hint: semanticsLabel,
      child: ExcludeSemantics(
        child: TextButton(
          onPressed: onTap ?? () => launchUrl(url!),
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: buttonStyle,
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          statesController: statesController,
          isSemanticButton: true,
          child: Text(text, style: style, textAlign: textAlign),
        ),
      ),
    );
  }
}
