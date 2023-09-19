/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAlertDialog extends PlatformAlertDialog {
  final Key? key;
  final Key? widgetKey;

  /// Dialog's title
  final Widget? title;

  /// Dialog's main content
  final List<Widget>? contents;

  /// Material 'action' [Widget]s to be displayed below [contents]
  /// Will be appended to [contents] in the Material world
  /// Prevents redundancy in the Cupertino world
  /// Pairs best with [EzYesNo] for quickly creating platform native alerts
  final List<Widget>? materialActions;

  /// [CupertinoDialogAction]s to be displayed below [contents]
  /// Directly used for the [actions] param in the Cupertino world
  /// Pairs best with [EzYesNo] for quickly creating platform native alerts
  final List<CupertinoDialogAction>? cupertinoActions;

  /// Cupertino alerts aren't dismissable by tapping outside the renderbox
  /// Set [needsClose] to true if a default 'Close' [CupertinoDialogAction] is needed
  final bool needsClose;

  /// [PlatformAlertDialog] wrapper that automatically styles Material and Cupertino dialogs
  /// Replaced the original [content] parameter with [contents]
  /// [contents] will be displayed in an [EzScrollView]
  /// [materialActions] are appended to [contents] in the Material world
  /// [cupertinoActions] are directly used in the Cupertino world
  /// The split prevents redundancy for the users at render time
  EzAlertDialog({
    this.key,
    this.widgetKey,
    required this.title,
    required this.contents,
    this.materialActions,
    this.cupertinoActions,
    this.needsClose = true,
  });

  final double padding = EzConfig.instance.prefs[paddingKey];

  @override
  Widget build(BuildContext context) {
    CupertinoDialogAction _closeAction = CupertinoDialogAction(
      onPressed: () => popScreen(context: context),
      child: const Text('Close'),
    );

    return PlatformAlertDialog(
      // Material //

      material: (context, platform) => MaterialAlertDialogData(
        insetPadding: EdgeInsets.all(padding),

        // Title
        title: title,

        // Bottom titlePadding comes from vertical contentPadding
        titlePadding: EdgeInsets.only(top: padding, left: padding, right: padding),

        // Content
        content: materialActions == null
            ? EzScrollView(children: contents)
            : EzScrollView(children: [...contents!, ...materialActions!]),

        contentPadding: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
      ),

      // Cupertino //

      cupertino: (context, platform) => CupertinoAlertDialogData(
        // Title
        title: Padding(
          // No titlePadding equivalent, have to do it manually
          padding: EdgeInsets.only(bottom: padding),
          child: title,
        ),

        // Content
        content: EzScrollView(children: contents),

        // Actions
        actions: cupertinoActions == null
            ? [_closeAction]
            : (needsClose)
                ? [...cupertinoActions!, _closeAction]
                : cupertinoActions,
      ),
    );
  }
}
