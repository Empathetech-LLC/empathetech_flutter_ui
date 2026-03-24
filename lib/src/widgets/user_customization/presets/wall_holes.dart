/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

class EzWallHolesConfig extends StatelessWidget {
  /// Only runs if you're using the rendered [Widget]
  /// Calling [onPressed] does not trigger [onComplete]
  final Future<void> Function() onComplete;

  /// !Not Windows
  const EzWallHolesConfig(this.onComplete, {super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
