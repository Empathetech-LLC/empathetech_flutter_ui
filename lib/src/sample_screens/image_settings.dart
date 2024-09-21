/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ImageSettings extends StatefulWidget {
  /// For [EzScreen.useImageDecoration]
  final bool useImageDecoration;

  /// Optional additional settings
  /// Recommended to use [EzImageSetting]
  final List<Widget>? additionalSettings;

  /// Optional credits for dark background image
  final String? darkBackgroundCredits;

  /// Optional credits for light background image
  final String? lightBackgroundCredits;

  const ImageSettings({
    super.key,
    this.useImageDecoration = true,
    this.darkBackgroundCredits,
    this.lightBackgroundCredits,
    this.additionalSettings,
  });

  @override
  State<ImageSettings> createState() => _ImageSettingsState();
}

class _ImageSettingsState extends State<ImageSettings> {
  // Gather the theme data //

  static const EzSpacer spacer = EzSpacer();
  static const EzSeparator separator = EzSeparator();

  late bool isDark = PlatformTheme.of(context)?.isDark ??
      (MediaQuery.of(context).platformBrightness == Brightness.dark);

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define the page content //

  int keyValue = Random().nextInt(rMax);

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
      useImageDecoration: widget.useImageDecoration,
      child: EzScrollView(
        children: <Widget>[
          // Current theme reminder
          EzTextBackground(
            Text(
              l10n.gEditingTheme(themeProfile),
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            useSurface: false,
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
                    credits: widget.darkBackgroundCredits,
                    label: l10n.isBackground,
                    updateTheme: Brightness.dark,
                  )
                : EzImageSetting(
                    key: ValueKey<String>('light$keyValue'),
                    configKey: lightBackgroundImageKey,
                    credits: widget.lightBackgroundCredits,
                    label: l10n.isBackground,
                    updateTheme: Brightness.light,
                  ),
          ),

          if (widget.additionalSettings != null) ...<Widget>{
            spacer,
            ...widget.additionalSettings!,
          },
          separator,

          // Local reset all
          EzResetButton(
            dialogTitle: l10n.isResetAll(themeProfile),
            onConfirm: () async {
              await EzConfig.removeKeys(imageKeys.keys.toSet());
              setState(() => keyValue = Random().nextInt(rMax));
            },
          ),
          spacer,
        ],
      ),
    );
  }
}
