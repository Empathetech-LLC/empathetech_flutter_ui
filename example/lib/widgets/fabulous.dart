/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ResetFAB extends StatelessWidget {
  /// Function to execute with 'Builder values' and 'Both' options
  final void Function() clearForms;

  /// Opens an [EzAlertDialog] for resetting the form fields, app settings, both, or none
  const ResetFAB({required this.clearForms, super.key});

  @override
  Widget build(BuildContext context) {
    final EFUILang l10n = EFUILang.of(context)!;

    return Semantics(
      label: 'Reset',
      hint: 'Opens a dialog to confirm what should be reset.',
      button: true,
      child: ExcludeSemantics(
        child: FloatingActionButton(
          onPressed: () => showPlatformDialog(
            context: context,
            builder: (BuildContext alertContext) {
              return EzAlertDialog(
                title: Text('${l10n.gReset}...', textAlign: TextAlign.center),
                materialActions: <Widget>[
                  EzMaterialAction(
                    onPressed: () async {
                      clearForms();
                      if (alertContext.mounted) {
                        Navigator.of(alertContext).pop();
                      }
                    },
                    text: 'Builder values',
                    isDefaultAction: true,
                  ),
                  EzMaterialAction(
                    onPressed: () async {
                      await EzConfig.reset();
                      if (alertContext.mounted) {
                        Navigator.of(alertContext).pop();
                      }
                    },
                    text: 'App settings',
                    isDestructiveAction: true,
                  ),
                  EzMaterialAction(
                    onPressed: () async {
                      clearForms();
                      await EzConfig.reset();
                      if (alertContext.mounted) {
                        Navigator.of(alertContext).pop();
                      }
                    },
                    text: 'Both',
                    isDestructiveAction: true,
                  ),
                  EzMaterialAction(
                    onPressed: () => Navigator.of(alertContext).pop(),
                    text: 'Nothing',
                  ),
                ],
                cupertinoActions: <EzCupertinoAction>[
                  EzCupertinoAction(
                    onPressed: () async {
                      clearForms();
                      if (alertContext.mounted) {
                        Navigator.of(alertContext).pop();
                      }
                    },
                    text: 'Builder values',
                    isDefaultAction: true,
                  ),
                  EzCupertinoAction(
                    onPressed: () async {
                      await EzConfig.reset();
                      if (alertContext.mounted) {
                        Navigator.of(alertContext).pop();
                      }
                    },
                    text: 'App settings',
                    isDestructiveAction: true,
                  ),
                  EzCupertinoAction(
                    onPressed: () async {
                      clearForms();
                      await EzConfig.reset();
                      if (alertContext.mounted) {
                        Navigator.of(alertContext).pop();
                      }
                    },
                    text: 'Both',
                    isDestructiveAction: true,
                  ),
                  EzCupertinoAction(
                    onPressed: () => Navigator.of(alertContext).pop(),
                    text: 'Nothing',
                  ),
                ],
                needsClose: false,
              );
            },
          ),
          child: EzIcon(PlatformIcons(context).refresh),
        ),
      ),
    );
  }
}
