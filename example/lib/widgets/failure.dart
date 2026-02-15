/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class FailureHeader extends StatelessWidget {
  /// Core [Text] to display... under 'Failure'
  /// Provide [message] OR [richMessage]
  final String? message;

  /// Core [Text.rich] to display... under 'Failure'
  /// Provide [message] OR [richMessage]
  final EzRichText? richMessage;

  /// header [Widget] for a failed run
  const FailureHeader({
    super.key,
    this.message,
    this.richMessage,
  }) : assert(
          (message == null) != (richMessage == null),
          'Either message or richMessage must be provided, not both',
        );

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Headline
          Flexible(
            child: EzText(
              EzConfig.l10n.gFailure,
              style: EzConfig.styles.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
          EzConfig.spacer,

          // Error message
          message != null
              ? Flexible(
                  child: EzText(
                    message!,
                    style: ezSubTitleStyle(),
                    textAlign: TextAlign.center,
                  ),
                )
              : richMessage!,
        ],
      );
}

class DeleteOption extends StatelessWidget {
  /// Directory that will be rm -rf'd
  final String appName;

  /// Directory to run the rm command in
  final String dir;

  /// [TextStyle] for 'would you like to...'
  final TextStyle? style;

  /// Optional [ezCmd] readout passthrough
  final ValueNotifier<String>? readout;

  /// Iterable [Widget] containing a [EzElevatedIconButton] for wiping the partial build
  const DeleteOption({
    super.key,
    required this.appName,
    required this.dir,
    required this.style,
    this.readout,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Would you like to...
          EzText(
            l10n.rsWouldYou,
            style: style,
            textAlign: TextAlign.center,
          ),
          EzConfig.spacer,

          // Wipe it
          EzElevatedIconButton(
            onPressed: () => ezCmd(
              EzConfig.platform == TargetPlatform.windows
                  ? 'rmdir /s /q $appName'
                  : 'rm -rf $appName',
              dir: dir,
              onSuccess: () async {
                await ezSnackBar(
                  context: context,
                  message: l10n.rsNextTime,
                ).closed;

                if (context.mounted) Navigator.of(context).maybePop();
              },
              onFailure: (String message) async {
                await ezSnackBar(
                  context: context,
                  message: l10n.rsAnotherOne,
                ).closed;

                if (context.mounted) Navigator.of(context).maybePop();
              },
              readout: readout,
            ),
            icon: const Icon(Icons.delete),
            label: l10n.rsWipe,
          ),
          EzConfig.spacer,

          // Leave
          EzElevatedIconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            label: l10n.rsLeave,
          ),
        ],
      );
}

class LinkOption extends StatelessWidget {
  /// [TextStyle] for 'would you like to...'
  final TextStyle? style;

  /// Iterable [Widget] containing a [EzElevatedIconButton] for wiping the partial build
  const LinkOption(this.style, {super.key});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          EzText(l10n.rsWouldYou, style: style, textAlign: TextAlign.center),
          EzConfig.spacer,
          EzElevatedIconLink(
            url: Uri.parse(installFlutter),
            tooltip: installFlutter,
            hint: l10n.rsInstallHint,
            icon: const Icon(Icons.computer),
            label: l10n.rsInstall,
          ),
        ],
      );
}
