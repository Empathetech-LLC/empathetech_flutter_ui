/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../utils/image_links.dart';

import 'package:example/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

void testSuite({
  Locale locale = english,
  bool isLefty = false,
}) =>
    testWidgets('image-settings-screen', (WidgetTester tester) async {
      // Load localization(s) //

      testLog('Loading localizations');
      final EFUILang l10n = await EFUILang.delegate.load(locale);

      // Load the app //

      testLog('Loading OpenUI');
      await tester.pumpWidget(const OpenUI());
      await tester.pumpAndSettle();

      // Test navigation //

      testLog('\nTesting navigation');

      await touch(
        tester,
        find.widgetWithText(ElevatedButton, l10n.isPageTitle),
      );

      // Verify text loaded //

      testLog('\nValidating text');
      await validateText(
        tester,
        l10n.gEditingTheme(l10n.gDark.toLowerCase()),
      );

      //* Test functionality *//

      // Background image  //

      testLog('\nTesting background image setting');
      await testImageSetting(
        tester,
        finder: find.byType(EzImageSetting),
        type: l10n.isBackground,
        updateCS: true,
        l10n: l10n,
        networkImageURLs: imageURLs,
        isLefty: isLefty,
      );

      // Reset button //

      await testResetButton(
        tester,
        type: RBType.image,
        l10n: l10n,
        isLefty: isLefty,
      );

      // Reset for next test suite  //

      await goBack(tester, l10n.gBack);
      testLog('\nImage settings test suite complete\n\n');
    });
