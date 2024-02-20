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
  late final EzSpacer rowSpacer = EzSpacer.row(spacing);
  late final EzSpacer separator = EzSpacer(2 * spacing);

  // Set the page title //

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPageTitle(EFUILang.of(context)!.tsPageTitle);
  }

  // Gather the build data //

  TextStyleType editing = TextStyleType.display;

  late TextStyle displayStyle = getDisplay(context)!;
  late TextStyle headlineStyle = getHeadline(context)!;
  late TextStyle titleStyle = getTitle(context)!;
  late TextStyle bodyStyle = getBody(context)!;
  late TextStyle labelStyle = getLabel(context)!;

  late final String display = EFUILang.of(context)!.tsDisplay.toLowerCase();
  late final String headline = EFUILang.of(context)!.tsHeadline.toLowerCase();
  late final String title = EFUILang.of(context)!.tsTitle.toLowerCase();
  late final String body = EFUILang.of(context)!.tsBody.toLowerCase();
  late final String label = EFUILang.of(context)!.tsLabel.toLowerCase();

  late final List<DropdownMenuEntry<TextStyleType>> styleChoices =
      <DropdownMenuEntry<TextStyleType>>[
    DropdownMenuEntry<TextStyleType>(
      value: TextStyleType.display,
      label: display,
    ),
    DropdownMenuEntry<TextStyleType>(
      value: TextStyleType.headline,
      label: headline,
    ),
    DropdownMenuEntry<TextStyleType>(
      value: TextStyleType.title,
      label: title,
    ),
    DropdownMenuEntry<TextStyleType>(
      value: TextStyleType.body,
      label: body,
    ),
    DropdownMenuEntry<TextStyleType>(
      value: TextStyleType.label,
      label: label,
    ),
  ];

  // Define the setting controllers //

  late Widget familyController = EzFontFamilySetting(
    styleKey: editing.familyKey,
  );
  late Widget sizeController = Container();
  late Widget weightController = Container();
  late Widget styleController = Container();
  late Widget letterSpacingController = Container();
  late Widget wordSpacingController = Container();
  late Widget heightController = Container();
  late Widget decorationController = Container();

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: efuiS,
      body: EzScreen(
        decorationImageKey: isDark ? darkPageImageKey : lightPageImageKey,
        child: EzScrollView(
          children: <Widget>[
            if (spacing > margin) EzSpacer(spacing - margin),

            // Style selector
            EzRow(
              mainAxisAlignment: MainAxisAlignment.center,
              reverseHands: true,
              children: <Widget>[
                Text(
                  EFUILang.of(context)!.tsEditing,
                  style: labelStyle,
                  textAlign: TextAlign.center,
                ),
                rowSpacer,
                DropdownMenu<TextStyleType>(
                  initialSelection: editing,
                  onSelected: (TextStyleType? value) {
                    if (value != null) {
                      setState(() {
                        editing = value;
                      });
                    }
                  },
                  dropdownMenuEntries: styleChoices,
                ),
              ],
            ),
            separator,

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                familyController,
                sizeController,
                weightController,
                styleController,
                letterSpacingController,
                wordSpacingController,
                heightController,
                decorationController,
              ],
            ),
            separator,

            // Display preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text: EFUILang.of(context)!.tsDisplayP1,
                  style: displayStyle,
                ),
                EzInlineLink(
                  EFUILang.of(context)!.tsDisplayLink,
                  style: displayStyle,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextStyleType.display;
                  }),
                  semanticsLabel: EFUILang.of(context)!.tsLinkHint(display),
                ),
                EzPlainText(
                  text: EFUILang.of(context)!.tsDisplayP2,
                  style: displayStyle,
                ),
              ],
              textAlign: TextAlign.center,
            ),
            spacer,

            // Headline preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text: EFUILang.of(context)!.tsHeadlineP1,
                  style: headlineStyle,
                ),
                EzInlineLink(
                  EFUILang.of(context)!.tsHeadlineLink,
                  style: headlineStyle,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextStyleType.headline;
                  }),
                  semanticsLabel: EFUILang.of(context)!.tsLinkHint(headline),
                ),
                EzPlainText(
                  text: EFUILang.of(context)!.tsHeadlineP2,
                  style: headlineStyle,
                ),
              ],
              textAlign: TextAlign.center,
            ),
            spacer,

            // Title preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text: EFUILang.of(context)!.tsTitleP1,
                  style: titleStyle,
                ),
                EzInlineLink(
                  EFUILang.of(context)!.tsTitleLink,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextStyleType.title;
                  }),
                  semanticsLabel: EFUILang.of(context)!.tsLinkHint(title),
                ),
              ],
              textAlign: TextAlign.center,
            ),
            spacer,

            // Body preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text: EFUILang.of(context)!.tsBodyP1,
                  style: bodyStyle,
                ),
                EzInlineLink(
                  EFUILang.of(context)!.tsBodyLink,
                  style: bodyStyle,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextStyleType.body;
                  }),
                  semanticsLabel: EFUILang.of(context)!.tsLinkHint(body),
                ),
                EzPlainText(
                  text: EFUILang.of(context)!.tsBodyP2,
                  style: bodyStyle,
                ),
              ],
              textAlign: TextAlign.center,
            ),
            spacer,

            // Label preview
            EzRichText(
              <InlineSpan>[
                EzPlainText(
                  text: EFUILang.of(context)!.tsLabelP1,
                  style: labelStyle,
                ),
                EzInlineLink(
                  EFUILang.of(context)!.tsLabelLink,
                  style: labelStyle,
                  textAlign: TextAlign.center,
                  onTap: () => setState(() {
                    editing = TextStyleType.label;
                  }),
                  semanticsLabel: EFUILang.of(context)!.tsLinkHint(label),
                ),
                EzPlainText(
                  text: EFUILang.of(context)!.tsLabelP2,
                  style: labelStyle,
                ),
              ],
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
