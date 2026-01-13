/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';

/// Readability alias
void _log(String message, bool debug, ValueNotifier<String>? readout) {
  if (debug) ezLog(message);
  if (readout != null) readout.value += '$message\n';
}

/// Run a CLI [cmd]
/// Track the stdout/err with [debug] and [readout]
Future<void> ezCmd(
  String cmd, {
  required String dir,
  required void Function() onSuccess,
  required void Function(String message) onFailure,
  void Function(String message)? onError,
  bool debug = true,
  ValueNotifier<String>? readout,
}) async {
  _log(cmd, debug, readout);

  final List<String> args = cmd.split(' ');
  late final ProcessResult runResult;
  try {
    runResult = await Process.run(
      args[0],
      args.sublist(1),
      runInShell: true,
      workingDirectory: dir,
    );
  } catch (e) {
    _log(e.toString(), debug, readout);
    onError == null ? onFailure(e.toString()) : onError(e.toString());
    return;
  }

  final String out = runResult.stdout.toString();
  final String err = runResult.stderr.toString();

  _log(out, debug, readout);
  if (err.isNotEmpty) _log(err, debug, readout);

  runResult.exitCode == 0 ? onSuccess() : onFailure(err);
}
