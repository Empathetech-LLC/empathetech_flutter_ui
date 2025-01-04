/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

/// Tells user what to do next
Widget successPage(BuildContext context, String message, TextTheme textTheme) =>
    EzScrollView(
      children: <Widget>[
        Text(
          'Success!',
          style: textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        Text(
          message,
          style: textTheme.bodyLarge
              ?.copyWith(fontSize: textTheme.titleLarge?.fontSize),
          textAlign: TextAlign.center,
        ),
      ],
    );

/// Displays the error
Widget failurePage(BuildContext context, String message, TextTheme textTheme) =>
    EzScrollView(
      children: <Widget>[
        Text(
          'Failure',
          style: textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        Text(
          message,
          style: textTheme.bodyLarge
              ?.copyWith(fontSize: textTheme.titleLarge?.fontSize),
          textAlign: TextAlign.center,
        ),
      ],
    );
