/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
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
      final EFUILang l10n = await EFUILang.delegate.load(locale);

      // Load the app //

      ezLog('Loading OpenUI');
      await tester.pumpWidget(const OpenUI());
      await tester.pumpAndSettle();

      // Test navigation //

      ezLog('\nTesting navigation');

      await touch(
        tester,
        find.widgetWithText(EzElevatedIconButton, l10n.lsPageTitle),
      );

      // Verify text loaded //

      ezLog('\nValidating text');
      await validateText(tester, l10n.gHowThisWorks);

      //* Test functionality *//

      // Margin //
      ezLog('\nTesting margin');
      await touch(tester, find.byType(EzLayoutSetting).at(0));

      ezLog('Slider');
      await chaChaNow(tester, find.byType(Slider));

      ezLog('Reset');
      final bool isCupertino = !kIsWeb && (Platform.isIOS || Platform.isMacOS);
      if (isCupertino) {
        await touch(tester, find.byIcon(CupertinoIcons.refresh).last);
      } else {
        await touch(tester, find.byIcon(Icons.refresh).last);
      }

      ezLog('Dismissing');
      await dismissTap(tester);

      // Padding //
      ezLog('\nTesting padding');
      await touch(tester, find.byType(EzLayoutSetting).at(1));

      ezLog('Slider');
      await chaChaNow(tester, find.byType(Slider));

      ezLog('Reset');
      if (isCupertino) {
        await touch(tester, find.byIcon(CupertinoIcons.refresh).last);
      } else {
        await touch(tester, find.byIcon(Icons.refresh).last);
      }

      ezLog('Dismissing');
      await dismissTap(tester);

      // Spacing //
      ezLog('\nTesting spacing');
      await touch(tester, find.byType(EzLayoutSetting).at(2));

      ezLog('Slider');
      await chaChaNow(tester, find.byType(Slider));

      ezLog('Reset');
      if (isCupertino) {
        await touch(tester, find.byIcon(CupertinoIcons.refresh).last);
      } else {
        await touch(tester, find.byIcon(Icons.refresh).last);
      }

      ezLog('Dismissing');
      await dismissTap(tester);

      // Reset button //

      await testResetButton(
        tester,
        type: RBType.layout,
        l10n: l10n,
        isLefty: isLefty,
      );

      // Reset for next test suite  //

      await goBack(tester, l10n.gBack);
      ezLog('\nLayout settings test suite complete\n\n');
    });
