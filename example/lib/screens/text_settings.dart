import '../utils/utils.dart';

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class TextSettingsScreen extends StatefulWidget {
  const TextSettingsScreen({super.key});

  @override
  State<TextSettingsScreen> createState() => _TextSettingsScreenState();
}

class _TextSettingsScreenState extends State<TextSettingsScreen> {
  // Gather the theme data //

  late bool isDark = PlatformTheme.of(context)!.isDark;

  final double margin = EzConfig.get(marginKey);
  final double spacing = EzConfig.get(spacingKey);

  late final EzSpacer spacer = EzSpacer(spacing);
  late final EzSpacer separator = EzSpacer(2 * spacing);

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(EFUILang.of(context)!.tsPageTitle);
  }

  // Gather the build data //

  late TextStyle displayStyle = getDisplay(context)!;
  late TextStyle headlineStyle = getHeadline(context)!;
  late TextStyle titleStyle = getTitle(context)!;
  late TextStyle bodyStyle = getBody(context)!;
  late TextStyle labelStyle = getLabel(context)!;

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: efuiS,
      body: EzScreen(
        decorationImageKey: isDark ? darkPageImageKey : lightPageImageKey,
        child: EzScrollView(
          children: <Widget>[
            // Font
            if (spacing > margin) EzSpacer(spacing - margin),

            // Display
            Text(
              EFUILang.of(context)!.tsDisplayPreview,
              style: displayStyle,
              textAlign: TextAlign.center,
            ),
            spacer,

            // Headline
            Text(
              EFUILang.of(context)!.tsHeadlinePreview,
              style: headlineStyle,
              textAlign: TextAlign.center,
            ),
            spacer,

            // Title
            Text(
              EFUILang.of(context)!.tsTitlePreview,
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
            spacer,

            // Body
            Text(
              EFUILang.of(context)!.tsBodyPreview,
              style: bodyStyle,
              textAlign: TextAlign.center,
            ),
            spacer,

            // Label
            Text(
              EFUILang.of(context)!.tsLabelPreview,
              style: labelStyle,
              textAlign: TextAlign.center,
            ),
            separator,

            // Local reset all
            EzResetButton(
              dialogTitle: EFUILang.of(context)!.tsResetAll,
              onConfirm: () {
                EzConfig.removeKeys(textStyleKeys.keys.toSet());
                popScreen(context: context, result: true);
              },
            ),
            spacer,
          ],
        ),
      ),
    );
  }
}
