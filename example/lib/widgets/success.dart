/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SuccessHeader extends StatelessWidget {
  /// [ThemeData.textTheme] passthrough
  final TextTheme textTheme;

  /// Core message to display... under 'Success'
  final String message;

  /// header [Widget] for a successful run
  const SuccessHeader({
    super.key,
    required this.textTheme,
    required this.message,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Headline
          Flexible(
            child: EzText(
              'Success!',
              style: textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const EzSpacer(),

          // Where to go next
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
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          EzText(
            'would you like to...',
            style: style,
            textAlign: TextAlign.center,
          ),
          const EzSpacer(),
          EzElevatedIconButton(
            onPressed: emulate,
            icon: EzIcon(PlatformIcons(context).playArrowSolid),
            label: 'Run it',
          ),
        ],
      );
}
