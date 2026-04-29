/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class AdvancedColorSettings extends StatefulWidget {
  final String userColorsKey;
  final List<String> currList;
  final List<String> defaultList;
  final Widget resetSpacer;
  final Set<String>? resetExtraDark;
  final Set<String>? resetExtraLight;
  final Set<String>? resetSkip;
  final Set<String>? saveSkip;

  const AdvancedColorSettings({
    super.key,
    required this.userColorsKey,
    required this.currList,
    required this.defaultList,
    required this.resetSpacer,
    required this.resetExtraDark,
    required this.resetExtraLight,
    required this.resetSkip,
    required this.saveSkip,
  });

  @override
  State<AdvancedColorSettings> createState() => _AdvancedColorSettingsState();
}

class _AdvancedColorSettingsState extends State<AdvancedColorSettings> {
  // Define custom Widgets //

  /// Returns the color keys the user is tracking
  List<Widget> dynamicColorSettings(String userColorsKey) {
    final EdgeInsets wrapPadding = EzInsets.wrap(EzConfig.spacing);
    final List<Widget> toReturn = <Widget>[];

    final Set<String> defaultSet = widget.defaultList.toSet();
    for (final String key in widget.currList) {
      if (defaultSet.contains(key)) {
        // Non-removable buttons
        toReturn.add(
          Padding(
            padding: wrapPadding,
            child: (EzColorSetting(key: ValueKey<String>(key), configKey: key)),
          ),
        );
      } else {
        toReturn.add(
          // Removable buttons
          Padding(
            padding: wrapPadding,
            child: (EzColorSetting(
              key: ValueKey<String>(key),
              configKey: key,
              onRemove: () async {
                widget.currList.remove(key);
                await EzConfig.setStringList(userColorsKey, widget.currList);
                setState(() {});
              },
            )),
          ),
        );
      }
    }

    return toReturn;
  }

  /// Returns the color keys the user is NOT tracking
  List<Widget> getUntrackedColors(StateSetter setModalState) {
    final Set<String> currSet = widget.currList.toSet();
    final List<String> fullList = EzConfig.isDark ? darkColorOrder : lightColorOrder;

    return fullList
        .where((String element) => !currSet.contains(element))
        .map<Widget>((String configKey) {
      final Color liveColor = getLiveColor(configKey);

      return Padding(
        padding: EzInsets.wrap(EzConfig.spacing),
        child: EzElevatedIconButton(
          key: ValueKey<String>(configKey),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(EzConfig.padding * 0.75),
          ),
          onPressed: () {
            final int newColorIndex = fullList.indexOf(configKey);

            int insertAt = widget.currList.length;
            for (int i = 0; i < widget.currList.length; i++) {
              if (fullList.indexOf(widget.currList[i]) > newColorIndex) {
                insertAt = i;
                break;
              }
            }
            widget.currList.insert(insertAt, configKey);

            setState(() {});
            setModalState(() {});
          },
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: EzConfig.colors.primaryContainer,
                width: EzConfig.borderWidth,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: liveColor,
              radius: EzConfig.padding + EzConfig.marginVal,
              child: liveColor == Colors.transparent ? EzIcon(Icons.visibility_off) : null,
            ),
          ),
          label: getColorName(configKey),
        ),
      );
    }).toList();
  }

  // Return the build //

  @override
  Widget build(BuildContext context) => EzCol(children: <Widget>[
        // Dynamic color settings
        EzSwapWidget(
          expanded: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: widthOf(context) * 0.8),
            child: EzWrap(children: dynamicColorSettings(widget.userColorsKey)),
          ),
          restricted: EzCol(children: dynamicColorSettings(widget.userColorsKey)),
        ),
        EzConfig.separator,

        // Add a color button
        EzTextIconButton(
          onPressed: () async {
            // Show modal
            await ezModal(
              context: context,
              builder: (_) => StatefulBuilder(
                builder: (_, StateSetter setModalState) => EzScrollView(
                  children: <Widget>[
                    // Tutorial link
                    EzLink(
                      EzConfig.l10n.gHowThisWorks,
                      style: EzConfig.styles.labelLarge!,
                      textAlign: TextAlign.center,
                      padding: EdgeInsets.all(EzConfig.marginVal),
                      buttonShape: true,
                      url: Uri.parse('https://m3.material.io/styles/color/roles'),
                      hint: EzConfig.l10n.gHowThisWorksHint,
                      tooltip: 'https://m3.material.io/styles/color/roles',
                    ),

                    // Color options
                    EzWrap(children: getUntrackedColors(setModalState)),
                    EzConfig.spacer,
                  ],
                ),
              ),
            );

            // Save changes
            await EzConfig.setStringList(widget.userColorsKey, widget.currList);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(EzConfig.marginVal),
            shape: EzConfig.buttonShape.shape,
          ),
          icon: const Icon(Icons.add_circle_outline),
          label: EzConfig.l10n.csAddColor,
        ),

        // Local reset
        widget.resetSpacer,
        EzResetButton(
          all: false,
          dynamicTitle: () => EzConfig.l10n.csReset(ezThemeString(false)),
          resetSkip: widget.resetSkip,
          onConfirm: () async {
            if (EzConfig.isDark) {
              await EzConfig.removeKeys(darkColorKeys.keys.toSet());
              if (widget.resetExtraDark != null) {
                await EzConfig.removeKeys(widget.resetExtraDark!);
              }
            } else {
              await EzConfig.removeKeys(lightColorKeys.keys.toSet());
              if (widget.resetExtraLight != null) {
                await EzConfig.removeKeys(widget.resetExtraLight!);
              }
            }
          },
        ),
      ]);
}
