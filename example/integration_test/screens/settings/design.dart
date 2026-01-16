/* open_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../utils/image_links.dart';

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

      // Load the app //

      ezLog('Loading OpenUI');
      await tester.pumpWidget(const OpenUI());
      await tester.pumpAndSettle();

      // Test navigation //

      ezLog('\nTesting navigation');

      await ezTouch(
        tester,
        find.widgetWithText(EzElevatedIconButton, EzConfig.l10n.dsPageTitle),
      );

      // Verify text loaded //

      ezLog('\nValidating text');
      await ezFindText(
        tester,
        EzConfig.l10n.gEditingTheme(EzConfig.l10n.gDark.toLowerCase()),
      );

      //* Test functionality *//

      // Background image  //

      ezLog('\nTesting background image setting');
      await testImageSetting(
        tester,
        finder: find.byType(EzImageSetting),
        type: EzConfig.l10n.dsBackgroundImg,
        updateCS: true,
        networkImageURLs: imageURLs,
      );

      // Reset button //

      await testResetButton(tester, type: RBType.design);

      // Reset for next test suite  //

      await ezTapBack(tester, EzConfig.l10n.gBack);
      ezLog('\nDesign settings test suite complete\n\n');
    });
