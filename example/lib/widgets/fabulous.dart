/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';
import 'package:efui_bios/efui_bios.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class ResetFAB extends StatelessWidget {
  /// Function to execute with 'Builder values' and 'Both' options
  final void Function() clearForms;

  /// Opens an [EzAlertDialog] for resetting the form fields, app settings, both, or none
  const ResetFAB({required this.clearForms, super.key});

  @override
  Widget build(BuildContext context) {
    final Lang l10n = Lang.of(context)!;

    return Tooltip(
      message: EzConfig.l10n.gReset,
      excludeFromSemantics: true,
      child: Semantics(
        label: EzConfig.l10n.gReset,
        button: true,
        hint: l10n.csResetHint,
        child: ExcludeSemantics(
          child: FloatingActionButton(
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext dContext) {
                return EzAlertDialog(
                  title: Text(
                    '${EzConfig.l10n.gReset}...',
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    // Builder/forms
                    EzMaterialAction(
                      onPressed: () async {
                        clearForms();
                        if (dContext.mounted) {
                          Navigator.of(dContext).pop();
                        }
                      },
                      text: l10n.csResetBuilder,
                      isDefaultAction: true,
                    ),

                    // App settings
                    EzMaterialAction(
                      onPressed: () async {
                        await EzConfig.reset(notifyTheme: true);
                        if (dContext.mounted) {
                          Navigator.of(dContext).pop();
                        }
                      },
                      text: l10n.csResetApp,
                      isDestructiveAction: true,
                    ),

                    // Both
                    EzMaterialAction(
                      onPressed: () async {
                        clearForms();
                        await EzConfig.reset(notifyTheme: true);
                        if (dContext.mounted) {
                          Navigator.of(dContext).pop();
                        }
                      },
                      text: l10n.csResetBoth,
                      isDestructiveAction: true,
                    ),

                    // None
                    EzMaterialAction(
                      onPressed: () => Navigator.of(dContext).pop(),
                      text: l10n.csResetNothing,
                    ),
                  ],
                  needsClose: false,
                );
              },
            ),
            child: EzIcon(Icons.refresh),
          ),
        ),
      ),
    );
  }
}

/// When needed, add this an modify the main router
class MacStoreFAB extends StatelessWidget {
  /// Opens an [EzAlertDialog] for resetting the form fields, app settings, both, or none
  const MacStoreFAB({super.key});

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        heroTag: 'macStore',
        tooltip: 'EoL',
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext dContext) {
            return EzAlertDialog(contents: <Widget>[
              const Text(
                '''Good news: Open UI is now an app generator!

Bad news: the new features cannot be supported on the App Store.

The full (free and open source) app generator can be downloaded from the ''',
                textAlign: TextAlign.center,
              ),
              EzLink(
                'GitHub releases',
                url: Uri.parse(openUIReleases),
                hint: openUIReleases,
              ),
            ]);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        child: EzIcon(Icons.update),
      );
}
