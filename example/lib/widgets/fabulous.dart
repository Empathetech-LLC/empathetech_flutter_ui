/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
    final TextStyle? style = Theme.of(context).textTheme.bodyLarge;

    return FloatingActionButton(
      onPressed: () => showPlatformDialog(
        context: context,
        builder: (BuildContext alertContext) {
          return EzAlertDialog(
            title: Text(
              '${l10n.gReset}...',
              textAlign: TextAlign.center,
            ),
            content: Text(
              l10n.gUndoWarn,
              textAlign: TextAlign.center,
            ),
            materialActions: <Widget>[
              EzTextButton(
                text: 'Builder values',
                textStyle: style,
                onPressed: () async {
                  clearForms();
                  if (alertContext.mounted) Navigator.of(alertContext).pop();
                },
              ),
              EzTextButton(
                text: 'App settings',
                textStyle: style,
                onPressed: () async {
                  await EzConfig.reset();
                  if (alertContext.mounted) Navigator.of(alertContext).pop();
                },
              ),
              EzTextButton(
                text: 'Both',
                textStyle: style,
                onPressed: () async {
                  clearForms();
                  await EzConfig.reset();
                  if (alertContext.mounted) Navigator.of(alertContext).pop();
                },
              ),
              EzTextButton(
                text: 'Nothing',
                textStyle: style,
                onPressed: () => Navigator.of(alertContext).pop(),
              ),
            ],
            cupertinoActions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                onPressed: () async {
                  clearForms();
                  if (alertContext.mounted) Navigator.of(alertContext).pop();
                },
                textStyle: style,
                child: const Text('Builder values'),
              ),
              CupertinoDialogAction(
                onPressed: () async {
                  await EzConfig.reset();
                  if (alertContext.mounted) Navigator.of(alertContext).pop();
                },
                textStyle: style,
                child: const Text('App settings'),
              ),
              CupertinoDialogAction(
                onPressed: () async {
                  clearForms();
                  await EzConfig.reset();
                  if (alertContext.mounted) Navigator.of(alertContext).pop();
                },
                textStyle: style,
                child: const Text('Both'),
              ),
              CupertinoDialogAction(
                onPressed: () => Navigator.of(alertContext).pop(),
                textStyle: style,
                child: const Text('Nothing'),
              ),
            ],
            needsClose: false,
          );
        },
      ),
      child: Icon(PlatformIcons(context).refresh),
    );
  }
}
