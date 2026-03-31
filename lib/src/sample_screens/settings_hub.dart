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

  @override
  Widget build(BuildContext context) {
    return EzScrollView(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Navigation
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
            await EzConfig.setHubPos(selected.first.position);
            setState(() => curr = selected.first);
          },
        ),

        // Current section
        curr.build,
      ],
    );
  }
}
