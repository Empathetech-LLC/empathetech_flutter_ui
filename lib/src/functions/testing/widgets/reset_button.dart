/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

enum RBType { all, text, layout, color, image }

/// For integration testing
/// Tests [EzResetButton]
Future<void> testResetButton(
  WidgetTester tester, {
  required RBType type,
  required EFUILang l10n,
  required bool isLefty,
}) async {
  ezLog('\nTesting reset button');
  await touch(tester, find.byType(EzResetButton));

  ezLog('Text');
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
  await validateText(tester, l10n.gUndoWarn);

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
  await touchText(tester, l10n.gNo);

  ezLog('Yes');
  await touch(tester, find.byType(EzResetButton));
  await touchText(tester, l10n.gYes);
}
