/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class BYOButton extends StatelessWidget {
  final BuildContext parentContext;
  final EFUILang l10n;

  const BYOButton({
    super.key,
    required this.parentContext,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: () => launchUrl(Uri.parse(efuiGitHub)),
      leadingIcon: Icon(
        LineIcons.github,
        size: Theme.of(context).textTheme.titleLarge?.fontSize,
      ),
      child: Text(l10n.gBYO),
    );
  }
}
