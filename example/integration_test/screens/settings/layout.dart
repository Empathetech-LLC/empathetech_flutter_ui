/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:example/main.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

void testSuite({
  Locale locale = english,
  bool isLefty = false,
}) =>
    testWidgets('layout-settings-screen', (WidgetTester tester) async {
      // Load localization(s) //

      ezLog('Loading localizations');

      // Load the app //

      ezLog('Loading OpenUI');
      await tester.pumpWidget(const OpenUI());
      await tester.pumpAndSettle();

      // Test navigation //

      ezLog('\nTesting navigation');

      await ezTouch(
        tester,
        find.widgetWithText(EzElevatedIconButton, EzConfig.l10n.lsPageTitle),
      );

      //* Test functionality *//

      // Margin //
      ezLog('\nTesting margin');
      await ezTouch(tester, find.byType(EzLayoutSetting).at(0));

      ezLog('Slider');
      await ezChaCha(tester, find.byType(Slider));

      ezLog('Reset');
      final bool isCupertino = !kIsWeb && (Platform.isIOS || Platform.isMacOS);
      if (isCupertino) {
        await ezTouch(tester, find.byIcon(CupertinoIcons.refresh).last);
      } else {
        await ezTouch(tester, find.byIcon(Icons.refresh).last);
      }

      ezLog('Dismissing');
      await ezDismiss(tester);

      // Padding //
      ezLog('\nTesting padding');
      await ezTouch(tester, find.byType(EzLayoutSetting).at(1));

      ezLog('Slider');
      await ezChaCha(tester, find.byType(Slider));

      ezLog('Reset');
      if (isCupertino) {
        await ezTouch(tester, find.byIcon(CupertinoIcons.refresh).last);
      } else {
        await ezTouch(tester, find.byIcon(Icons.refresh).last);
      }

      ezLog('Dismissing');
      await ezDismiss(tester);

      // Spacing //
      ezLog('\nTesting spacing');
      await ezTouch(tester, find.byType(EzLayoutSetting).at(2));

      ezLog('Slider');
      await ezChaCha(tester, find.byType(Slider));

      ezLog('Reset');
      if (isCupertino) {
        await ezTouch(tester, find.byIcon(CupertinoIcons.refresh).last);
      } else {
        await ezTouch(tester, find.byIcon(Icons.refresh).last);
      }

      ezLog('Dismissing');
      await ezDismiss(tester);

      // Reset button //

      await testResetButton(tester, type: RBType.layout);

      // Reset for next test suite  //

      await ezTapBack(tester, EzConfig.l10n.gBack);
      ezLog('\nLayout settings test suite complete\n\n');
    });
