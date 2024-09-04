/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../export.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

enum RBType { all, text, layout, color, image }

Future<void> testResetButton(
  WidgetTester tester, {
  required RBType type,
  required EFUILang l10n,
  required bool isLefty,
}) async {
  debugPrint('\nTesting reset button');
  await touch(tester, find.byType(EzResetButton));

  debugPrint('Validating text');
  switch (type) {
    case RBType.all:
      await validateText(tester, l10n.gResetAll);
      break;
    case RBType.text:
      await validateText(tester, l10n.tsResetAll);
      break;
    case RBType.layout:
      await validateText(tester, l10n.lsResetAll);
      break;
    case RBType.color:
      await validateText(tester, l10n.csResetAll(l10n.gDark.toLowerCase()));
      break;
    case RBType.image:
      await validateText(tester, l10n.isResetAll(l10n.gDark.toLowerCase()));
      break;
  }
  await validateText(tester, l10n.gResetWarn);

  debugPrint('Validating layout');
  final bool isCupertino = !kIsWeb && (Platform.isIOS || Platform.isMacOS);

  if (isCupertino) {
    final List<CupertinoDialogAction> actions =
        (tester.widget(find.byType(EzAlertDialog)) as EzAlertDialog)
            .cupertinoActions!;

    expect(actions.length, 2);
    if (isLefty) {
      expect(actions[0].child.toString(), Text(l10n.gYes).toString());
      expect(actions[1].child.toString(), Text(l10n.gNo).toString());
    } else {
      expect(actions[0].child.toString(), Text(l10n.gNo).toString());
      expect(actions[1].child.toString(), Text(l10n.gYes).toString());
    }
  } else {
    final List<TextButton> actions =
        (tester.widget(find.byType(EzAlertDialog)) as EzAlertDialog)
            .materialActions! as List<TextButton>;

    expect(actions.length, 2);
    if (isLefty) {
      expect(actions[0].child.toString(), Text(l10n.gYes).toString());
      expect(actions[1].child.toString(), Text(l10n.gNo).toString());
    } else {
      expect(actions[0].child.toString(), Text(l10n.gNo).toString());
      expect(actions[1].child.toString(), Text(l10n.gYes).toString());
    }
  }

  debugPrint('Test No');
  await touchAtText(tester, l10n.gNo);

  debugPrint('Test Yes');
  await touch(tester, find.byType(EzResetButton));
  await touchAtText(tester, l10n.gYes);
}
