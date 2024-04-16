import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class RepoButton extends StatelessWidget {
  const RepoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: () => launchUrl(Uri.parse(efuiGitHub)),
      leadingIcon: Icon(
        LineIcons.github,
        size: Theme.of(context).textTheme.titleLarge?.fontSize,
      ),
      child: Text(EFUILang.of(context)!.gBYO),
    );
  }
}
