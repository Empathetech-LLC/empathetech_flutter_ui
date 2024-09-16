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

      debugPrint('Loading localizations');
      final EFUILang l10n = await EFUILang.delegate.load(locale);

      // Load the app //

      debugPrint('Loading OpenUI');
      await tester.pumpWidget(const OpenUI());
      await tester.pumpAndSettle();

      // Test navigation //

      debugPrint('\nTesting navigation');

      await touch(
        tester,
        find.widgetWithText(ElevatedButton, l10n.lsPageTitle),
      );

      // Verify text loaded //

      debugPrint('\nValidating text');
      await validateText(tester, l10n.gHowThisWorks);
      // ToDo: Validate link

      //* Test functionality *//

      // Margin //
      debugPrint('\nTesting margin');
      await touch(tester, find.byType(EzLayoutSetting).at(0));

      debugPrint('Slider');
      await chaChaNow(tester, find.byType(Slider));

      debugPrint('Reset');
      final bool isCupertino = !kIsWeb && (Platform.isIOS || Platform.isMacOS);
      if (isCupertino) {
        await touch(tester, find.byIcon(CupertinoIcons.refresh).last);
      } else {
        await touch(tester, find.byIcon(Icons.refresh).last);
      }

      debugPrint('Dismissing');
      await dismissTap(tester);

      // Padding //
      debugPrint('\nTesting padding');
      await touch(tester, find.byType(EzLayoutSetting).at(1));

      debugPrint('Slider');
      await chaChaNow(tester, find.byType(Slider));

      debugPrint('Reset');
      if (isCupertino) {
        await touch(tester, find.byIcon(CupertinoIcons.refresh).last);
      } else {
        await touch(tester, find.byIcon(Icons.refresh).last);
      }

      debugPrint('Dismissing');
      await dismissTap(tester);

      // Spacing //
      debugPrint('\nTesting spacing');
      await touch(tester, find.byType(EzLayoutSetting).at(2));

      debugPrint('Slider');
      await chaChaNow(tester, find.byType(Slider));

      debugPrint('Reset');
      if (isCupertino) {
        await touch(tester, find.byIcon(CupertinoIcons.refresh).last);
      } else {
        await touch(tester, find.byIcon(Icons.refresh).last);
      }

      debugPrint('Dismissing');
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
      debugPrint('\nLayout settings test suite complete\n\n');
    });
