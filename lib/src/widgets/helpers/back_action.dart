/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

/// Mimics the [AppBar.leading] back button
/// But can also be used in [AppBar.actions] for left handed layouts
class EzBackAction extends StatelessWidget {
  const EzBackAction({super.key});

  @override
  Widget build(BuildContext context) => Navigator.canPop(context)
      ? IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          tooltip: EzConfig.l10n.gBack,
          icon: Icon(
            Icons.arrow_back,
            semanticLabel: EzConfig.l10n.gBack,
          ),
        )
      : const SizedBox.shrink();
}
