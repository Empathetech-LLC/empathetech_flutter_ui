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
  late EzSettingsSection curr = widget.pages[widget.target ?? EzConfig.hubPos];
  late EzSubSetting currSub = curr.fromStorage();
  int delta = 0;

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Section nav
        EzText(
          curr.title,
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
          selected: <EzSettingsSection>{curr},
          showSelectedIcon: false,
          onSelectionChanged: (Set<EzSettingsSection> selected) async {
            final EzSettingsSection choice = selected.first;
            delta = curr.position - choice.position;

            await EzConfig.setHubPos(choice.position);
            setState(() => curr = choice);
          },
        ),

        // Sub-section nav
        if (curr.subSettings.isNotEmpty) ...<Widget>[
          EzConfig.margin,
          EzScrollView(
            scrollDirection: Axis.horizontal,
            mainAxisSize: MainAxisSize.min,
            reverseHands: true,
            showScrollHint: true,
            children: <Widget>[
              // Quick/Advanced selector
              SegmentedButton<EzSubSetting>(
                segments: (curr.subSettings)
                    .map((EzSubSetting sub) => ButtonSegment<EzSubSetting>(
                          value: sub,
                          label: Text(sub.label),
                        ))
                    .toList(),
                selected: <EzSubSetting>{currSub},
                showSelectedIcon: false,
                onSelectionChanged: (Set<EzSubSetting> selected) async {
                  final EzSubSetting choice = selected.first;

                  await EzConfig.setBool(choice.write.$1, choice.write.$2);
                  setState(() => currSub = choice);
                },
              ),

              // Update both toggle
              EzConfig.rowMargin,
              EzThemeCoin(doNothing, enabled: currSub.bothable),
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
          key: ValueKey<int>(EzConfig.seed),
          duration: ezAnimDuration(),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (Widget w, Animation<double> a) =>
              ezTransitionsBuilder(context, a, a, w),
          // TODO: using same animation works?
          child: curr.build,
        ),
        EzConfig.separator
      ],
    );
  }
}
