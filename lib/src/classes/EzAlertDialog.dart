/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';
import '../../l10n/app_localizations.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzAlertDialog extends PlatformAlertDialog {
  final Key? key;
  final Key? widgetKey;

  /// Dialog's title
  final Widget? title;

  /// Dialog's main content
  /// Replaces [PlatformAlertDialog.content] with an [EzScrollView] as [contents] for the [EzScrollView.children]
  final List<Widget>? contents;

  /// Material "action" [Widget]s to be displayed below [contents]
  /// Will be appended to [contents] in the Material world
  /// Prevents redundancy in the Cupertino world
  /// Pairs best with [ezMaterialActions]
  final List<Widget>? materialActions;

  /// [CupertinoDialogAction]s to be displayed below [contents]
  /// Directly used for [CupertinoAlertDialogData.actions]
  /// Pairs best with [ezCupertinoActions]
  final List<CupertinoDialogAction>? cupertinoActions;

  /// Cupertino alerts aren't dismissable by tapping outside the renderbox
  /// Set [needsClose] to true if a default "Close" [CupertinoDialogAction] is needed
  final bool needsClose;

  /// [PlatformAlertDialog] wrapper that automatically styles Material and Cupertino dialogs
  /// Replaced the original [content] parameter with [contents]
  /// [contents] will be displayed in an [EzScrollView]
  /// [materialActions] are appended to [contents] in the Material world
  /// [cupertinoActions] are directly used for [CupertinoAlertDialogData.actions]
  /// The split prevents redundancy for users
  EzAlertDialog({
    this.key,
    this.widgetKey,
    required this.title,
    required this.contents,
    this.materialActions,
    this.cupertinoActions,
    this.needsClose = true,
  });

  @override
  Widget build(BuildContext context) {
    final double padding = EzConfig.instance.prefs[paddingKey];

    CupertinoDialogAction _closeAction = CupertinoDialogAction(
      onPressed: () => popScreen(context: context),
      child: Text(AppLocalizations.of(context)!.close),
    );

    return PlatformAlertDialog(
      key: key,
      widgetKey: widgetKey,
      material: (context, platform) => MaterialAlertDialogData(
        insetPadding: EdgeInsets.all(padding),

        // Title
        title: title,

        // Bottom titlePadding comes from vertical contentPadding
        titlePadding: EdgeInsets.only(top: padding, left: padding, right: padding),

        // Content
        content: materialActions == null
            ? EzScrollView(children: contents)
            : EzScrollView(children: [
                ...contents!,
                EzSpacer(padding),
                ...materialActions!,
              ]),

        contentPadding: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
      ),
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
