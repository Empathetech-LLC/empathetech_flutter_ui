/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:feedback/feedback.dart';

class EmpathetechEnFeedbackLocalizations extends FeedbackLocalizations {
  @override
  String get draw => 'Draw';

  @override
  String get feedbackDescriptionText => "What's on your mind?";

  @override
  String get navigate => 'Interact';

  @override
  String get submitButtonText => 'Submit';
}

class EmpathetechEsFeedbackLocalizations extends FeedbackLocalizations {
  @override
  String get draw => 'Dibujar';

  @override
  String get feedbackDescriptionText => '¿Qué tienes en mente?';

  @override
  String get navigate => 'Interactuar';

  @override
  String get submitButtonText => 'Enviar comentarios';
}

class EmpathetechFeedbackLocalizationsDelegate
    extends GlobalFeedbackLocalizationsDelegate {
  @override
  Map<Locale, FeedbackLocalizations> get supportedLocales =>
      <Locale, FeedbackLocalizations>{
        const Locale('en'): EmpathetechEnFeedbackLocalizations(),
        const Locale('es'): EmpathetechEsFeedbackLocalizations(),
      };
}
