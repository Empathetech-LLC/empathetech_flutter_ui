/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class FailurePage extends StatelessWidget {
  /// Core message to display... under 'Failure'
  final String message;

  /// [ThemeData.textTheme] passthrough
  final TextTheme textTheme;

  /// Whether to show the option to wipe what was created
  final bool showDelete;

  /// Required iff [showDelete] is true
  final String? deleteAppName;

  /// Required iff [showDelete] is true
  final String? deleteBaseDir;

  /// Optional for when [showDelete] is true
  final StringBuffer? readout;

  /// centerpiece [Widget] for a failed run
  const FailurePage({
    super.key,
    required this.message,
    required this.textTheme,
    this.showDelete = false,
    this.deleteAppName,
    this.deleteBaseDir,
    this.readout,
  });

  @override
  Widget build(BuildContext context) {
    // Gather the theme data //

    const EzSpacer spacer = EzSpacer();
    const EzSeparator separator = EzSeparator();

    final TextStyle? focusStyle =
        textTheme.bodyLarge?.copyWith(fontSize: textTheme.titleLarge?.fontSize);

    // Return the build //

    return EzScrollView(
      children: <Widget>[
        // Headline
        Text(
          'Failure',
          style: textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),

        // Error message
        Text(
          message,
          style: focusStyle,
          textAlign: TextAlign.center,
        ),

        // Optional delete option
        if (showDelete &&
            deleteAppName != null &&
            deleteBaseDir != null) ...<Widget>[
          const EzDivider(),
          Text(
            'would you like to...',
            style: focusStyle,
            textAlign: TextAlign.center,
          ),
          spacer,
          EzElevatedIconButton(
            onPressed: () => ezCLI(
              exe: 'rm',
              args: <String>[
                '-rf',
                deleteAppName!,
              ],
              dir: deleteBaseDir!,
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
                  message: 'Another failure; you should probably take over...',
                ).closed;

                if (context.mounted) Navigator.of(context).pop();
              },
              readout: readout,
            ),
            icon: Icon(PlatformIcons(context).delete),
            label: 'wipe it',
          ),
          const EzSpacer(),
          EzElevatedIconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(PlatformIcons(context).back),
            label: 'leave it',
          ),
        ],
        separator,
      ],
    );
  }
}
