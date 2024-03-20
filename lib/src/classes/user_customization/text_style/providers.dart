/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';

class DisplayTextStyleProvider extends ChangeNotifier {
  TextStyle _style = buildDisplay();

  TextStyle get value => _style;

  void set(TextStyle newStyle) {
    _style = newStyle;
    notifyListeners();
  }

  /// Run [fuseWithGFont] on the current [TextStyle] with the passed [gFont]
  void fuse(String gFont) {
    _style = fuseWithGFont(starter: _style, gFont: gFont);
    notifyListeners();
  }
}

class HeadlineTextStyleProvider extends ChangeNotifier {
  TextStyle _style = buildHeadline();

  TextStyle get value => _style;

  void set(TextStyle newStyle) {
    _style = newStyle;
    notifyListeners();
  }

  /// Run [fuseWithGFont] on the current [TextStyle] with the passed [gFont]
  void fuse(String gFont) {
    _style = fuseWithGFont(starter: _style, gFont: gFont);
    notifyListeners();
  }
}

class TitleTextStyleProvider extends ChangeNotifier {
  TextStyle _style = buildTitle();

  TextStyle get value => _style;

  void set(TextStyle newStyle) {
    _style = newStyle;
    notifyListeners();
  }

  /// Run [fuseWithGFont] on the current [TextStyle] with the passed [gFont]
  void fuse(String gFont) {
    _style = fuseWithGFont(starter: _style, gFont: gFont);
    notifyListeners();
  }
}

class BodyTextStyleProvider extends ChangeNotifier {
  TextStyle _style = buildBody();

  TextStyle get value => _style;

  void set(TextStyle newStyle) {
    _style = newStyle;
    notifyListeners();
  }

  /// Run [fuseWithGFont] on the current [TextStyle] with the passed [gFont]
  void fuse(String gFont) {
    _style = fuseWithGFont(starter: _style, gFont: gFont);
    notifyListeners();
  }
}

class LabelTextStyleProvider extends ChangeNotifier {
  TextStyle _style = buildLabel();

  TextStyle get value => _style;

  void set(TextStyle newStyle) {
    _style = newStyle;
    notifyListeners();
  }

  /// Run [fuseWithGFont] on the current [TextStyle] with the passed [gFont]
  void fuse(String gFont) {
    _style = fuseWithGFont(starter: _style, gFont: gFont);
    notifyListeners();
  }
}
