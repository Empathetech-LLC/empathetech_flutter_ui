/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

/// For integration testing
/// Tests [EzImageSetting]
Future<void> testImageSetting(
  WidgetTester tester, {
  required Finder finder,
  required String type,
  required bool updateCS,
  required List<String> networkImageURLs,
}) async {
  ezLog('Opening dialog');
  await ezTouch(tester, finder);

  ezLog('Validating text');

  if (updateCS) {
    final List<Widget> updateCSWidgets =
        (tester.widget(find.byType(EzRow).first) as EzRow).children;

    expect(updateCSWidgets.length, 2);
    if (EzConfig.isLefty) {
      assert(
        tester.getCenter(find.byType(Checkbox)).dx <
            tester.getCenter(find.text(EzConfig.l10n.dsUseForColors)).dx,
        'DH layout mismatch',
      );
    } else {
      assert(
        tester.getCenter(find.byType(Checkbox)).dx >
            tester.getCenter(find.text(EzConfig.l10n.dsUseForColors)).dx,
        'DH layout mismatch',
      );
    }

    await ezFindText(tester, EzConfig.l10n.dsUseForColors);
  }

  ezLog('Validating platform options\n');
  if (kIsWeb) {
    await _webTests(
      tester,
      finder: finder,
      imageURLs: networkImageURLs,
    );
  } else if (Platform.isIOS || Platform.isAndroid) {
    await _mobileTests(
      tester,
      finder: finder,
      imageURLs: networkImageURLs,
    );
  } else {
    await _desktopTests(
      tester,
      finder: finder,
      imageURLs: networkImageURLs,
    );
  }
}

/// Web sub-set of [testImageSetting]
Future<void> _webTests(
  WidgetTester tester, {
  required Finder finder,
  required List<String> imageURLs,
}) async {
  ezLog('Detected web');

  ezLog('\nFrom network');
  await _testNetwork(tester, imageURLs: imageURLs);
  await ezTouch(tester, finder);

  ezLog('\nClear');
  await ezTouch(tester, find.byIcon(Icons.clear));
  expect(find.byIcon(Icons.edit), findsOneWidget);
  await ezTouch(tester, finder);

  ezLog('\nClose');
  await ezTouchText(tester, EzConfig.l10n.gClose);
}

/// Mobile (Android, iOS) sub-set of [testImageSetting]
Future<void> _mobileTests(
  WidgetTester tester, {
  required Finder finder,
  required List<String> imageURLs,
}) async {
  ezLog('Detected mobile');

  final bool isCupertino = Platform.isIOS;
  ezLog(isCupertino ? 'iOS' : 'Android');

  ezLog('\nFrom file');
  await _testFile(tester, isCupertino: isCupertino);
  await ezTouch(tester, finder);

  ezLog('\nFrom camera');
  await _testCamera(
    tester,
    isCupertino: isCupertino,
  );
  await ezTouch(tester, finder);

  ezLog('\nFrom network');
  await _testNetwork(tester, imageURLs: imageURLs);
  await ezTouch(tester, finder);

  ezLog('\nClear');
  await ezTouch(
    tester,
    find.byIcon(isCupertino ? CupertinoIcons.clear : Icons.clear),
  );
  expect(
    find.byIcon(isCupertino ? CupertinoIcons.pencil : Icons.edit),
    findsOneWidget,
  );
  await ezTouch(tester, finder);

  ezLog('\nClose');
  await ezTouchText(tester, EzConfig.l10n.gClose);
}

/// Desktop (Linux, macOS, Windows) sub-set of [testImageSetting]
Future<void> _desktopTests(
  WidgetTester tester, {
  required Finder finder,
  required List<String> imageURLs,
}) async {
  ezLog('Detected desktop');

  final bool isCupertino = Platform.isMacOS;
  ezLog(isCupertino ? 'Mac' : 'Not Mac');

  ezLog('\nFrom file');
  await _testFile(
    tester,
    isCupertino: isCupertino,
  );
  await ezTouch(tester, finder);

  ezLog('\nFrom network');
  await _testNetwork(tester, imageURLs: imageURLs);
  await ezTouch(tester, finder);

  ezLog('\nClear');
  await ezTouch(
    tester,
    find.byIcon(Platform.isIOS ? CupertinoIcons.clear : Icons.clear),
  );
  expect(
    find.byIcon(isCupertino ? CupertinoIcons.pencil : Icons.edit),
    findsOneWidget,
  );
  await ezTouch(tester, finder);

  ezLog('\nClose');
  await ezTouchText(tester, EzConfig.l10n.gClose);
}

/// Test picking images from the file system
Future<void> _testFile(
  WidgetTester tester, {
  required bool isCupertino,
}) async {
  expect(
    find.byIcon(isCupertino ? CupertinoIcons.folder : Icons.folder),
    findsOneWidget,
  );
  await ezTouchText(tester, EzConfig.l10n.gClose);
}

/// Test using images from camera
Future<void> _testCamera(
  WidgetTester tester, {
  required bool isCupertino,
}) async {
  expect(
    find.byIcon(isCupertino ? CupertinoIcons.photo_camera : Icons.photo_camera),
    findsOneWidget,
  );
  await ezTouchText(tester, EzConfig.l10n.gClose);
}

/// Test using images from the web
Future<void> _testNetwork(
  WidgetTester tester, {
  required List<String> imageURLs,
}) async {
  await ezTouch(tester, find.byIcon(Icons.computer_outlined));

  ezLog('Validating text');
  await ezFindText(tester, EzConfig.l10n.gEnterURL);

  ezLog('Validating layout');
  if (EzConfig.isApple) {
    final List<EzCupertinoAction> actions =
        (tester.widget(find.byType(EzAlertDialog).last) as EzAlertDialog)
            .cupertinoActions! as List<EzCupertinoAction>;

    expect(actions.length, 2);
    if (EzConfig.isLefty) {
      expect(actions[0].text, EzConfig.l10n.gApply);
      expect(actions[1].text, EzConfig.l10n.gCancel);
    } else {
      expect(actions[0].text, EzConfig.l10n.gCancel);
      expect(actions[1].text, EzConfig.l10n.gApply);
    }
  } else {
    final List<EzTextButton> actions =
        (tester.widget(find.byType(EzAlertDialog).last) as EzAlertDialog)
            .materialActions! as List<EzTextButton>;

    expect(actions.length, 2);
    if (EzConfig.isLefty) {
      expect(actions[0].text, EzConfig.l10n.gApply);
      expect(actions[1].text, EzConfig.l10n.gCancel);
    } else {
      expect(actions[0].text, EzConfig.l10n.gCancel);
      expect(actions[1].text, EzConfig.l10n.gApply);
    }
  }

  ezLog('Cancel');
  await ezTouchText(tester, EzConfig.l10n.gCancel);

  ezLog('Apply w/ invalid URL');
  await ezTouch(tester, find.byIcon(Icons.computer_outlined));
  await tester.enterText(find.byType(TextFormField), 'invalid');
  await ezTouchText(tester, EzConfig.l10n.gApply);

  ezLog('Apply w/ valid URL');
  await tester.enterText(find.byType(TextFormField), getRandomURL(imageURLs));
  await ezTouchText(tester, EzConfig.l10n.gApply);
  expect(
    find.byIcon(EzConfig.isApple ? CupertinoIcons.pencil : Icons.edit),
    findsNothing,
  );
}

/// Provide a [List] of [imageURLs] and one will be returned at random
String getRandomURL(List<String> imageURLs) {
  final int choice = Random().nextInt(imageURLs.length);
  return imageURLs[choice];
}
