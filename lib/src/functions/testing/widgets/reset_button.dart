/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

enum RBType { all, color, design, layout, text }

/// For integration testing
/// Tests [EzResetButton]
Future<void> testResetButton(
  WidgetTester tester, {
  required RBType type,
  required EFUILang l10n,
  required bool isLefty,
}) async {
  ezLog('\nTesting reset button');
  await ezTouch(tester, find.byType(EzResetButton));

  ezLog('Text');
  switch (type) {
    case RBType.all:
      await ezFindText(tester, l10n.gResetAll);
      break;
    case RBType.color:
      await ezFindText(tester, l10n.csResetAll(l10n.gDark.toLowerCase()));
      break;
    case RBType.design:
      await ezFindText(tester, l10n.dsResetAll(l10n.gDark.toLowerCase()));
      break;
    case RBType.layout:
      await ezFindText(tester, l10n.lsResetAll);
      break;
    case RBType.text:
      await ezFindText(tester, l10n.tsResetAll);
      break;
  }
  await ezFindText(tester, l10n.gUndoWarn1);

  ezLog('Layout');
  final bool isCupertino = !kIsWeb && (Platform.isIOS || Platform.isMacOS);

  if (isCupertino) {
    final List<EzCupertinoAction> actions =
        (tester.widget(find.byType(EzAlertDialog)) as EzAlertDialog)
            .cupertinoActions! as List<EzCupertinoAction>;

    expect(actions.length, 2);
    if (isLefty) {
      expect(actions[0].text, l10n.gYes);
      expect(actions[1].text, l10n.gNo);
    } else {
      expect(actions[0].text, l10n.gNo);
      expect(actions[1].text, l10n.gYes);
    }
  } else {
    final List<EzTextButton> actions =
        (tester.widget(find.byType(EzAlertDialog)) as EzAlertDialog)
            .materialActions! as List<EzTextButton>;

    expect(actions.length, 2);
    if (isLefty) {
      expect(actions[0].text, l10n.gYes);
      expect(actions[1].text, l10n.gNo);
    } else {
      expect(actions[0].text, l10n.gNo);
      expect(actions[1].text, l10n.gYes);
    }
  }

  ezLog('No');
  await ezTouchText(tester, l10n.gNo);

  ezLog('Yes');
  await ezTouch(tester, find.byType(EzResetButton));
  await ezTouchText(tester, l10n.gYes);
}
