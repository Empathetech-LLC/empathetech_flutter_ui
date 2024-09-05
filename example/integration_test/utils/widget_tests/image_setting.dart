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
  required bool updateCS,
  required EFUILang l10n,
  required bool isLefty,
}) async {
  debugPrint('Opening dialog');
  await touch(tester, finder);

  debugPrint('Validating text');
  await validateText(tester, l10n.isDialogTitle(type));

  if (updateCS) {
    final List<Widget> updateCSWidgets =
        (tester.widget(find.byType(EzRow).first) as EzRow).children;

    expect(updateCSWidgets.length, 2);
    if (isLefty) {
      expect(updateCSWidgets[0], isA<Flexible>());
      expect(updateCSWidgets[1], isA<Checkbox>());
    } else {
      expect(updateCSWidgets[0], isA<Checkbox>());
      expect(updateCSWidgets[1], isA<Flexible>());
    }

    await validateText(tester, l10n.isUseForColors);
  }

  debugPrint('Validating platform options');
  if (kIsWeb) {
    await webTests(tester, finder: finder, l10n: l10n, isLefty: isLefty);
  } else if (Platform.isIOS || Platform.isAndroid) {
    await mobileTests(tester, finder: finder, l10n: l10n, isLefty: isLefty);
  } else {
    await desktopTests(tester, finder: finder, l10n: l10n, isLefty: isLefty);
  }
}

Future<void> webTests(
  WidgetTester tester, {
  required Finder finder,
  required EFUILang l10n,
  required bool isLefty,
}) async {
  debugPrint('Detected web');

  debugPrint('From network');
  await testNetwork(tester, l10n: l10n, isLefty: isLefty, isCupertino: false);
  await touch(tester, finder);

  // ToDo: Reset catch
  debugPrint('Clear');
  await touch(tester, find.byIcon(Icons.clear));
  expect(find.byIcon(Icons.edit), findsOneWidget);
  await touch(tester, finder);

  debugPrint('Close');
  await touchAtText(tester, l10n.gClose);
}

Future<void> mobileTests(
  WidgetTester tester, {
  required Finder finder,
  required EFUILang l10n,
  required bool isLefty,
}) async {
  debugPrint('Detected mobile');

  final bool isCupertino = Platform.isIOS;
  debugPrint(isCupertino ? 'iOS' : 'Android');

  debugPrint('From file');
  await testFile(tester,
      l10n: l10n, isLefty: isLefty, isCupertino: isCupertino);
  await touch(tester, finder);

  debugPrint('From camera');
  await testCamera(
    tester,
    l10n: l10n,
    isLefty: isLefty,
    isCupertino: isCupertino,
  );
  await touch(tester, finder);

  debugPrint('From network');
  await testNetwork(
    tester,
    l10n: l10n,
    isLefty: isLefty,
    isCupertino: isCupertino,
  );
  await touch(tester, finder);

  // ToDo: Reset catch
  debugPrint('Clear');
  await touch(
    tester,
    find.byIcon(isCupertino ? CupertinoIcons.clear : Icons.clear),
  );
  expect(
    find.byIcon(isCupertino ? CupertinoIcons.pencil : Icons.edit),
    findsOneWidget,
  );
  await touch(tester, finder);

  debugPrint('Close');
  await touchAtText(tester, l10n.gClose);
}

Future<void> desktopTests(
  WidgetTester tester, {
  required Finder finder,
  required EFUILang l10n,
  required bool isLefty,
}) async {
  debugPrint('Detected desktop');

  final bool isCupertino = Platform.isMacOS;
  debugPrint(isCupertino ? 'Mac' : 'Not Mac');

  debugPrint('From file');
  await testFile(
    tester,
    l10n: l10n,
    isLefty: isLefty,
    isCupertino: isCupertino,
  );
  await touch(tester, finder);

  debugPrint('From network');
  await testNetwork(
    tester,
    l10n: l10n,
    isLefty: isLefty,
    isCupertino: isCupertino,
  );
  await touch(tester, finder);

  // ToDo: Reset catch
  debugPrint('Clear');
  await touch(
    tester,
    find.byIcon(Platform.isIOS ? CupertinoIcons.clear : Icons.clear),
  );
  expect(
    find.byIcon(isCupertino ? CupertinoIcons.pencil : Icons.edit),
    findsOneWidget,
  );
  await touch(tester, finder);

  debugPrint('Close');
  await touchAtText(tester, l10n.gClose);
}

Future<void> testFile(
  WidgetTester tester, {
  required EFUILang l10n,
  required bool isLefty,
  required bool isCupertino,
}) async {
  expect(
    find.byIcon(isCupertino ? CupertinoIcons.folder : Icons.folder),
    findsOneWidget,
  );
  await touchAtText(tester, l10n.gClose);
}

Future<void> testCamera(
  WidgetTester tester, {
  required EFUILang l10n,
  required bool isLefty,
  required bool isCupertino,
}) async {
  expect(
    find.byIcon(isCupertino ? CupertinoIcons.photo_camera : Icons.photo_camera),
    findsOneWidget,
  );
  await touchAtText(tester, l10n.gClose);
}

Future<void> testNetwork(
  WidgetTester tester, {
  required EFUILang l10n,
  required bool isLefty,
  required bool isCupertino,
}) async {
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
    getImageUrl(),
  );
  await touchAtText(tester, l10n.gApply);
  expect(
    find.byIcon(isCupertino ? CupertinoIcons.pencil : Icons.edit),
    findsNothing,
  );
}
