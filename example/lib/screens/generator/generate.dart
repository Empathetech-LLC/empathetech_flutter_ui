/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './shared.dart';
import '../../structs/export.dart';
import '../../utils/export.dart';
import '../../widgets/export.dart';
import 'package:efui_bios/efui_bios.dart';

import 'dart:io';
import 'package:xml/xml.dart';
import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class GenerateScreen extends StatefulWidget {
  final EAGConfig config;

  const GenerateScreen({super.key, required this.config});

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  // Gather the theme data //

  static const EzSeparator separator = EzSeparator();
  static const EzDivider divider = EzDivider();

  late final EFUILang l10n = EFUILang.of(context)!;
  late final TextTheme textTheme = Theme.of(context).textTheme;

  late final TextStyle? subHeading =
      textTheme.bodyLarge?.copyWith(fontSize: textTheme.titleLarge?.fontSize);

  // Define the build data //

  late final bool isWindows =
      getBasePlatform(context) == TargetPlatform.windows;

  late final String workDir = widget.config.genPath!;
  late final String projDir = isWindows
      ? '$workDir\\${widget.config.appName}'
      : '$workDir/${widget.config.appName}';

  String device() {
    late final TargetPlatform platform = getBasePlatform(context);

    if (platform == TargetPlatform.linux) {
      return 'linux';
    } else if (platform == TargetPlatform.macOS) {
      return 'macos';
    } else if (platform == TargetPlatform.windows) {
      return 'windows';
    } else {
      return 'chrome';
    }
  }

  bool showReadout = false;
  StringBuffer readout = StringBuffer();

  bool emulating = false;

  static const Widget loading = EmpathetechLoadingAnimation(
    height: double.infinity,
    semantics: 'BLARG',
  );

  Widget header = loading;

  late final Widget successHeader = SuccessHeader(
    textTheme: textTheme,
    message: '\n${widget.config.appName} is ready in\n${widget.config.genPath}',
  );

  late final List<Widget> body = <Widget>[
    ConsoleOutput(
      textTheme: textTheme,
      showReadout: showReadout,
      onHide: () => setState(() => showReadout = !showReadout),
      readout: readout,
    ),
    separator,
  ];

  late final RunOption runOption = RunOption(
    projDir: projDir,
    style: subHeading,
    emulate: () async {
      if (emulating) return;

      setState(() {
        emulating = true;
        header = loading;
      });
      ezSnackBar(
        context: context,
        message: 'First run usually takes awhile',
      );

      await ezCLI(
        exe: 'flutter',
        args: <String>[
          'run',
          '-d',
          device(),
        ],
        dir: projDir,
        onSuccess: () => setState(() {
          emulating = false;
          header = successHeader;
        }),
        onFailure: (String message) => onFailure(message, delete: false),
        readout: readout,
      );
    },
  );

  late final DeleteOption deleteOption = DeleteOption(
    appName: widget.config.appName,
    baseDir: workDir,
    style: subHeading,
  );

  // Define custom functions //

  void onFailure(String message, {bool delete = true}) {
    setState(() {
      header = FailureHeader(message: '\n$message', textTheme: textTheme);
      if (delete && !body.contains(deleteOption)) {
        body.insertAll(0, <Widget>[deleteOption, divider]);
      }
    });

    // Exit any further processing
    return;
  }

  /// Run Flutter, Run!
  Future<void> genStuff() async {
    await ezCLI(
      exe: 'flutter',
      args: <String>[
        'create',
        '--org',
        widget.config.domainName,
        widget.config.appName,
      ],
      dir: workDir,
      onSuccess: delStuff,
      onFailure: onFailure,
      readout: readout,
    );
  }

  /// Runs immediately after a successful [genStuff]
  Future<void> delStuff() async {
    await ezCLI(
      exe: 'rm',
      args: <String>[
        '-rf',
        'lib',
        'test',
        'analysis_options.yaml',
        'pubspec.lock',
        'pubspec.yaml',
        'README.md',
      ],
      dir: projDir,
      onSuccess: addStuff,
      onFailure: onFailure,
      readout: readout,
    );
  }

  /// Runs immediately after a successful [delStuff]
  Future<void> addStuff() async {
    await genREADME(
      config: widget.config,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genVersionTracking(
      config: widget.config,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genLicense(
      config: widget.config,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genPubspec(
      config: widget.config,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await genLib(
      config: widget.config,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    if (widget.config.l10nConfig != null) {
      await genL10n(
        config: widget.config,
        dir: projDir,
        onFailure: onFailure,
        readout: readout,
      );
    }

    if (widget.config.analysisOptions != null) {
      await genAnalysis(
        config: widget.config,
        dir: projDir,
        onFailure: onFailure,
        readout: readout,
      );
    }

    if (widget.config.vsCodeConfig != null) {
      await genVSCode(
        config: widget.config,
        dir: projDir,
        onFailure: onFailure,
        readout: readout,
      );
    }

    await genIntegrationTests(
      config: widget.config,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    await runStuff();
  }

  /// Runs immediately after a successful [addStuff]
  /// Last method before completion
  Future<void> runStuff() async {
    late ProcessResult? runResult;
    try {
      // Update entitlements //

      final File macOSDebugEntitlements =
          File('$projDir/macos/Runner/DebugProfile.entitlements');
      final File macOSReleaseEntitlements =
          File('$projDir/macos/Runner/Release.entitlements');

      final XmlDocument debugDoc =
          XmlDocument.parse(await macOSDebugEntitlements.readAsString());
      final XmlDocument releaseDoc =
          XmlDocument.parse(await macOSReleaseEntitlements.readAsString());

      const String networkClientKey = 'com.apple.security.network.client';

      // Check if the entitlements already exist

      if (debugDoc.findAllElements(networkClientKey).isEmpty) {
        // Add the entitlement
        final XmlElement dictionary =
            debugDoc.rootElement.findElements('dict').first;

        dictionary.children.add(XmlElement(XmlName(networkClientKey)));
        dictionary.children.add(XmlElement(XmlName('true')));

        // Save the modified file
        await macOSDebugEntitlements
            .writeAsString(debugDoc.toXmlString(pretty: true));
      }

      if (releaseDoc.findAllElements(networkClientKey).isEmpty) {
        // Add the entitlement
        final XmlElement dictionary =
            releaseDoc.rootElement.findElements('dict').first;

        dictionary.children.add(XmlElement(XmlName(networkClientKey)));
        dictionary.children.add(XmlElement(XmlName('true')));

        // Save the modified file
        await macOSReleaseEntitlements
            .writeAsString(releaseDoc.toXmlString(pretty: true));
      }

      // Make sure packages are in order //

      ezLog("\n'flutter clean'...", buffer: readout);
      runResult = await Process.run(
        'flutter',
        <String>['clean'],
        runInShell: true,
        workingDirectory: projDir,
      );
      ezLog('stdout: ${runResult.stdout}', buffer: readout);
      ezLog('stderr: ${runResult.stderr}', buffer: readout);

      ezLog("\n'flutter upgrade'...", buffer: readout);
      runResult = await Process.run(
        'flutter',
        <String>[
          'pub',
          'upgrade',
          '--major-versions',
        ],
        runInShell: true,
        workingDirectory: projDir,
      );
      ezLog('stdout: ${runResult.stdout}', buffer: readout);
      ezLog('stderr: ${runResult.stderr}', buffer: readout);

      ezLog("\n'flutter tighten'...", buffer: readout);
      runResult = await Process.run(
        'flutter',
        <String>[
          'pub',
          'upgrade',
          '--tighten',
        ],
        runInShell: true,
        workingDirectory: projDir,
      );
      ezLog('stdout: ${runResult.stdout}', buffer: readout);
      ezLog('stderr: ${runResult.stderr}', buffer: readout);

      // (optionally) Generate l10n files //

      if (widget.config.l10nConfig != null) {
        ezLog("\n'flutter gen-l10n'...", buffer: readout);
        runResult = await Process.run(
          'flutter',
          <String>['gen-l10n'],
          runInShell: true,
          workingDirectory: projDir,
        );
        ezLog('stdout: ${runResult.stdout}', buffer: readout);
        ezLog('stderr: ${runResult.stderr}', buffer: readout);
      }
    } catch (e) {
      onFailure(e.toString());
    }

    (runResult != null && runResult.exitCode == 0)
        ? setState(() {
            header = successHeader;
            if (!body.contains(runOption)) {
              body.insertAll(0, <Widget>[runOption, divider]);
            }
          })
        : onFailure(
            '\nThe code was successfully generated, but some of the project setup failed.');
  }

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => genStuff());
  }

  // Return the build //

  @override
  Widget build(_) => GeneratorScreen(
        title: 'Generator',
        header: header,
        body: body,
      );
}

class ConsoleOutput extends StatelessWidget {
  final TextTheme textTheme;

  final bool showReadout;
  final void Function() onHide;
  final StringBuffer readout;

  const ConsoleOutput({
    super.key,
    required this.textTheme,
    required this.showReadout,
    required this.onHide,
    required this.readout,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        EzRow(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Console output',
              style: textTheme.titleLarge,
              textAlign: TextAlign.start,
            ),
            EzSpacer(vertical: false, space: EzConfig.get(marginKey)),
            IconButton(
              onPressed: onHide,
              icon: Icon(
                showReadout ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              ),
            ),
          ],
        ),

        // Readout
        Visibility(
          visible: showReadout,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: widthOf(context) * 0.75,
              maxHeight: heightOf(context) / 2,
            ),
            child: TextFormField(
              readOnly: true,
              maxLines: null,
              textAlign: TextAlign.start,
              controller: TextEditingController(text: readout.toString()),
            ),
          ),
        ),
      ],
    );
  }
}
