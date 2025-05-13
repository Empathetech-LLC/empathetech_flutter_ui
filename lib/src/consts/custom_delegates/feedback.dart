/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:feedback/feedback.dart';

class EzArFeedback extends FeedbackLocalizations {
  @override
  String get draw => 'ارسم';

  @override
  String get feedbackDescriptionText => 'ما الذي يدور في ذهنك؟';

  @override
  String get navigate => 'تفاعل';

  @override
  String get submitButtonText => 'أرسل';
}

class EzEnFeedback extends FeedbackLocalizations {
  @override
  String get draw => 'Draw';

  @override
  String get feedbackDescriptionText => "What's on your mind?";

  @override
  String get navigate => 'Interact';

  @override
  String get submitButtonText => 'Submit';
}

class EzEsFeedback extends FeedbackLocalizations {
  @override
  String get draw => 'Dibujar';

  @override
  String get feedbackDescriptionText => '¿Qué tienes en mente?';

  @override
  String get navigate => 'Interactuar';

  @override
  String get submitButtonText => 'Entregar';
}

class EzFrFeedback extends FeedbackLocalizations {
  @override
  String get draw => 'Dessiner';

  @override
  String get feedbackDescriptionText => "Qu'est-ce qui vous préoccupe ?";

  @override
  String get navigate => 'Interagir';

  @override
  String get submitButtonText => 'Envoyer';
}

class EzHtFeedback extends FeedbackLocalizations {
  @override
  String get draw => 'Desine';

  @override
  String get feedbackDescriptionText => 'A kisa ou ap panse?';

  @override
  String get navigate => 'Entèraji';

  @override
  String get submitButtonText => 'Soumèt';
}

class EzFeedbackLD extends GlobalFeedbackLocalizationsDelegate {
  @override
  Map<Locale, FeedbackLocalizations> get supportedLocales =>
      <Locale, FeedbackLocalizations>{
        arabic: EzArFeedback(),
        egyptianArabic: EzArFeedback(),
        english: EzEnFeedback(),
        americanEnglish: EzEnFeedback(),
        spanish: EzEsFeedback(),
        french: EzFrFeedback(),
        creole: EzHtFeedback(),
      };
}
