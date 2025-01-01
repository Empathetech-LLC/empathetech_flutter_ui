/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import './shared.dart';
import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class InstallScreen extends StatefulWidget {
  const InstallScreen({super.key});

  @override
  State<InstallScreen> createState() => _InstallScreenState();
}

class _InstallScreenState extends State<InstallScreen> {
  // Gather the theme data //

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define the build data //

  late final bool isWindows =
      getBasePlatform(context) == TargetPlatform.windows;

  late Widget centerPiece = loadingPage(context);

  // Define custom functions //

  /// Make sure we have everything we need to install Flutter
  Future<void> checkRequirements() async {
    debugPrint('BLARG');
  }

  // Init //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkRequirements());
  }

  // Return the build //

  @override
  Widget build(_) =>
      OpenUIScaffold(title: 'Installer', body: EzScreen(child: centerPiece));
}
