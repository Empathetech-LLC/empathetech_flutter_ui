/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ImageSettings extends StatefulWidget {
  /// Dark theme value for [EzScreen.decorationImageKey]
  final String? darkBackgroundImageKey;

  /// Light theme value for [EzScreen.decorationImageKey]
  final String? lightBackgroundImageKey;

  /// Optional additional settings
  /// Recommended to use [EzImageSetting]
  final List<Widget> additionalSettings;

  const ImageSettings({
    super.key,
    this.lightBackgroundImageKey,
    this.darkBackgroundImageKey,
    this.additionalSettings = const <Widget>[],
  });

  @override
  State<ImageSettings> createState() => _ImageSettingsState();
}

class _ImageSettingsState extends State<ImageSettings> {
  // Gather the theme data //

  late bool isDark = PlatformTheme.of(context)!.isDark;
  int keyValue = Random().nextInt(rMax);

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define the page content //

  late final String themeProfile =
      isDark ? l10n.gDark.toLowerCase() : l10n.gLight.toLowerCase();

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(l10n.isPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return EzScreen(
      decorationImageKey: isDark
          ? widget.darkBackgroundImageKey
          : widget.lightBackgroundImageKey,
      child: EzScrollView(
        children: <Widget>[
          // Current theme reminder
          Text(
            l10n.gEditingTheme(themeProfile),
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
          separator,

          // Page image setting
          EzScrollView(
            scrollDirection: Axis.horizontal,
            startCentered: true,
            mainAxisSize: MainAxisSize.min,
            child: isDark
                ? EzImageSetting(
                    key: ValueKey<String>('dark$keyValue'),
                    configKey: darkBackgroundImageKey,
                    label: l10n.isBackground,
                    updateTheme: Brightness.dark,
                  )
                : EzImageSetting(
                    key: ValueKey<String>('light$keyValue'),
                    configKey: lightBackgroundImageKey,
                    label: l10n.isBackground,
                    updateTheme: Brightness.light,
                  ),
          ),

          if (widget.additionalSettings.isNotEmpty) spacer,
          ...widget.additionalSettings,
          separator,

          // Local reset all
          EzResetButton(
            dialogTitle: l10n.isResetAll(themeProfile),
            onConfirm: () async {
              await EzConfig.removeKeys(imageKeys.keys.toSet());
              keyValue = Random().nextInt(rMax);
              setState(() {});
            },
          ),
          spacer,
        ],
      ),
    );
  }
}
