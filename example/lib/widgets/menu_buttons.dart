/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../screens/export.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SettingsButton extends StatelessWidget {
  /// [EzMenuButton] for opening the settings
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) => EzMenuButton(
        onPressed: () => context.goNamed(settingsHomePath),
        icon: Icon(PlatformIcons(context).settings),
        label: EFUILang.of(context)!.ssPageTitle,
      );
}

class OpenSourceButton extends StatelessWidget {
  /// [EzMenuButton] for opening the EFUI GitHub repo
  const OpenSourceButton({super.key});

  @override
  Widget build(BuildContext context) {
    final EFUILang l10n = EFUILang.of(context)!;
    final String text = l10n.gOpenSource;

    return EzMenuButton(
      onPressed: () => launchUrl(Uri.parse(efuiGitHub)),
      semanticsLabel: '$text: ${l10n.gEFUISourceHint}',
      icon: const Icon(LineIcons.github),
      label: text,
    );
  }
}
