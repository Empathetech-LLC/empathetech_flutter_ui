/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';

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
  if (debug) ezLog('$cmd...');
  if (readout != null) readout.value += '$cmd...\n';

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
    onError == null ? onFailure(e.toString()) : onError(e.toString());
  }

  final String out = runResult.stdout.toString();
  final String err = runResult.stderr.toString();

  if (debug) {
    ezLog(out);
    if (err.isNotEmpty) ezLog(err);
  }

  if (readout != null) {
    readout.value += '$out\n';
    if (err.isNotEmpty) readout.value += '$err\n';
  }

  runResult.exitCode == 0 ? onSuccess() : onFailure(err);
}
