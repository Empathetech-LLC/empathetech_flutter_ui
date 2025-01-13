/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzToolTipper extends StatefulWidget {
  final String message;

  /// Classic question mark tool tip
  const EzToolTipper(this.message, {super.key});

  @override
  State<EzToolTipper> createState() => _EzToolTipperState();
}

class _EzToolTipperState extends State<EzToolTipper> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.message,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(PlatformIcons(context).help),
      ),
    );
  }
}
