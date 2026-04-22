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
  late EzSettingsSection currSection =
      widget.pages[widget.target ?? EzConfig.hubPos];
  late EzSubSetting currSubSec = currSection.fromStorage();
  int delta = 0;

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      mainAxisSize: MainAxisSize.min,
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
            delta = currSection.position - choice.position;

            await EzConfig.setHubPos(choice.position);
            setState(() => currSection = choice);
          },
        ),

        // Sub-section nav
        if (currSection.subSettings.isNotEmpty) ...<Widget>[
          EzConfig.margin,
          EzScrollView(
            scrollDirection: Axis.horizontal,
            mainAxisSize: MainAxisSize.min,
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
        ],

        // TODO...
        // Add an up/down slide for the mini segments when navigating to/fro global
        // Make a todoist note about this setup for open ui's home page, and
        // Organize todoist a bit

        // Current section
        AnimatedSwitcher(
          duration: ezAnimDuration(),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (Widget w, Animation<double> a) =>
              ezTransitionsBuilder(context, a, a, w),
          // TODO: using same animation works?
          child: currSection.build(currSubSec),
        ),
        EzConfig.separator
      ],
    );
  }
}
