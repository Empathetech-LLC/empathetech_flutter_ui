/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class BYOButton extends StatelessWidget {
  final EFUILang l10n;

  const BYOButton(this.l10n, {super.key});

  @override
  Widget build(BuildContext context) {
    final String text = l10n.gBYO;

    return MenuItemButton(
      onPressed: () => launchUrl(Uri.parse(efuiGitHub)),
      semanticsLabel: '$text: ${l10n.gEFUISourceHint}',
      leadingIcon: Icon(
        LineIcons.github,
        size: Theme.of(context).textTheme.headlineLarge?.fontSize,
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Text(text),
    );
  }
}
