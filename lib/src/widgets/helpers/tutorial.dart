/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class EzTutorial extends StatelessWidget {
  /// [Positioned.top] passthrough
  final double? top;

  /// [Positioned.bottom] passthrough
  final double? bottom;

  /// [Positioned.left] passthrough
  final double? left;

  /// [Positioned.right] passthrough
  final double? right;

  /// Value for the [AlertDialog]'s [Text] title
  final String title;

  /// Value for the [AlertDialog]'s [Text] content
  final String content;

  /// [EzMaterialAction.text] passthrough
  final String acceptMessage;

  /// [EzMaterialAction.onPressed] passthrough
  final void Function() onAccept;

  /// [AlertDialog] wrapped in a [SelectionArea] and [Positioned] widget
  /// Pairs well with [OverlayPortal] for displaying tutorials
  const EzTutorial(
      {super.key,
      this.top,
      this.bottom,
      this.left,
      this.right,
      required this.title,
      required this.content,
      required this.acceptMessage,
      required this.onAccept});

  @override
  Widget build(BuildContext context) {
    // Gather theme data //

    final double margin = EzConfig.get(marginKey);
    final double padding = EzConfig.get(paddingKey);
    final double spacing = EzConfig.get(spacingKey);

    final bool isLefty = EzConfig.get(isLeftyKey) ?? false;

    // Return the build //

    final List<Widget> actions = <Widget>[
      EzMaterialAction(text: acceptMessage, onPressed: onAccept)
    ];

    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: SelectionArea(
        child: AlertDialog(
          // Title
          title: Text(title, textAlign: TextAlign.center),
          titlePadding: EdgeInsets.only(
            left: padding,
            right: padding,
            top: padding,
            bottom: spacing / 2,
          ),

          // Content
          content: Text(content, textAlign: TextAlign.center),
          contentPadding: EdgeInsets.symmetric(
            horizontal: margin,
            vertical: spacing / 2,
          ),

          // Actions
          actions: isLefty ? actions.reversed.toList() : actions,
          actionsAlignment:
              isLefty ? MainAxisAlignment.start : MainAxisAlignment.end,

          // General
          actionsPadding: EzInsets.wrap(spacing),
          buttonPadding: EdgeInsets.zero,
          iconPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.all(margin),
        ),
      ),
    );
  }
}
