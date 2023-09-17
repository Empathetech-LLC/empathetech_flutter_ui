/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

part of empathetech_flutter_ui;

class EzLink extends TextSpan {
  /// Creates a [TextSpan] with an internal link via [TapGestureRecognizer]
  /// See [EzWebLink] for making extertnal links
  ///
  /// Requires [semanticsLabel] to enforce accessibility
  EzLink({
    required String text,
    required Function()? action,
    TextStyle? style,
    required String semanticsLabel,
  }) : super(
          text: text,
          recognizer: new TapGestureRecognizer()..onTap = action,
          style: style,
          semanticsLabel: semanticsLabel,
        );
}
