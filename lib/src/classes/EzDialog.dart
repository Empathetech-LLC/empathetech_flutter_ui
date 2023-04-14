library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzDialog extends PlatformAlertDialog {
  final Key? key;
  final Key? widgetKey;
  final List<Widget>? actions;
  final Widget? content;
  final List<Widget> contents;
  final Widget? title;
  final MaterialAlertDialogData Function(BuildContext, PlatformTarget)? material;
  final CupertinoAlertDialogData Function(BuildContext, PlatformTarget)? cupertino;

  /// Default:
  /// false
  final bool needsClose;

  /// Styles a [PlatformAlertDialog] with [EzConfig]
  /// Uses a [contents] list rather than [content] Widget
  /// Optionally overwrite with -> content: content && contents: []
  /// Optionally overwrite any original parameters
  /// Optionally remove the "Close" action on iOS with [needsClose]
  EzDialog({
    this.key,
    this.widgetKey,
    this.actions,
    this.content,
    required this.contents,
    this.title,
    this.cupertino,
    this.material,
    this.needsClose = true,
  });

  @override
  Widget build(BuildContext context) {
    double dialogSpacer = EzConfig.prefs[dialogSpacingKey];
    double padding = EzConfig.prefs[paddingKey];

    return PlatformAlertDialog(
      // Material (Android)
      material: (context, platform) => MaterialAlertDialogData(
        insetPadding: EdgeInsets.all(padding),

        // Title
        title: title,
        titlePadding: EdgeInsets.only(top: dialogSpacer, left: padding, right: padding),

        // Content
        content: content ?? EzScrollView(children: contents),
        contentPadding: EdgeInsets.symmetric(vertical: dialogSpacer, horizontal: padding),
      ),

      // Cupertino (iOS)
      cupertino: (context, platform) => CupertinoAlertDialogData(
        // Title
        title: title,

        // Content
        content: content ??
            EzScrollView(
                children:
                    (needsClose) ? contents : [...contents, Container(height: padding)]),
        actions: (needsClose)
            ? [
                GestureDetector(
                  onTap: () => popScreen(context: context),
                  child: Text(
                    'Close',
                    style: buildTextStyle(style: dialogContentStyleKey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}
