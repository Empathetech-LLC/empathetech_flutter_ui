/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzCLI extends StatelessWidget {
  /// [ezCmd] passthrough
  final String dir;

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

  final TextEditingController _cmdController;

  /// Simple interface for running CLI commands via [ezCmd]
  EzCLI({
    super.key,
    required this.dir,
    required this.onSuccess,
    required this.onFailure,
    this.onError,
    this.debug = true,
    this.readout,
  }) : _cmdController = TextEditingController();

  @override
  Widget build(BuildContext context) => EzCol(children: <Widget>[
        // Title
        EzText(
          'CLI',
          style: EzConfig.styles.titleLarge,
          textAlign: TextAlign.center,
        ),

        // Field
        ConstrainedBox(
          constraints: ezTextFieldConstraints(context),
          child: TextFormField(
            controller: _cmdController,
            textAlign: TextAlign.start,
            maxLines: 1,
            decoration: const InputDecoration(hintText: 'echo "Hello, World!"'),
            onFieldSubmitted: (String value) async {
              await ezCmd(
                value,
                dir: dir,
                onSuccess: onSuccess,
                onFailure: onFailure,
                onError: onError,
                debug: debug,
                readout: readout,
              );
              _cmdController.clear();
            },
          ),
        ),
      ]);
}
