/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class DisplayTextStyleProvider extends ChangeNotifier {
  TextStyle _style = buildDisplay();

  TextStyle get value => _style;

  /// Run [fuseWithGFont] on the current [TextStyle] with the passed [gFont]
  void fuse(String gFont) {
    _style = fuseWithGFont(starter: _style, gFont: gFont);
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

class HeadlineTextStyleProvider extends ChangeNotifier {
  TextStyle _style = buildHeadline();

  TextStyle get value => _style;

  /// Run [fuseWithGFont] on the current [TextStyle] with the passed [gFont]
  void fuse(String gFont) {
    _style = fuseWithGFont(starter: _style, gFont: gFont);
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

class TitleTextStyleProvider extends ChangeNotifier {
  TextStyle _style = buildTitle();

  TextStyle get value => _style;

  /// Run [fuseWithGFont] on the current [TextStyle] with the passed [gFont]
  void fuse(String gFont) {
    _style = fuseWithGFont(starter: _style, gFont: gFont);
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

class BodyTextStyleProvider extends ChangeNotifier {
  TextStyle _style = buildBody();

  TextStyle get value => _style;

  /// Run [fuseWithGFont] on the current [TextStyle] with the passed [gFont]
  void fuse(String gFont) {
    _style = fuseWithGFont(starter: _style, gFont: gFont);
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

class LabelTextStyleProvider extends ChangeNotifier {
  TextStyle _style = buildLabel();

  TextStyle get value => _style;

  /// Run [fuseWithGFont] on the current [TextStyle] with the passed [gFont]
  void fuse(String gFont) {
    _style = fuseWithGFont(starter: _style, gFont: gFont);
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
