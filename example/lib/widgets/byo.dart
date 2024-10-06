/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class BYOButton extends StatelessWidget {
  const BYOButton({super.key});

  @override
  Widget build(BuildContext context) {
    final EFUILang l10n = EFUILang.of(context)!;

    final String text = l10n.gBYO;

    return EzMenuButton(
      onPressed: () => launchUrl(Uri.parse(efuiGitHub)),
      semanticsLabel: '$text: ${l10n.gEFUISourceHint}',
      icon: const Icon(LineIcons.github),
      label: text,
    );
  }
}
