/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:io';

Future<void> cli({
  required String exe,
  required List<String> args,
  required String dir,
  required void Function() onSuccess,
  required void Function() onError,
  required void Function() onFailure,
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
    onError();
  }

  runResult.exitCode == 0 ? onSuccess() : onFailure();
}
