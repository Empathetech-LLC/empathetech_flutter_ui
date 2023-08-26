/// empathetech_flutter_ui
/// Copyright (c) 2023 Empathetech LLC. All rights reserved.
/// See LICENSE for distribution and usage details.
library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzDialog extends PlatformAlertDialog {
  final Key? key;
  final Key? widgetKey;
  final List<Widget>? actions;
  final Widget? content;

  /// Used in an [EzScrollView]
  final List<Widget>? contents;

  final Widget? title;
  final MaterialAlertDialogData Function(BuildContext, PlatformTarget)?
      material;
  final CupertinoAlertDialogData Function(BuildContext, PlatformTarget)?
      cupertino;
  final bool needsClose;

  /// Styles a [PlatformAlertDialog] with [EzConfig]
  /// Adds an optional [contents] parameter to provide instead of the traditional [content]
  /// If provided, [contents] will be used in an [EzScrollView]
  /// Only one option can be provided
  /// Optionally remove the "Close" action on iOS via [needsClose]
  EzDialog({
    this.key,
    this.widgetKey,
    this.actions,
    this.content,
    this.contents,
    this.title,
    this.cupertino,
    this.material,
    this.needsClose = true,
  }) : assert(content == null || contents == null,
            'Either content or contents must be provided, not both.');

  @override
  Widget build(BuildContext context) {
    final double padding = EzConfig.instance.prefs[paddingKey];

    return PlatformAlertDialog(
      // Material (Android)
      material: (context, platform) => MaterialAlertDialogData(
        insetPadding: EdgeInsets.all(padding),

        // Title
        title: title,

        titlePadding: EdgeInsets.only(
          top: padding,
          left: padding,
          right: padding,
        ),

        // Content
        content: content ?? EzScrollView(children: contents!),

        contentPadding: EdgeInsets.symmetric(
          vertical: padding,
          horizontal: padding,
        ),
      ),

      // Cupertino (iOS)
      cupertino: (context, platform) => CupertinoAlertDialogData(
        // Title
        title: title,

        // Content
        content: content ??
            EzScrollView(
              children:
                  (needsClose) ? contents! : [...contents!, EzSpacer(padding)],
            ),

        // Actions (2 close || ! 2 close)
        actions: (needsClose)
            ? [
                GestureDetector(
                  onTap: () => popScreen(context: context),
                  child: Text('Close'),
                ),
              ]
            : [],
      ),
    );
  }
}
