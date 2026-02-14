/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

abstract class EzTextStyleProvider extends ChangeNotifier {
  TextStyle _style;

  /// [ChangeNotifier] for tracking and modifying a [TextStyle]
  EzTextStyleProvider(TextStyle style) : _style = style;

  TextStyle get value => _style;

  /// Run [fuseWithGFont] on the current [TextStyle] with the passed [gFont]
  void fuse(String gFont) {
    _style = fuseWithGFont(starter: _style, gFont: gFont);
    notifyListeners();
  }

  /// Update the [TextStyle.color] to the passed [color]
  void redraw(Color? color) {
    _style = _style.copyWith(color: color);
    notifyListeners();
  }

  /// Update the [TextStyle.fontSize] to the passed [size]
  void resize(double size) {
    _style = _style.copyWith(fontSize: size);
    notifyListeners();
  }

  /// Toggle the [TextStyle.fontWeight] based on the passed [bold]
  void bold(bool bold) {
    _style =
        _style.copyWith(fontWeight: bold ? FontWeight.bold : FontWeight.normal);
    notifyListeners();
  }

  /// Toggle the [TextStyle.fontStyle] based on the passed [italic]
  void italic(bool italic) {
    _style = _style.copyWith(
        fontStyle: italic ? FontStyle.italic : FontStyle.normal);
    notifyListeners();
  }

  /// Toggle the [TextStyle.decoration] based on the passed [underline]
  void underline(bool underline) {
    _style = _style.copyWith(
        decoration: underline ? TextDecoration.underline : TextDecoration.none);
    notifyListeners();
  }

  /// Update the [TextStyle.letterSpacing] to the passed [spacing]
  void setLetterSpacing(double spacing) {
    _style = _style.copyWith(letterSpacing: spacing);
    notifyListeners();
  }

  /// Update the [TextStyle.wordSpacing] to the passed [spacing]
  void setWordSpacing(double spacing) {
    _style = _style.copyWith(wordSpacing: spacing);
    notifyListeners();
  }

  /// Update the [TextStyle.height] to the passed [height]
  void setHeight(double height) {
    _style = _style.copyWith(height: height);
    notifyListeners();
  }
}

class EzDisplayStyleProvider extends EzTextStyleProvider {
  /// [EzTextStyleProvider] for [ezDisplayStyle]s values
  EzDisplayStyleProvider() : super(ezDisplayStyle(null));

  /// Reset via [ezDefaultDisplayStyle]
  void reset() {
    _style = ezDefaultDisplayStyle(null);
    notifyListeners();
  }
}

class EzHeadlineStyleProvider extends EzTextStyleProvider {
  /// [EzTextStyleProvider] for [ezHeadlineStyle]s values
  EzHeadlineStyleProvider() : super(ezHeadlineStyle(null));

  /// Reset via [ezDefaultHeadlineStyle]
  void reset() {
    _style = ezDefaultHeadlineStyle(null);
    notifyListeners();
  }
}

class EzTitleStyleProvider extends EzTextStyleProvider {
  /// [EzTextStyleProvider] for [ezTitleStyle]s values
  EzTitleStyleProvider() : super(ezTitleStyle(null));

  /// Reset via [ezDefaultTitleStyle]
  void reset() {
    _style = ezDefaultTitleStyle(null);
    notifyListeners();
  }
}

class EzBodyStyleProvider extends EzTextStyleProvider {
  /// [EzTextStyleProvider] for [ezBodyStyle]s values
  EzBodyStyleProvider() : super(ezBodyStyle(null));

  /// Reset via [ezDefaultBodyStyle]
  void reset() {
    _style = ezDefaultBodyStyle(null);
    notifyListeners();
  }
}

class EzLabelStyleProvider extends EzTextStyleProvider {
  /// [EzTextStyleProvider] for [ezLabelStyle]s values
  EzLabelStyleProvider() : super(ezLabelStyle(null));

  /// Reset via [ezDefaultLabelStyle]
  void reset() {
    _style = ezDefaultLabelStyle(null);
    notifyListeners();
  }
}
