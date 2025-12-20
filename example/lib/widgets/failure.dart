/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class FailureHeader extends StatelessWidget {
  /// [ThemeData.textTheme] passthrough
  final TextTheme textTheme;

  /// Core [Text] to display... under 'Failure'
  /// Provide [message] OR [richMessage]
  final String? message;

  /// Core [Text.rich] to display... under 'Failure'
  /// Provide [message] OR [richMessage]
  final EzRichText? richMessage;

  /// header [Widget] for a failed run
  const FailureHeader({
    super.key,
    required this.textTheme,
    this.message,
    this.richMessage,
  }) : assert((message == null) != (richMessage == null),
            'Either message or richMessage must be provided, not both');

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Headline
          Flexible(
            child: EzText(
              ezL10n(context).gFailure,
              style: textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
          EzConfig.spacer,

          // Error message
          message != null
              ? Flexible(
                  child: EzText(
                    message!,
                    style: ezSubTitleStyle(textTheme),
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

  /// Current [TargetPlatform]
  final TargetPlatform platform;

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
    required this.platform,
    required this.dir,
    required this.style,
    this.readout,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          EzText(
            Lang.of(context)!.rsWouldYou,
            style: style,
            textAlign: TextAlign.center,
          ),
          EzConfig.spacer,
          EzElevatedIconButton(
            onPressed: () => ezCmd(
              platform == TargetPlatform.windows
                  ? 'rmdir /s /q $appName'
                  : 'rm -rf $appName',
              dir: dir,
              onSuccess: () async {
                await ezSnackBar(
                  context: context,
                  message: Lang.of(context)!.rsNextTime,
                ).closed;

                if (context.mounted) Navigator.of(context).maybePop();
              },
              onFailure: (String message) async {
                await ezSnackBar(
                  context: context,
                  message: Lang.of(context)!.rsAnotherOne,
                ).closed;

                if (context.mounted) Navigator.of(context).maybePop();
              },
              readout: readout,
            ),
            icon: EzIcon(PlatformIcons(context).delete),
            label: Lang.of(context)!.rsWipe,
          ),
          EzConfig.spacer,
          EzElevatedIconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: EzIcon(PlatformIcons(context).back),
            label: Lang.of(context)!.rsLeave,
          ),
        ],
      );
}

/// https://docs.flutter.dev/get-started/install
const String installFlutter = 'https://docs.flutter.dev/get-started/install';

class LinkOption extends StatelessWidget {
  /// [TextStyle] for 'would you like to...'
  final TextStyle? style;

  /// Iterable [Widget] containing a [EzElevatedIconButton] for wiping the partial build
  const LinkOption(this.style, {super.key});

  @override
  Widget build(BuildContext context) {
    final Lang l10n = Lang.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        EzText(
          l10n.rsWouldYou,
          style: style,
          textAlign: TextAlign.center,
        ),
        EzConfig.spacer,
        EzElevatedIconLink(
          url: Uri.parse(installFlutter),
          tooltip: installFlutter,
          hint: l10n.rsInstallHint,
          icon: EzIcon(Icons.computer),
          label: l10n.rsInstall,
        ),
      ],
    );
  }
}
