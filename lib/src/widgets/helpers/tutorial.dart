/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
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

  /// [AlertDialog.title] passthrough
  final Widget? title;

  /// Value for the [AlertDialog]'s [Text] content
  final String content;

  /// Optional [Semantics] override for [content]
  final String? contentSemantics;

  /// [EzMaterialAction.text] passthrough
  final String acceptMessage;

  /// Optional [Semantics] override for [acceptMessage]
  final String? acceptSemantics;

  /// [EzMaterialAction.onPressed] passthrough
  final void Function() onAccept;

  /// [AlertDialog] wrapped in a [SelectionArea] and [Positioned] widget
  /// Pairs well with [OverlayPortal] for displaying tutorials
  const EzTutorial({
    super.key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.title,
    required this.content,
    this.contentSemantics,
    required this.acceptMessage,
    this.acceptSemantics,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) => Positioned(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        child: SelectionArea(
          child: AlertDialog(
            // Title
            title: title,
            titlePadding: EdgeInsets.symmetric(
              horizontal: EzConfig.marginVal,
              vertical: EzConfig.spacing / 2,
            ),

            // Content
            content: Text(
              content,
              semanticsLabel: contentSemantics,
              textAlign: TextAlign.center,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: EzConfig.marginVal,
              vertical: EzConfig.spacing / 2,
            ),

            // Actions
            actions: <Widget>[
              EzMaterialAction(
                text: acceptMessage,
                semantics: acceptSemantics,
                onPressed: onAccept,
              )
            ],
            actionsAlignment: EzConfig.isLefty
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,

            // General
            iconPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.all(EzConfig.marginVal),
            actionsPadding: EzInsets.wrap(EzConfig.spacing),
          ),
        ),
      );
}
