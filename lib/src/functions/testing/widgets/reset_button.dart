/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter_test/flutter_test.dart';

enum RBType { all, color, design, layout, text }

/// For integration testing
/// Tests [EzResetButton]
Future<void> testResetButton(
  WidgetTester tester, {
  required RBType type,
}) async {
  ezLog('\nTesting reset button');
  await ezTouch(tester, find.byType(EzResetButton));

  ezLog('Text');
  switch (type) {
    case RBType.all:
      await ezFindText(tester, EzConfig.l10n.gResetAll);
      break;
    case RBType.color:
      await ezFindText(
          tester, EzConfig.l10n.csReset(EzConfig.l10n.gDark.toLowerCase()));
      break;
    case RBType.design:
      await ezFindText(
          tester, EzConfig.l10n.dsReset(EzConfig.l10n.gDark.toLowerCase()));
      break;
    case RBType.layout:
      await ezFindText(tester, EzConfig.l10n.lsResetAll);
      break;
    case RBType.text:
      await ezFindText(tester, EzConfig.l10n.tsResetAll);
      break;
  }
  await ezFindText(tester, EzConfig.l10n.gUndoWarn1);

  ezLog('Layout');

  final List<EzTextButton> actions =
      (tester.widget(find.byType(EzAlertDialog)) as EzAlertDialog).actions!
          as List<EzTextButton>;

  expect(actions.length, 2);
  if (EzConfig.isLefty) {
    expect(actions[0].text, EzConfig.l10n.gYes);
    expect(actions[1].text, EzConfig.l10n.gNo);
  } else {
    expect(actions[0].text, EzConfig.l10n.gNo);
    expect(actions[1].text, EzConfig.l10n.gYes);
  }

  ezLog('No');
  await ezTouchText(tester, EzConfig.l10n.gNo);

  ezLog('Yes');
  await ezTouch(tester, find.byType(EzResetButton));
  await ezTouchText(tester, EzConfig.l10n.gYes);
}
