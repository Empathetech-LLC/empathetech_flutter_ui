/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../widgets/export.dart';

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class GeneratorScreen extends StatelessWidget {
  final String title;

  final Widget header;
  final List<Widget> body;

  const GeneratorScreen({
    super.key,
    required this.title,
    required this.header,
    required this.body,
  });

  @override
  Widget build(BuildContext context) => OpenUIScaffold(
        title: title,
        body: EzScreen(
          child: EzScrollView(children: <Widget>[
            Center(
              child: SizedBox(height: heightOf(context) / 3, child: header),
            ),
            const EzDivider(),
            ...body,
          ]),
        ),
      );
}
