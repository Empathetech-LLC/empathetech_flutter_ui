/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../structs/export.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

Future<void> genREADME({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) =>
    ezCLI(
      exe: 'echo',
      args: <String>['>', 'BLARG', 'README.md'],
      dir: dir,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );

Future<void> genAppVersion({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) =>
    ezCLI(
      exe: 'echo',
      args: <String>['>', '1.0.0', 'APP_VERSION'],
      dir: dir,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );

Future<void> genLicense({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) =>
    ezCLI(
      exe: 'echo',
      args: <String>['>', config.license, 'LICENSE'],
      dir: dir,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );

Future<void> genPubspec({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) =>
    ezCLI(
      exe: 'echo',
      args: <String>['>', 'BLARG', 'pubspec.yaml'],
      dir: dir,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );

Future<void> genLib({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  ezLog("I don't do anything... yet!\nAlso: BLARG");
}

Future<void> genL10n({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) =>
    ezCLI(
      exe: 'echo',
      args: <String>[
        '>',
        config.l10nConfig ??
            'Something went wrong\nnull config.l10nConfig sent to genL10n',
        'l10n.yaml'
      ],
      dir: dir,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );

Future<void> genAnalysis({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) =>
    ezCLI(
      exe: 'echo',
      args: <String>[
        '>',
        config.analysisOptions ??
            'Something went wrong\nnull config.analysisOptions sent to genAnalysis',
        'analysis_options.yaml'
      ],
      dir: dir,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );

Future<void> genVSCode({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  // Make dir
  await ezCLI(
    exe: 'mkdir',
    args: <String>['.vscode'],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );

  // Make file
  await ezCLI(
    exe: 'echo',
    args: <String>[
      '>',
      config.vsCodeConfig ??
          'Something went wrong\bnull config.vsCodeConfig sent to genVSCode',
      '.vscode/launch.json'
    ],
    dir: dir,
    onSuccess: onSuccess,
    onFailure: onFailure,
  );
}

Future<void> genIntegrationTests({
  required EAGConfig config,
  required String dir,
  void Function() onSuccess = doNothing,
  required void Function(String) onFailure,
}) async {
  ezLog("I don't do anything... yet!\nAlso: BLARG");
}
