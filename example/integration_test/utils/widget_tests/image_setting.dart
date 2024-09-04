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
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

Future<void> testImageSetting(
  WidgetTester tester, {
  required Finder finder,
  required String type,
  required EFUILang l10n,
  required bool isLefty,
}) async {
  await touch(tester, finder);

  debugPrint('Validating text');
  await validateText(tester, l10n.isDialogTitle(type));
  await validateText(tester, l10n.isUseForColors);

  debugPrint('Validating platform options');
  if (kIsWeb) {
    await webTests(tester, finder, l10n, isLefty);
  } else if (Platform.isIOS || Platform.isAndroid) {
    await mobileTests(tester, finder, l10n, isLefty);
  } else {
    await desktopTests(tester, finder, l10n, isLefty);
  }
}

Future<void> webTests(
  WidgetTester tester,
  Finder finder,
  EFUILang l10n,
  bool isLefty,
) async {
  debugPrint('Detected web');

  debugPrint('From network');
  await testNetwork(tester, l10n, isLefty, false);
  await touch(tester, finder);

  debugPrint('Clear');
  await touch(tester, find.byIcon(Icons.clear));
  await touch(tester, finder);

  debugPrint('Close');
  await touchAtText(tester, l10n.gClose);
}

Future<void> mobileTests(
  WidgetTester tester,
  Finder finder,
  EFUILang l10n,
  bool isLefty,
) async {
  debugPrint('Detected mobile');

  final bool isCupertino = Platform.isIOS;
  debugPrint(isCupertino ? 'iOS' : 'Android');

  debugPrint('From file');
  await testFile(tester, l10n, isLefty, isCupertino);
  await touch(tester, finder);

  debugPrint('From camera');
  await testCamera(tester, l10n, isLefty, isCupertino);
  await touch(tester, finder);

  debugPrint('From network');
  await testNetwork(tester, l10n, isLefty, isCupertino);
  await touch(tester, finder);

  debugPrint('Clear');
  await touch(
    tester,
    find.byIcon(isCupertino ? CupertinoIcons.clear : Icons.clear),
  );
  await touch(tester, finder);

  debugPrint('Close');
  await touchAtText(tester, l10n.gClose);
}

Future<void> desktopTests(
  WidgetTester tester,
  Finder finder,
  EFUILang l10n,
  bool isLefty,
) async {
  debugPrint('Detected desktop');

  final bool isCupertino = Platform.isMacOS;
  debugPrint(isCupertino ? 'Mac' : 'Not Mac');

  debugPrint('From file');
  await testFile(tester, l10n, isLefty, isCupertino);
  await touch(tester, finder);

  debugPrint('From network');
  await testNetwork(tester, l10n, isLefty, isCupertino);
  await touch(tester, finder);

  debugPrint('Clear');
  await touch(
    tester,
    find.byIcon(Platform.isIOS ? CupertinoIcons.clear : Icons.clear),
  );
  await touch(tester, finder);

  debugPrint('Close');
  await touchAtText(tester, l10n.gClose);
}

Future<void> testFile(
  WidgetTester tester,
  EFUILang l10n,
  bool isLefty,
  bool isCupertino,
) async {
  await touchAtText(tester, l10n.gClose);
}

Future<void> testCamera(
  WidgetTester tester,
  EFUILang l10n,
  bool isLefty,
  bool isCupertino,
) async {
  await touchAtText(tester, l10n.gClose);
}

Future<void> testNetwork(
  WidgetTester tester,
  EFUILang l10n,
  bool isLefty,
  bool isCupertino,
) async {
  await touch(tester, find.byIcon(Icons.computer_outlined));

  debugPrint('Validating text');
  await validateText(tester, l10n.isEnterURL);

  debugPrint('Validating layout');
  if (isCupertino) {
    final List<CupertinoDialogAction> actions =
        (tester.widget(find.byType(EzAlertDialog).last) as EzAlertDialog)
            .cupertinoActions!;

    expect(actions.length, 2);
    if (isLefty) {
      expect(actions[0].child.toString(), Text(l10n.gApply).toString());
      expect(actions[1].child.toString(), Text(l10n.gCancel).toString());
    } else {
      expect(actions[0].child.toString(), Text(l10n.gCancel).toString());
      expect(actions[1].child.toString(), Text(l10n.gApply).toString());
    }
  } else {
    final List<TextButton> actions =
        (tester.widget(find.byType(EzAlertDialog).last) as EzAlertDialog)
            .materialActions! as List<TextButton>;

    expect(actions.length, 2);
    if (isLefty) {
      expect(actions[0].child.toString(), Text(l10n.gApply).toString());
      expect(actions[1].child.toString(), Text(l10n.gCancel).toString());
    } else {
      expect(actions[0].child.toString(), Text(l10n.gCancel).toString());
      expect(actions[1].child.toString(), Text(l10n.gApply).toString());
    }
  }

  debugPrint('Test cancel');
  await touchAtText(tester, l10n.gCancel);

  debugPrint('Test apply - invalid URL');
  await touch(tester, find.byIcon(Icons.computer_outlined));
  await tester.enterText(find.byType(PlatformTextFormField), 'invalid');
  await touchAtText(tester, l10n.gApply);

  debugPrint('Test apply - valid URL');
  await tester.enterText(
    find.byType(PlatformTextFormField),
    etechGHProfileLink,
  );
  await touchAtText(tester, l10n.gApply);
}
