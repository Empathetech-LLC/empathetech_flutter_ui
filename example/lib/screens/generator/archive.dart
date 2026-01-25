/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../utils/export.dart';
import '../../widgets/export.dart';
import 'package:efui_bios/efui_bios.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_saver/file_saver.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ArchiveScreen extends StatefulWidget {
  final EAGConfig config;

  const ArchiveScreen({super.key, required this.config});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  // Define the build data //

  GeneratorState genState = GeneratorState.running;
  String failureMessage = '';

  final TargetPlatform platform = getBasePlatform();

  late final bool isDesktop = platform == TargetPlatform.linux ||
      platform == TargetPlatform.macOS ||
      platform == TargetPlatform.windows;

  // Define custom functions //

  /// Save the config
  void archive() async {
    late final String savedConfig;
    try {
      savedConfig = await FileSaver.instance.saveFile(
        name: '${widget.config.appName}_eag_config.json',
        bytes: utf8.encode(jsonEncode(widget.config.toJson())),
        mimeType: MimeType.json,
      );
    } catch (e) {
      setState(() {
        failureMessage = e.toString();
        genState = GeneratorState.failed;
      });
    }

    savedConfig.endsWith('.json')
        ? setState(() => genState = GeneratorState.successful)
        : setState(() {
            failureMessage =
                '${EzConfig.l10n.ssWrongConfigExt} .json...\n\n$savedConfig';
            genState = GeneratorState.failed;
          });
  }

  Widget header(Lang l10n) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    switch (genState) {
      case GeneratorState.running:
        return SizedBox(
          height: heightOf(context) / 3,
          width: double.infinity,
          child: EmpathyLoading(semantics: EzConfig.l10n.gLoadingAnim),
        );
      case GeneratorState.successful:
        return Center(
          child: SuccessHeader(
            textTheme: textTheme,
            richMessage: EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text: EzConfig.l10n.ssConfigSaved(archivePath(
                    appName: 'Open UI',
                    androidPackage: 'net.empathetech.open_ui',
                  )),
                ),
                if (!isDesktop) ...<InlineSpan>[
                  EzPlainText(text: l10n.asUseIt),
                  EzInlineLink(
                    appName,
                    style: ezSubTitleStyle(textTheme),
                    textAlign: TextAlign.center,
                    url: Uri.parse(openUIReleases),
                    hint: EzConfig.l10n.gOpenUIReleases,
                  ),
                  EzPlainText(text: l10n.asToGen(widget.config.appName)),
                ]
              ],
              style: ezSubTitleStyle(textTheme),
              textAlign: TextAlign.center,
            ),
          ),
        );
      case GeneratorState.failed:
        return Center(
          child: FailureHeader(
            textTheme: textTheme,
            message: failureMessage,
          ),
        );
    }
  }

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => archive());
  }

  // Return the build //

  @override
  Widget build(_) {
    final Lang l10n = Lang.of(context)!;

    return OpenUIScaffold(
      title: l10n.asPageTitle,
      running: genState == GeneratorState.running,
      body: EzScreen(header(l10n), alignment: Alignment.center),
    );
  }
}
