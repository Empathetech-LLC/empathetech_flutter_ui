/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class EzSettingsHub extends StatefulWidget {
  /// Where the magic happens
  final List<EzSettingsSection> pages;

  /// Optional starting point
  /// Defaults to 0/first
  final int? target;

  /// Empathetech settings landing page
  const EzSettingsHub({super.key, required this.pages, this.target});

  @override
  State<EzSettingsHub> createState() => _EzSettingsHubState();
}

class _EzSettingsHubState extends State<EzSettingsHub> {
  late EzSettingsSection currSection = widget.pages[widget.target ?? EzConfig.hubPos];
  late EzSubSetting currSubSec = currSection.fromStorage();
  int delta = 0;

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      children: <Widget>[
        // Section nav
        EzText(
          currSection.title,
          style: EzConfig.styles.labelLarge,
          textAlign: TextAlign.center,
        ),
        SegmentedButton<EzSettingsSection>(
          segments: widget.pages
              .map((EzSettingsSection type) => ButtonSegment<EzSettingsSection>(
                    value: type,
                    icon: type.icon,
                  ))
              .toList(),
          selected: <EzSettingsSection>{currSection},
          showSelectedIcon: false,
          onSelectionChanged: (Set<EzSettingsSection> selected) async {
            final EzSettingsSection choice = selected.first;
            delta = choice.position - currSection.position;

            await EzConfig.setHubPos(choice.position);

            currSection = choice;
            currSubSec = choice.fromStorage();

            setState(() {});
          },
        ),

        // Sub-section nav (&& divider)
        EzAnimVis(
          visible: currSection.subSettings.isNotEmpty,
          mod: 0.75,
          forceType: EzTransitionType.slideY,
          forceFade: true,
          reverse: true,
          child: EzCol(children: <Widget>[
            EzConfig.margin,
            EzScrollView(
              scrollDirection: Axis.horizontal,
              reverseHands: true,
              showScrollHint: true,
              children: <Widget>[
                // Quick/Advanced selector
                SegmentedButton<EzSubSetting>(
                  segments: (currSection.subSettings)
                      .map((EzSubSetting sub) => ButtonSegment<EzSubSetting>(
                            value: sub,
                            label: Text(sub.label),
                          ))
                      .toList(),
                  selected: <EzSubSetting>{currSubSec},
                  showSelectedIcon: false,
                  onSelectionChanged: (Set<EzSubSetting> selected) async {
                    final EzSubSetting choice = selected.first;

                    await EzConfig.setBool(choice.write.$1, choice.write.$2);
                    setState(() => currSubSec = choice);
                  },
                ),

                // Update both toggle
                EzConfig.rowMargin,
                EzThemeCoin(doNothing, enabled: currSubSec.bothable),
              ],
            ),
            EzDivider(height: EzConfig.spacing),
            EzConfig.spacer,
          ]),
        ),

        // Current section
        EzFauxCarousel(
          position: currSection.position,
          delta: delta,
          child: currSection.build(currSubSec),
        ),
        EzConfig.separator
      ],
    );
  }
}
