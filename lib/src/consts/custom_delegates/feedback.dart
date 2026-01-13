/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
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
  String get feedbackDescriptionText => 'Cuéntanos';

  @override
  String get navigate => 'Interactuar';

  @override
  String get submitButtonText => 'Enviar';
}

class EzFilFeedback extends FeedbackLocalizations {
  @override
  String get draw => 'Iguhit';

  @override
  String get feedbackDescriptionText => 'Ano ang nasa isip mo?';

  @override
  String get navigate => 'Makipag-ugnayan';

  @override
  String get submitButtonText => 'Isumite';
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

class EzZhFeedback extends FeedbackLocalizations {
  @override
  String get draw => '画画';

  @override
  String get feedbackDescriptionText => '您在想什么？';

  @override
  String get navigate => '互动';

  @override
  String get submitButtonText => '提交';
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
        filipino: EzFilFeedback(),
        french: EzFrFeedback(),
        creole: EzHtFeedback(),
        chinese: EzZhFeedback(),
      };
}
