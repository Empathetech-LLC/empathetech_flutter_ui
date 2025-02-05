/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzCLI extends StatefulWidget {
  /// [ezCmd] passthrough
  final String dir;

  /// [ezCmd] passthrough
  final TargetPlatform platform;

  /// [ezCmd] passthrough
  final void Function() onSuccess;

  /// [ezCmd] passthrough
  final void Function(String message) onFailure;

  /// [ezCmd] passthrough
  final void Function(String message)? onError;

  /// [ezCmd] passthrough
  final bool debug;

  /// [ezCmd] passthrough
  final ValueNotifier<String>? readout;

  /// Simple interface for running CLI commands via [ezCmd]
  const EzCLI({
    super.key,
    required this.dir,
    required this.platform,
    required this.onSuccess,
    required this.onFailure,
    this.onError,
    this.debug = true,
    this.readout,
  });

  @override
  State<EzCLI> createState() => _EzCLIState();
}

class _EzCLIState extends State<EzCLI> {
  // Gather the theme data //

  late final TextTheme textTheme = Theme.of(context).textTheme;

  // Define the build data //

  final TextEditingController cmdController = TextEditingController();

  // Return the build //

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Title
          EzText(
            'CLI',
            style: textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),

          // Field
          ConstrainedBox(
            constraints: ezTextFieldConstraints(context),
            child: TextFormField(
              controller: cmdController,
              textAlign: TextAlign.start,
              maxLines: 1,
              decoration:
                  const InputDecoration(hintText: 'echo "Hello, World!"'),
              onFieldSubmitted: (String value) async {
                await ezCmd(
                  value,
                  platform: widget.platform,
                  dir: widget.dir,
                  onSuccess: widget.onSuccess,
                  onFailure: widget.onFailure,
                  onError: widget.onError,
                  debug: widget.debug,
                  readout: widget.readout,
                );
                cmdController.clear();
              },
            ),
          ),
        ],
      );

  @override
  void dispose() {
    cmdController.dispose();
    super.dispose();
  }
}
