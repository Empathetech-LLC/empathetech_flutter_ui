/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
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
  String get submitButtonText => 'Entregar';
}

class EmpathetechFrFeedbackLocalizations extends FeedbackLocalizations {
  @override
  String get draw => 'Dessiner';

  @override
  String get feedbackDescriptionText =>
      "Qu'est-ce qui préoccupe votre esprit ?";

  @override
  String get navigate => 'Interagir';

  @override
  String get submitButtonText => 'Soumettre';
}

class EmpathetechFeedbackLocalizationsDelegate
    extends GlobalFeedbackLocalizationsDelegate {
  @override
  Map<Locale, FeedbackLocalizations> get supportedLocales =>
      <Locale, FeedbackLocalizations>{
        const Locale('en'): EmpathetechEnFeedbackLocalizations(),
        const Locale('es'): EmpathetechEsFeedbackLocalizations(),
        const Locale('fr'): EmpathetechFrFeedbackLocalizations(),
      };
}
