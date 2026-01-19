/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class SuccessHeader extends StatelessWidget {
  /// [ThemeData.textTheme] passthrough
  final TextTheme textTheme;

  /// Core message to display... under 'Success'
  /// Used in an [Flexible] wrapped [EzText]
  /// Provide [message] or [richMessage]
  final String? message;

  /// Core message to display... under 'Success'
  /// Provide [message] or [richMessage]
  final Widget? richMessage;

  /// header [Widget] for a successful run
  const SuccessHeader({
    super.key,
    required this.textTheme,
    this.message,
    this.richMessage,
  }) : assert((message == null) != (richMessage == null),
            'Either message or richMessage must be provided, but not both.');

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Headline
          Flexible(
            child: EzText(
              EzConfig.l10n.gSuccessExl,
              style: textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
          EzConfig.spacer,

          // Where to go next
          message == null
              ? richMessage!
              : Flexible(
                  child: EzText(
                    message!,
                    style: ezSubTitleStyle(textTheme),
                    textAlign: TextAlign.center,
                  ),
                ),
        ],
      );
}

class RunOption extends StatelessWidget {
  /// The Flutter project directory
  final String projDir;

  /// [TextStyle] for 'would you like to...'
  final TextStyle? style;

  /// [EzElevatedIconButton.onPressed] passthrough for the play button
  final void Function() emulate;

  const RunOption({
    super.key,
    required this.projDir,
    required this.style,
    required this.emulate,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMac = !kIsWeb && getBasePlatform() == TargetPlatform.macOS;

    return isMac
        ? const SizedBox.shrink()
        : Column(
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
                onPressed: emulate,
                icon: const Icon(Icons.play_arrow),
                label: Lang.of(context)!.rsRun,
              ),
            ],
          );
  }
}
