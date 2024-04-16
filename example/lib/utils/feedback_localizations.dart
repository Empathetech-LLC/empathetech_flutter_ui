import 'package:flutter/material.dart';
import 'package:feedback/feedback.dart';

class OpenUIEnFeedbackLocalizations extends FeedbackLocalizations {
  @override
  String get draw => 'Draw';

  @override
  String get feedbackDescriptionText => "What's on your mind?";

  @override
  String get navigate => 'Interact';

  @override
  String get submitButtonText => 'Submit feedback';
}

class OpenUIEsFeedbackLocalizations extends FeedbackLocalizations {
  @override
  String get draw => 'Dibujar';

  @override
  String get feedbackDescriptionText => '¿Qué tienes en mente?';

  @override
  String get navigate => 'Interactuar';

  @override
  String get submitButtonText => 'Enviar comentarios';
}

class OpenUIFeedbackLocalizationsDelegate
    extends GlobalFeedbackLocalizationsDelegate {
  @override
  Map<Locale, FeedbackLocalizations> get supportedLocales =>
      <Locale, FeedbackLocalizations>{
        const Locale('en'): OpenUIEnFeedbackLocalizations(),
        const Locale('es'): OpenUIEsFeedbackLocalizations(),
      };
}
