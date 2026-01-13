/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class EzMenuLink extends StatelessWidget {
  /// [Link.uri] to open
  final Uri uri;

  /// [EzMenuButton.requestFocusOnHover] passthrough
  final bool requestFocusOnHover;

  /// [EzMenuButton.onHover] passthrough
  final void Function(bool)? onHover;

  /// [EzMenuButton.onFocusChange] passthrough
  final void Function(bool)? onFocusChange;

  /// [EzMenuButton.underline] passthrough
  final bool underline;

  /// [EzMenuButton.decorationColor] passthrough
  final Color? decorationColor;

  /// [EzMenuButton.focusNode] passthrough
  final FocusNode? focusNode;

  /// [EzMenuButton.autofocus] passthrough
  final bool autofocus;

  /// [EzMenuButton.shortcut] passthrough
  final MenuSerializableShortcut? shortcut;

  /// [EzMenuButton.semanticsLabel] passthrough
  final String? semanticsLabel;

  /// [EzMenuButton.style] passthrough
  final ButtonStyle? style;

  /// [EzMenuButton.statesController] passthrough
  final WidgetStatesController? statesController;

  /// [EzMenuButton.clipBehavior] passthrough
  final Clip clipBehavior;

  /// [EzMenuButton.icon] passthrough
  final Widget? icon;

  /// [EzMenuButton.closeOnActivate] passthrough
  final bool closeOnActivate;

  /// [EzMenuButton.overflowAxis] passthrough
  final Axis overflowAxis;

  /// [EzMenuButton.label] passthrough
  final String label;

  /// [EzMenuButton.textStyle] passthrough
  final TextStyle? textStyle;

  /// [EzMenuButton.textAlign] passthrough
  final TextAlign? textAlign;

  /// [EzMenuButton] wrapped in a [Link]
  const EzMenuLink({
    super.key,
    required this.uri,
    this.requestFocusOnHover = true,
    this.onHover,
    this.onFocusChange,
    this.underline = false,
    this.decorationColor,
    this.focusNode,
    this.autofocus = false,
    this.shortcut,
    this.semanticsLabel,
    this.style,
    this.statesController,
    this.clipBehavior = Clip.none,
    this.icon,
    this.closeOnActivate = true,
    this.overflowAxis = Axis.horizontal,
    required this.label,
    this.textStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) => Link(
        uri: uri,
        builder: (_, FollowLink? followLink) => EzMenuButton(
          onPressed: () => launchUrl(uri),
          requestFocusOnHover: requestFocusOnHover,
          onHover: onHover,
          onFocusChange: onFocusChange,
          underline: underline,
          decorationColor: decorationColor,
          focusNode: focusNode,
          autofocus: autofocus,
          shortcut: shortcut,
          semanticsLabel: semanticsLabel,
          style: style,
          statesController: statesController,
          clipBehavior: clipBehavior,
          icon: icon,
          closeOnActivate: closeOnActivate,
          overflowAxis: overflowAxis,
          label: label,
          textStyle: textStyle,
          textAlign: textAlign,
        ),
      );
}

// Idk why, but it seems followLink doesn't work for EzMenuButtons... maybe something to do with focus/the anchor closing?
// Any who, launchUrl works and the Link wrapper means we still get the proper context menu
