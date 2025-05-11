/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/widgets.dart';

class CreoleWidgetsLocalizations extends WidgetsLocalizations {
  @override
  String get reorderItemDown => 'Desann';

  @override
  String get reorderItemLeft => 'Deplase agoch';

  @override
  String get reorderItemRight => 'Deplase adwat';

  @override
  String get reorderItemToEnd => 'Deplase nan fen an';

  @override
  String get reorderItemToStart => 'Deplase nan kòmansman an';

  @override
  String get reorderItemUp => 'Monte';

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class CreoleWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const CreoleWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ht';

  @override
  Future<WidgetsLocalizations> load(Locale locale) async {
    return CreoleWidgetsLocalizations();
  }

  @override
  bool shouldReload(LocalizationsDelegate<WidgetsLocalizations> old) => false;
}
