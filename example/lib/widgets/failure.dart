/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

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
            child: Text(
              'Failure',
              style: textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),

          // Error message
          Flexible(
            child: Text(
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

  /// Directory to run the rm command in
  final String baseDir;

  /// [TextStyle] for 'would you like to...'
  final TextStyle? style;

  /// Optional [ezCLI] readout passthrough
  final ValueNotifier<String>? readout;

  /// Iterable [Widget] containing a [EzElevatedIconButton] for wiping the partial build
  const DeleteOption({
    super.key,
    required this.appName,
    required this.baseDir,
    required this.style,
    this.readout,
  });

  static const EzSpacer spacer = EzSpacer();

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'would you like to...',
              style: style,
              textAlign: TextAlign.center,
            ),
            spacer,
            EzElevatedIconButton(
              onPressed: () => ezCLI(
                exe: 'rm',
                args: <String>[
                  '-rf',
                  appName,
                ],
                dir: baseDir,
                onSuccess: () async {
                  await ezSnackBar(
                    context: context,
                    message: 'Success; fingers crossed for next time!',
                  ).closed;

                  if (context.mounted) Navigator.of(context).pop();
                },
                onFailure: (String message) async {
                  await ezSnackBar(
                    context: context,
                    message:
                        'Another failure; you should probably take over...',
                  ).closed;

                  if (context.mounted) Navigator.of(context).pop();
                },
                readout: readout,
              ),
              icon: Icon(PlatformIcons(context).delete),
              label: 'Wipe it',
            ),
            spacer,
            EzElevatedIconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(PlatformIcons(context).back),
              label: 'Leave it',
            ),
          ],
        ),
      );
}

class LinkOption extends StatelessWidget {
  /// [TextStyle] for 'would you like to...'
  final TextStyle? style;

  /// Iterable [Widget] containing a [EzElevatedIconButton] for wiping the partial build
  const LinkOption(this.style, {super.key});

  static const EzSpacer spacer = EzSpacer();
  static const String installFlutter =
      'https://docs.flutter.dev/get-started/install';

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'would you like to...',
              style: style,
              textAlign: TextAlign.center,
            ),
            spacer,
            EzElevatedIconButton(
              onPressed: () => launchUrl(Uri.parse(installFlutter)),
              icon: const Icon(Icons.computer),
              label: 'Install it',
            ),
          ],
        ),
      );
}
