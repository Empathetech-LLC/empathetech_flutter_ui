/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';

Future<void> ezCLI({
  required String exe,
  required List<String> args,
  required String dir,
  required void Function() onSuccess,
  required void Function(String message) onFailure,
  void Function(String message)? onError,
  bool debug = true,
  StringBuffer? readout,
}) async {
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

  if (debug) {
    ezLog("\n'$exe $args'...");
    ezLog('stdout: ${runResult.stdout}');
    ezLog('stderr: ${runResult.stderr}');
  }

  if (readout != null) {
    readout.writeln("\n'$exe $args'...");
    readout.writeln(runResult.stdout);
    readout.writeln(runResult.stderr);
  }

  runResult.exitCode == 0
      ? onSuccess()
      : onFailure(runResult.stderr.toString());
}
