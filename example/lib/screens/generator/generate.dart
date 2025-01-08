/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

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
  static const Widget divider = EzDivider();

  late final EFUILang l10n = EFUILang.of(context)!;
  late final TextTheme textTheme = Theme.of(context).textTheme;

  late final TextStyle? subTitle = subTitleStyle(textTheme);

  // Define the build data //

  GeneratorState genState = GeneratorState.running;
  String failureMessage = '';

  /// Quantum computing
  bool? showDelete = true;

  late final TargetPlatform platform = getBasePlatform(context);

  late final String workDir = widget.config.genPath!;
  late final String projDir = platform == TargetPlatform.windows
      ? '$workDir\\${widget.config.appName}'
      : '$workDir/${widget.config.appName}';

  String device() {
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

  ValueNotifier<String> readout = ValueNotifier<String>('');
  bool showReadout = false;

  // Define custom functions //

  void onFailure(String message) {
    setState(() {
      failureMessage = message;
      genState = GeneratorState.failed;
    });

    // Exit any further processing
    return;
  }

  /// The only way to begin
  /// Is by beginning
  Future<void> genStuff() async {
    await ezCLI(
      'flutter create --org ${widget.config.domainName} ${widget.config.appName}',
      dir: workDir,
      onSuccess: delStuff,
      onFailure: (String message) {
        if (message.contains('command not found')) {
          setState(() {
            showDelete = null;
            failureMessage = 'Flutter is not installed';
            genState = GeneratorState.failed;
          });
        } else {
          onFailure(message);
        }
      },
      readout: readout,
    );
  }

  /// Runs immediately after a successful [genStuff]
  Future<void> delStuff() async {
    const String files =
        'analysis_options.yaml pubspec.lock pubspec.yaml README.md';
    const String dirs = 'lib test';

    // Files
    await ezCLI(
      'rm -f $files',
      winCMD: 'del /f /q $files',
      platform: platform,
      dir: projDir,
      onSuccess: doNothing,
      onFailure: onFailure,
      readout: readout,
    );

    // Folders
    await ezCLI(
      'rm -rf $dirs',
      winCMD: 'rmdir /s /q $dirs',
      platform: platform,
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
      platform: platform,
      dir: projDir,
      onFailure: onFailure,
      readout: readout,
    );

    if (widget.config.l10nConfig != null) {
      await genL10n(
        config: widget.config,
        platform: platform,
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
      platform: platform,
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

      ezLog('flutter clean...', buffer: readout);
      runResult = await Process.run(
        'flutter',
        <String>['clean'],
        runInShell: true,
        workingDirectory: projDir,
      );
      ezLog(runResult.stdout, buffer: readout);
      ezLog(runResult.stderr, buffer: readout);

      ezLog('flutter upgrade...', buffer: readout);
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
      ezLog(runResult.stdout, buffer: readout);
      ezLog(runResult.stderr, buffer: readout);

      ezLog('flutter tighten...', buffer: readout);
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
      ezLog(runResult.stdout, buffer: readout);
      ezLog(runResult.stderr, buffer: readout);

      // (optionally) Generate l10n files //

      if (widget.config.l10nConfig != null) {
        ezLog('flutter gen-l10n...', buffer: readout);
        runResult = await Process.run(
          'flutter',
          <String>['gen-l10n'],
          runInShell: true,
          workingDirectory: projDir,
        );
        ezLog(runResult.stdout, buffer: readout);
        ezLog(runResult.stderr, buffer: readout);
      }
    } catch (e) {
      onFailure(e.toString());
    }

    (runResult != null && runResult.exitCode == 0)
        ? setState(() {
            showDelete = false;
            genState = GeneratorState.successful;
          })
        : onFailure(
            '\nThe code was successfully generated, but some of the project setup failed.');
  }

  Widget header() {
    switch (genState) {
      case GeneratorState.running:
        return SizedBox(
          height: heightOf(context) / 3,
          width: double.infinity,
          child: const EmpathetechLoadingAnimation(
            height: double.infinity,
            semantics: 'BLARG',
          ),
        );
      case GeneratorState.successful:
        return SizedBox(
          height: heightOf(context) / 3,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SuccessHeader(
                textTheme: textTheme,
                message:
                    '\n${widget.config.appName} is ready in\n${widget.config.genPath}',
              ),
              separator,
              RunOption(
                projDir: projDir,
                style: subTitle,
                emulate: () async {
                  if (genState == GeneratorState.running) return;

                  setState(() => genState = GeneratorState.running);
                  ezSnackBar(
                    context: context,
                    message: 'First run usually takes awhile',
                  );

                  await ezCLI(
                    'flutter run -d ${device()}',
                    dir: projDir,
                    onSuccess: () =>
                        setState(() => genState = GeneratorState.successful),
                    onFailure: onFailure,
                    readout: readout,
                  );
                },
              ),
            ],
          ),
        );
      case GeneratorState.failed:
        return SizedBox(
          height: heightOf(context) / 3,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FailureHeader(
                textTheme: textTheme,
                message: '\n$failureMessage',
              ),
              if (showDelete == true) ...<Widget>[
                separator,
                DeleteOption(
                  appName: widget.config.appName,
                  platform: platform,
                  dir: workDir,
                  style: subTitle,
                ),
              ],
              if (showDelete == null) ...<Widget>[
                separator,
                LinkOption(subTitle),
              ],
            ],
          ),
        );
    }
  }

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => genStuff());
  }

  // Return the build //

  @override
  Widget build(_) {
    return OpenUIScaffold(
      title: 'Generator',
      running: genState == GeneratorState.running,
      body: EzScreen(
        child: EzScrollView(children: <Widget>[
          header(),
          divider,

          // Console output //

          // Toggle
          EzRow(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Console output',
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              EzMargin(vertical: false),
              IconButton(
                onPressed: () => setState(() => showReadout = !showReadout),
                icon: Icon(
                  showReadout ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
              ),
            ],
          ),
          EzMargin(),

          // Readout
          Visibility(
            visible: showReadout,
            child: Container(
              constraints: BoxConstraints(
                minWidth: widthOf(context) * 0.667,
                maxWidth: widthOf(context) * 0.667,
                maxHeight: heightOf(context) / 2,
              ),
              padding: EdgeInsets.all(EzConfig.get(marginKey)),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: ezRoundEdge,
              ),
              child: ValueListenableBuilder<String>(
                valueListenable: readout,
                builder: (_, String value, __) => EzScrollView(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  child: Text(
                    value,
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
          ),
          separator,
        ]),
      ),
    );
  }
}
