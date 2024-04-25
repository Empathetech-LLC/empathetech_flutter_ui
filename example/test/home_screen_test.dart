import 'package:example/main.dart';
import 'package:example/screens/screens.dart';
import 'package:example/widgets/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

void main() {
  testWidgets('Click all the home screen things', (WidgetTester tester) async {
    await tester.runAsync(() async {
      EzConfig.init(
        // Paths to any locally stored images the app uses
        assetPaths: <String>{},

        preferences: await SharedPreferences.getInstance(),

        // Your brand colors, custom styling, etc
        defaults: empathetechConfig,
      );

      await tester.pumpWidget(const OpenUI());
    });
  });
}
