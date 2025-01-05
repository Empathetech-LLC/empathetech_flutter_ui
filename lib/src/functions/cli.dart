/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';

Future<void> ezCLI({
  required String exe,
  required List<String> args,
  required String dir,
  required void Function() onSuccess,
  required void Function(String message) onFailure,
  void Function(String message)? onError,
  bool debug = true,
  ValueNotifier<String>? readout,
}) async {
  if (debug) ezLog('$exe $args...');
  if (readout != null) readout.value += '$exe $args...\n';

  late final ProcessResult runResult;
  try {
    runResult = await Process.run(
      exe,
      args,
      runInShell: true,
      workingDirectory: dir,
    );
  } catch (e) {
    onError == null ? onFailure(e.toString()) : onError(e.toString());
  }

  final String err = runResult.stderr.toString();

  if (debug) {
    ezLog(runResult.stdout);
    if (err.isNotEmpty) ezLog(err);
  }

  if (readout != null) {
    readout.value += '${runResult.stdout}\n';
    if (err.isNotEmpty) readout.value += '$err\n';
  }

  runResult.exitCode == 0
      ? onSuccess()
      : onFailure(runResult.stderr.toString());
}
