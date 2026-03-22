/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

// TODO: make sure you preserve web paths for the new system... potentially add a "smart" catcher

class EzSettingsHub extends StatefulWidget {
  /// Where the magic happens
  final List<EzSettingsSection> pages;

  /// Empathetech settings landing page
  const EzSettingsHub({super.key, required this.pages});

  @override
  State<EzSettingsHub> createState() => _EzSettingsHubState();
}

class _EzSettingsHubState extends State<EzSettingsHub> {
  void redraw() => setState(() {});

  late EzSettingsSection curr = widget.pages.first;

  @override
  Widget build(BuildContext context) => EzScrollView(children: <Widget>[
        // Navigation
        EzText(
          curr.title,
          style: EzConfig.styles.labelLarge,
          textAlign: TextAlign.center,
          padding: EdgeInsets.only(
            left: EzConfig.marginVal,
            right: EzConfig.marginVal,
            bottom: EzConfig.marginVal,
          ),
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
          onSelectionChanged: (Set<EzSettingsSection> selected) =>
              setState(() => curr = selected.first),
        ),

        // Current section
        curr.build,
      ]);
}
