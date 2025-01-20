/* open_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class FailureHeader extends StatelessWidget {
  /// [ThemeData.textTheme] passthrough
  final TextTheme textTheme;

  /// Core message to display... under 'Failure'
  final String message;

  /// header [Widget] for a failed run
  const FailureHeader({
    super.key,
    required this.textTheme,
    required this.message,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Headline
          Flexible(
            child: EzText(
              Lang.of(context)!.gFailure,
              style: textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),

          // Error message
          Flexible(
            child: EzText(
              message,
              style: subTitleStyle(textTheme),
              textAlign: TextAlign.center,
            ),
          ),
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

  /// Optional [ezCLI] readout passthrough
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

  static const EzSpacer spacer = EzSpacer();

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
          spacer,
          EzElevatedIconButton(
            onPressed: () => ezCLI(
              'rm -rf $appName',
              winCMD: 'rmdir /s /q $appName',
              platform: platform,
              dir: dir,
              onSuccess: () async {
                await ezSnackBar(
                  context: context,
                  message: Lang.of(context)!.rsNextTime,
                ).closed;

                if (context.mounted) Navigator.of(context).pop();
              },
              onFailure: (String message) async {
                await ezSnackBar(
                  context: context,
                  message: Lang.of(context)!.rsAnotherOne,
                ).closed;

                if (context.mounted) Navigator.of(context).pop();
              },
              readout: readout,
            ),
            icon: EzIcon(PlatformIcons(context).delete),
            label: Lang.of(context)!.rsWipe,
          ),
          spacer,
          EzElevatedIconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: EzIcon(PlatformIcons(context).back),
            label: Lang.of(context)!.rsLeave,
          ),
        ],
      );
}

class LinkOption extends StatelessWidget {
  /// [TextStyle] for 'would you like to...'
  final TextStyle? style;

  /// Iterable [Widget] containing a [EzElevatedIconButton] for wiping the partial build
  const LinkOption(this.style, {super.key});

  static const String installFlutter =
      'https://docs.flutter.dev/get-started/install';

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
          const EzSpacer(),
          EzElevatedIconButton(
            onPressed: () => launchUrl(Uri.parse(installFlutter)),
            icon: EzIcon(Icons.computer),
            label: Lang.of(context)!.rsInstall,
          ),
        ],
      );
}
