import '../widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ImageSettingsScreen extends StatefulWidget {
  const ImageSettingsScreen({super.key});

  @override
  State<ImageSettingsScreen> createState() => _ImageSettingsScreenState();
}

class _ImageSettingsScreenState extends State<ImageSettingsScreen> {
  // Gather the theme data //

  late bool isDark = PlatformTheme.of(context)!.isDark;

  final double spacing = EzConfig.get(spacingKey);

  late final EzSpacer _buttonSpacer = EzSpacer(spacing);
  late final EzSpacer _buttonSeparator = EzSpacer(2 * spacing);

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define the page content //

  late final String themeProfile =
      isDark ? l10n.gDark.toLowerCase() : l10n.gLight.toLowerCase();

  late final List<Widget> settingsButtons = <Widget>[
    isDark
        // Page
        ? EzImageSetting(
            configKey: darkPageImageKey,
            label: l10n.isBackground,
            allowClear: true,
            updateTheme: Brightness.dark,
          )
        : EzImageSetting(
            configKey: lightPageImageKey,
            label: l10n.isBackground,
            allowClear: true,
            updateTheme: Brightness.light,
          ),
    _buttonSeparator,

    // Local reset all
    EzResetButton(
      dialogTitle: l10n.isResetAll(themeProfile),
      onConfirm: () => EzConfig.removeKeys(imageKeys.keys.toSet()),
    ),
  ];

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(l10n.isPageTitle);
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      body: EzScreen(
        decorationImageKey: isDark ? darkPageImageKey : lightPageImageKey,
        child: EzScrollView(
          children: <Widget>[
            // Current theme reminder
            Text(
              l10n.gEditingTheme(themeProfile),
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            _buttonSeparator,

            // Settings
            ...settingsButtons,
            _buttonSpacer,
          ],
        ),
      ),
    );
  }
}
