/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'dart:math';
import 'package:flutter/material.dart';

abstract class BaseTextStyleProvider extends ChangeNotifier {
  TextStyle _style;
  int _id;

  BaseTextStyleProvider(TextStyle style)
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

class DisplayTextStyleProvider extends BaseTextStyleProvider {
  final Color? _textColor;

  DisplayTextStyleProvider(Color? color)
      : _textColor = color,
        super(buildDisplay(color));

  void reset() {
    _style = buildDisplayFromDefaults(_textColor);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }
}

class HeadlineTextStyleProvider extends BaseTextStyleProvider {
  final Color? _textColor;

  HeadlineTextStyleProvider(Color? color)
      : _textColor = color,
        super(buildHeadline(color));

  void reset() {
    _style = buildHeadlineFromDefaults(_textColor);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }
}

class TitleTextStyleProvider extends BaseTextStyleProvider {
  final Color? _textColor;

  TitleTextStyleProvider(Color? color)
      : _textColor = color,
        super(buildTitle(color));

  void reset() {
    _style = buildTitleFromDefaults(_textColor);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }
}

class BodyTextStyleProvider extends BaseTextStyleProvider {
  final Color? _textColor;

  BodyTextStyleProvider(Color? color)
      : _textColor = color,
        super(buildBody(color));

  void reset() {
    _style = buildBodyFromDefaults(_textColor);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }
}

class LabelTextStyleProvider extends BaseTextStyleProvider {
  final Color? _textColor;

  LabelTextStyleProvider(Color? color)
      : _textColor = color,
        super(buildLabel(color));

  void reset() {
    _style = buildLabelFromDefaults(_textColor);
    _id = Random().nextInt(rMax);
    notifyListeners();
  }
}
