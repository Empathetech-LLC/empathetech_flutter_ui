/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// For integration testing
/// Tests [EzImageSetting]
Future<void> testImageSetting(
  WidgetTester tester, {
  required Finder finder,
  required String type,
  required bool updateCS,
  required EFUILang l10n,
  required List<String> networkImageURLs,
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
      assert(
        tester.getCenter(find.byType(Checkbox)).dx <
            tester.getCenter(find.text(l10n.isUseForColors)).dx,
        'DH layout mismatch',
      );
    } else {
      assert(
        tester.getCenter(find.byType(Checkbox)).dx >
            tester.getCenter(find.text(l10n.isUseForColors)).dx,
        'DH layout mismatch',
      );
    }

    await validateText(tester, l10n.isUseForColors);
  }

  debugPrint('Validating platform options\n');
  if (kIsWeb) {
    await _webTests(
      tester,
      finder: finder,
      l10n: l10n,
      imageURLs: networkImageURLs,
      isLefty: isLefty,
    );
  } else if (Platform.isIOS || Platform.isAndroid) {
    await _mobileTests(
      tester,
      finder: finder,
      l10n: l10n,
      imageURLs: networkImageURLs,
      isLefty: isLefty,
    );
  } else {
    await _desktopTests(
      tester,
      finder: finder,
      l10n: l10n,
      imageURLs: networkImageURLs,
      isLefty: isLefty,
    );
  }
}

/// Web sub-set of [testImageSetting]
Future<void> _webTests(
  WidgetTester tester, {
  required Finder finder,
  required EFUILang l10n,
  required List<String> imageURLs,
  required bool isLefty,
}) async {
  debugPrint('Detected web');

  debugPrint('\nFrom network');
  await _testNetwork(
    tester,
    l10n: l10n,
    imageURLs: imageURLs,
    isLefty: isLefty,
    isCupertino: false,
  );
  await touch(tester, finder);

  // ToDo: Reset catch
  debugPrint('\nClear');
  await touch(tester, find.byIcon(Icons.clear));
  expect(find.byIcon(Icons.edit), findsOneWidget);
  await touch(tester, finder);

  debugPrint('\nClose');
  await touchText(tester, l10n.gClose);
}

/// Mobile (Android, iOS) sub-set of [testImageSetting]
Future<void> _mobileTests(
  WidgetTester tester, {
  required Finder finder,
  required EFUILang l10n,
  required List<String> imageURLs,
  required bool isLefty,
}) async {
  debugPrint('Detected mobile');

  final bool isCupertino = Platform.isIOS;
  debugPrint(isCupertino ? 'iOS' : 'Android');

  debugPrint('\nFrom file');
  await _testFile(tester,
      l10n: l10n, isLefty: isLefty, isCupertino: isCupertino);
  await touch(tester, finder);

  debugPrint('\nFrom camera');
  await _testCamera(
    tester,
    l10n: l10n,
    isLefty: isLefty,
    isCupertino: isCupertino,
  );
  await touch(tester, finder);

  debugPrint('\nFrom network');
  await _testNetwork(
    tester,
    l10n: l10n,
    imageURLs: imageURLs,
    isLefty: isLefty,
    isCupertino: isCupertino,
  );
  await touch(tester, finder);

  // ToDo: Reset catch
  debugPrint('\nClear');
  await touch(
    tester,
    find.byIcon(isCupertino ? CupertinoIcons.clear : Icons.clear),
  );
  expect(
    find.byIcon(isCupertino ? CupertinoIcons.pencil : Icons.edit),
    findsOneWidget,
  );
  await touch(tester, finder);

  debugPrint('\nClose');
  await touchText(tester, l10n.gClose);
}

/// Desktop (Linux, MacOS, Windows) sub-set of [testImageSetting]
Future<void> _desktopTests(
  WidgetTester tester, {
  required Finder finder,
  required EFUILang l10n,
  required List<String> imageURLs,
  required bool isLefty,
}) async {
  debugPrint('Detected desktop');

  final bool isCupertino = Platform.isMacOS;
  debugPrint(isCupertino ? 'Mac' : 'Not Mac');

  debugPrint('\nFrom file');
  await _testFile(
    tester,
    l10n: l10n,
    isLefty: isLefty,
    isCupertino: isCupertino,
  );
  await touch(tester, finder);

  debugPrint('\nFrom network');
  await _testNetwork(
    tester,
    l10n: l10n,
    imageURLs: imageURLs,
    isLefty: isLefty,
    isCupertino: isCupertino,
  );
  await touch(tester, finder);

  // ToDo: Reset catch
  debugPrint('\nClear');
  await touch(
    tester,
    find.byIcon(Platform.isIOS ? CupertinoIcons.clear : Icons.clear),
  );
  expect(
    find.byIcon(isCupertino ? CupertinoIcons.pencil : Icons.edit),
    findsOneWidget,
  );
  await touch(tester, finder);

  debugPrint('\nClose');
  await touchText(tester, l10n.gClose);
}

Future<void> _testFile(
  WidgetTester tester, {
  required EFUILang l10n,
  required bool isLefty,
  required bool isCupertino,
}) async {
  expect(
    find.byIcon(isCupertino ? CupertinoIcons.folder : Icons.folder),
    findsOneWidget,
  );
  await touchText(tester, l10n.gClose);
}

Future<void> _testCamera(
  WidgetTester tester, {
  required EFUILang l10n,
  required bool isLefty,
  required bool isCupertino,
}) async {
  expect(
    find.byIcon(isCupertino ? CupertinoIcons.photo_camera : Icons.photo_camera),
    findsOneWidget,
  );
  await touchText(tester, l10n.gClose);
}

Future<void> _testNetwork(
  WidgetTester tester, {
  required EFUILang l10n,
  required List<String> imageURLs,
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

  debugPrint('Cancel');
  await touchText(tester, l10n.gCancel);

  debugPrint('Apply w/ invalid URL');
  await touch(tester, find.byIcon(Icons.computer_outlined));
  await tester.enterText(find.byType(PlatformTextFormField), 'invalid');
  await touchText(tester, l10n.gApply);

  debugPrint('Apply w/ valid URL');
  await tester.enterText(
    find.byType(PlatformTextFormField),
    getRandomURL(imageURLs),
  );
  await touchText(tester, l10n.gApply);
  expect(
    find.byIcon(isCupertino ? CupertinoIcons.pencil : Icons.edit),
    findsNothing,
  );
}

/// Provide a [List] of [imageURLs] and one will be returned at random
String getRandomURL(List<String> imageURLs) {
  final int choice = Random().nextInt(imageURLs.length);
  return imageURLs[choice];
}
