/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../structs/export.dart';
import '../../widgets/export.dart';
import 'package:efui_bios/efui_bios.dart';

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_saver/file_saver.dart';
import 'package:file_picker/file_picker.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ThruConfigScreen extends StatefulWidget {
  final EAGConfig config;

  const ThruConfigScreen({super.key, required this.config});

  @override
  State<ThruConfigScreen> createState() => _ThruConfigScreenState();
}

class _ThruConfigScreenState extends State<ThruConfigScreen> {
  // Gather the theme data //

  static const EzSpacer spacer = EzSpacer();

  late final EFUILang l10n = EFUILang.of(context)!;

  late final TextTheme textTheme = Theme.of(context).textTheme;
  late final TextStyle? notificationStyle =
      textTheme.bodyLarge?.copyWith(fontSize: textTheme.titleLarge?.fontSize);

  // Define the build data //

  late final TargetPlatform platform = getBasePlatform(context);
  late final bool isDesktop = platform == TargetPlatform.linux ||
      platform == TargetPlatform.macOS ||
      platform == TargetPlatform.windows;

  late final String defaultPath = platform == TargetPlatform.windows
      ? '${Platform.environment['UserProfile']}\\Documents'
      : '${Platform.environment['HOME']}/Documents';

  late final TextEditingController pathController =
      TextEditingController(text: defaultPath);
  bool readOnly = false;

  late Widget centerPiece = loadingPage;

  late String successMessage =
      '''\nYour configuration has been saved to ${archivePath()}

Use it on Open UI for desktop to generate the code for ${widget.config.appName}''';

  String errorMessage = 'Something went wrong.\nPlease try again.';

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
        errorMessage = 'Something went wrong...\n\n${e.toString()}';
        centerPiece = failurePage;
      });
    }

    savedConfig.endsWith('.json')
        ? setState(() => centerPiece = successPage)
        : setState(() => centerPiece = failurePage);
  }

  /// Human readable path for saved config
  String archivePath() {
    switch (platform) {
      case TargetPlatform.android:
        return 'Root > Android > Data > net.empathetech.open_ui > files';
      case TargetPlatform.iOS:
        return 'Files > Browse > Open UI';
      default:
        return 'Downloads';
    }
  }

  /// Confirm func for the project directory alert actions
  void usePath(BuildContext dialogContext) async {
    const String message = 'Invalid path';

    final bool validPath = await Directory(pathController.text).exists();
    if (validPath) {
      if (dialogContext.mounted) {
        Navigator.of(dialogContext).pop(pathController.text);
      }
    } else {
      // Disable interaction
      setState(() {
        readOnly = true;
        pathController.text = message;
      });

      // Wait a sec
      await Future<void>.delayed(readingTime(message));

      // Allow
      setState(() {
        readOnly = false;
        pathController.text = defaultPath;
      });
    }
  }

  /// Generate the new app!
  void genCode() async {
    final String? userPath = await showPlatformDialog(
      context: context,
      builder: (BuildContext pathContext) {
        return EzAlertDialog(
          title: const Text('Confirm project directory'),
          content: EzScrollView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              IconButton(
                onPressed: () async {
                  final String? selectedDirectory =
                      await FilePicker.platform.getDirectoryPath();

                  if (selectedDirectory != null) {
                    setState(() => pathController.text = selectedDirectory);
                  }
                },
                icon: Icon(PlatformIcons(context).folderOpen),
              ),
              EzSpacer(vertical: false, space: EzConfig.get(marginKey)),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: measureText(
                    '/Users/username/Documents/Subfolder',
                    context: context,
                    style: textTheme.bodyLarge,
                  ).width,
                ),
                child: TextFormField(
                  controller: pathController,
                  readOnly: readOnly,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  validator: (String? path) => (path == null || path.isEmpty)
                      ? 'Path required. Cannot use root folder.'
                      : null,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                ),
              ),
            ],
          ),
          materialActions: <Widget>[
            EzTextButton(
              onPressed: () => usePath(pathContext),
              text: 'Done',
            ),
            EzTextButton(
              onPressed: () {
                Navigator.of(pathContext).pop();
                Navigator.of(context).pop();
              },
              text: 'Cancel',
            ),
          ],
          cupertinoActions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => usePath(pathContext),
              child: const Text('Done'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(pathContext).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
          needsClose: false,
        );
      },
    );
    if (userPath == null || userPath.isEmpty) {
      setState(() {
        errorMessage = 'Path required. Cannot use root folder.';
        centerPiece = failurePage;
      });
      return;
    }

    late final ProcessResult? runResult;
    try {
      runResult = await Process.run(
        'flutter',
        <String>[
          'create',
          '--org',
          widget.config.domainName,
          widget.config.appName,
        ],
        runInShell: true,
        workingDirectory: userPath,
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Something went wrong...\n\n${e.toString()}';
        centerPiece = failurePage;
      });
    }

    runResult != null
        ? setState(() {
            successMessage = '${widget.config.appName} is ready in\n$userPath';
            centerPiece = successPage;
          })
        : setState(() => centerPiece = failurePage);
  }

  /// (Desktop only) confirm if the user wants to...
  /// generate code, save the config, or cancel
  Future<dynamic> confirm() async {
    return await showPlatformDialog(
      context: context,
      builder: (BuildContext confirmContext) {
        return EzAlertDialog(
          title: const Text('Would you like to...'),
          contents: <Widget>[
            // Generate code
            EzElevatedIconButton(
              label: 'Generate ${widget.config.appName}',
              textAlign: TextAlign.center,
              icon: Icon(PlatformIcons(context).folderOpen),
              onPressed: () {
                Navigator.of(confirmContext).pop(true);
                genCode();
              },
            ),
            spacer,

            // Save config
            EzElevatedIconButton(
              label: 'Save config',
              icon: const Icon(Icons.save),
              onPressed: () {
                Navigator.of(confirmContext).pop(false);
                archive();
              },
            ),
          ],
          materialActions: <Widget>[
            EzTextButton(
              text: 'Cancel',
              onPressed: () {
                Navigator.of(confirmContext).pop(null);
                Navigator.of(context).pop(false);
              },
            ),
          ],
          cupertinoActions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(confirmContext).pop(null);
                Navigator.of(context).pop(false);
              },
            ),
          ],
          needsClose: false,
        );
      },
    );
  }

  // Define custom Widgets //

  /// Loading animation
  late final Widget loadingPage = Center(
    child: SizedBox(
      height: heightOf(context) / 2,
      child: const EmpathetechLoadingAnimation(
        height: double.infinity,
        semantics: 'TODO',
      ),
    ),
  );

  /// Tells user what to do next
  late final Widget successPage = EzScrollView(
    children: <Widget>[
      Text(
        'Success!',
        style: textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),
      Text(
        successMessage,
        style: notificationStyle,
        textAlign: TextAlign.center,
      ),
    ],
  );

  /// Displays the error
  late final Widget failurePage = EzScrollView(
    children: <Widget>[
      Text(
        'Failure',
        style: textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),
      Text(
        errorMessage,
        style: notificationStyle,
        textAlign: TextAlign.center,
      ),
    ],
  );

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => isDesktop ? confirm() : archive());
  }

  // Return the build //

  @override
  Widget build(_) => OpenUIScaffold(
        title: 'Generator',
        body: EzScreen(child: centerPiece),
      );

  @override
  void dispose() {
    pathController.dispose();
    super.dispose();
  }
}
