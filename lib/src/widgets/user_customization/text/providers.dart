/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

abstract class EzTextStyleProvider extends ChangeNotifier {
  TextStyle _style;
  int _id;

  /// [ChangeNotifier] for tracking and modifying a [TextStyle]
  EzTextStyleProvider(TextStyle style)
      : _style = style,
        _id = Random().nextInt(rMax);

  TextStyle get value => _style;

  int get id => _id;

  /// Run [fuseWithGFont] on the current [TextStyle] with the passed [gFont]
  void fuse(String gFont) {
    _style = fuseWithGFont(starter: _style, gFont: gFont);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }

  /// Update the [TextStyle.color] to the passed [color]
  void redraw(Color? color) {
    _style = _style.copyWith(color: color);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }

  /// Update the [TextStyle.fontSize] to the passed [size]
  void resize(double size) {
    _style = _style.copyWith(fontSize: size);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }

  /// Toggle the [TextStyle.fontWeight] based on the passed [bold]
  void bold(bool bold) {
    _style =
        _style.copyWith(fontWeight: bold ? FontWeight.bold : FontWeight.normal);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }

  /// Toggle the [TextStyle.fontStyle] based on the passed [italic]
  void italic(bool italic) {
    _style = _style.copyWith(
        fontStyle: italic ? FontStyle.italic : FontStyle.normal);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }

  /// Toggle the [TextStyle.decoration] based on the passed [underline]
  void underline(bool underline) {
    _style = _style.copyWith(
        decoration: underline ? TextDecoration.underline : TextDecoration.none);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }

  /// Update the [TextStyle.letterSpacing] to the passed [spacing]
  void setLetterSpacing(double spacing) {
    _style = _style.copyWith(letterSpacing: spacing);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }

  /// Update the [TextStyle.wordSpacing] to the passed [spacing]
  void setWordSpacing(double spacing) {
    _style = _style.copyWith(wordSpacing: spacing);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }

  /// Update the [TextStyle.height] to the passed [height]
  void setHeight(double height) {
    _style = _style.copyWith(height: height);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }
}

class EzDisplayStyleProvider extends EzTextStyleProvider {
  /// [EzTextStyleProvider] for [ezDisplayStyle]s values
  EzDisplayStyleProvider() : super(ezDisplayStyle(null));

  /// Reset via [ezDefaultDisplayStyle]
  void reset() {
    _style = ezDefaultDisplayStyle(null);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }
}

class EzHeadlineStyleProvider extends EzTextStyleProvider {
  /// [EzTextStyleProvider] for [ezHeadlineStyle]s values
  EzHeadlineStyleProvider() : super(ezHeadlineStyle(null));

  /// Reset via [ezDefaultHeadlineStyle]
  void reset() {
    _style = ezDefaultHeadlineStyle(null);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }
}

class EzTitleStyleProvider extends EzTextStyleProvider {
  /// [EzTextStyleProvider] for [ezTitleStyle]s values
  EzTitleStyleProvider(Color? color) : super(ezTitleStyle(color));

  /// Reset via [ezDefaultTitleStyle]
  void reset() {
    _style = ezDefaultTitleStyle(null);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }
}

class EzBodyStyleProvider extends EzTextStyleProvider {
  /// [EzTextStyleProvider] for [ezBodyStyle]s values
  EzBodyStyleProvider(Color? color) : super(ezBodyStyle(color));

  /// Reset via [ezDefaultBodyStyle]
  void reset() {
    _style = ezDefaultBodyStyle(null);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }
}

class EzLabelStyleProvider extends EzTextStyleProvider {
  /// [EzTextStyleProvider] for [ezLabelStyle]s values
  EzLabelStyleProvider(Color? color) : super(ezLabelStyle(color));

  /// Reset via [ezDefaultLabelStyle]
  void reset() {
    _style = ezDefaultLabelStyle(null);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }
}
