/* open_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/export.dart';

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
    final EFUILang el10n = EFUILang.of(context)!;
    final Lang l10n = Lang.of(context)!;

    return Tooltip(
      message: el10n.gReset,
      excludeFromSemantics: true,
      child: Semantics(
        label: el10n.gReset,
        button: true,
        hint: l10n.csResetHint,
        child: ExcludeSemantics(
          child: FloatingActionButton(
            onPressed: () => showPlatformDialog(
              context: context,
              builder: (BuildContext alertContext) {
                return EzAlertDialog(
                  title:
                      Text('${el10n.gReset}...', textAlign: TextAlign.center),
                  materialActions: <Widget>[
                    EzMaterialAction(
                      onPressed: () async {
                        clearForms();
                        if (alertContext.mounted) {
                          Navigator.of(alertContext).pop();
                        }
                      },
                      text: l10n.csResetBuilder,
                      isDefaultAction: true,
                    ),
                    EzMaterialAction(
                      onPressed: () async {
                        await EzConfig.reset();
                        if (alertContext.mounted) {
                          Navigator.of(alertContext).pop();
                        }
                      },
                      text: l10n.csResetApp,
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
                      text: l10n.csResetBoth,
                      isDestructiveAction: true,
                    ),
                    EzMaterialAction(
                      onPressed: () => Navigator.of(alertContext).pop(),
                      text: l10n.csResetNothing,
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
                      text: l10n.csResetBuilder,
                      isDefaultAction: true,
                    ),
                    EzCupertinoAction(
                      onPressed: () async {
                        await EzConfig.reset();
                        if (alertContext.mounted) {
                          Navigator.of(alertContext).pop();
                        }
                      },
                      text: l10n.csResetApp,
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
                      text: l10n.csResetBoth,
                      isDestructiveAction: true,
                    ),
                    EzCupertinoAction(
                      onPressed: () => Navigator.of(alertContext).pop(),
                      text: l10n.csResetNothing,
                    ),
                  ],
                  needsClose: false,
                );
              },
            ),
            child: EzIcon(PlatformIcons(context).refresh),
          ),
        ),
      ),
    );
  }
}
