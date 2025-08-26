/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
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
    testWidgets('design-settings-screen', (WidgetTester tester) async {
      // Load localization(s) //

      ezLog('Loading localizations');
      final EFUILang l10n = await EFUILang.delegate.load(locale);

      // Load the app //

      ezLog('Loading OpenUI');
      await tester.pumpWidget(const OpenUI());
      await tester.pumpAndSettle();

      // Test navigation //

      ezLog('\nTesting navigation');

      await ezTouch(
        tester,
        find.widgetWithText(EzElevatedIconButton, l10n.dsPageTitle),
      );

      // Verify text loaded //

      ezLog('\nValidating text');
      await ezFindText(
        tester,
        l10n.gEditingTheme(l10n.gDark.toLowerCase()),
      );

      //* Test functionality *//

      // Background image  //

      ezLog('\nTesting background image setting');
      await testImageSetting(
        tester,
        finder: find.byType(EzImageSetting),
        type: l10n.dsBackground,
        updateCS: true,
        l10n: l10n,
        networkImageURLs: imageURLs,
        isLefty: isLefty,
      );

      // Reset button //

      await testResetButton(
        tester,
        type: RBType.design,
        l10n: l10n,
        isLefty: isLefty,
      );

      // Reset for next test suite  //

      await ezTapBack(tester, l10n.gBack);
      ezLog('\nDesign settings test suite complete\n\n');
    });
