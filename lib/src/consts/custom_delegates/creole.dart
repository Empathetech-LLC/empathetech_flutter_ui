/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

// ignore_for_file: prefer_asserts_with_message

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//* Shared *//

// consts //

const List<String> _shortWeekdays = <String>[
  'Len',
  'Mad',
  'Mèk',
  'Jed',
  'Van',
  'Sam',
  'Dim',
];

const List<String> _weekdays = <String>[
  'Lendi',
  'Madi',
  'Mèkredi',
  'Jedi',
  'Vandredi',
  'Samdi',
  'Dimanch',
];

const List<String> _shortMonths = <String>[
  'Jan',
  'Fev',
  'Mas',
  'Avr',
  'Me',
  'Jen',
  'Jiy',
  'Out',
  'Sep',
  'Okt',
  'Nov',
  'Des',
];

const List<String> _months = <String>[
  'Janvye',
  'Fevriye',
  'Mas',
  'Avril',
  'Me',
  'Jen',
  'Jiyè',
  'Out',
  'Septanm',
  'Oktòb',
  'Novanm',
  'Desanm',
];

// Functions //

String _formatDayPeriod(TimeOfDay timeOfDay) {
  return timeOfDay.hour < 12 ? 'dimaten' : 'apremidi';
}

int _getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final bool isLeapYear =
        (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    return isLeapYear ? 29 : 28;
  }

  const List<int> daysInMonth = <int>[
    31,
    -1,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31,
  ];

  return daysInMonth[month - 1];
}

//* Cupertino *//

class _CreoleCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _CreoleCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ht';

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      CreoleCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<CupertinoLocalizations> old) => false;
}

class CreoleCupertinoLocalizations implements CupertinoLocalizations {
  const CreoleCupertinoLocalizations();

  static const LocalizationsDelegate<CupertinoLocalizations> delegate =
      _CreoleCupertinoLocalizationsDelegate();

  static Future<CupertinoLocalizations> load(Locale locale) async {
    return const CreoleCupertinoLocalizations();
  }

  // consts //

  @override
  String get alertDialogLabel => 'Alèt';

  @override
  String get anteMeridiemAbbreviation => 'dimaten';

  @override
  String get backButtonLabel => 'Retounen';

  @override
  String get cancelButtonLabel => 'Anile';

  @override
  String get clearButtonLabel => 'Klè';

  @override
  String get copyButtonLabel => 'Kopi';

  @override
  String get collapsedHint => 'Elaji';

  @override
  String get cutButtonLabel => 'Koupe';

  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.dmy;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder =>
      DatePickerDateTimeOrder.date_time_dayPeriod;

  @override
  String get expandedHint => 'Tonbe';

  @override
  String get expansionTileCollapsedHint => 'tape de fwa pou elaji';

  @override
  String get expansionTileCollapsedTapHint => 'Elaji pou plis detay';

  @override
  String get expansionTileExpandedHint => 'Tape de fwa pou redui';

  @override
  String get expansionTileExpandedTapHint => 'Redwi';

  @override
  String get lookUpButtonLabel => 'Leve tèt ou';

  @override
  String get menuDismissLabel => 'Kite meni an';

  @override
  String get modalBarrierDismissLabel => 'Rejte';

  @override
  String get noSpellCheckReplacementsLabel => 'Pa gen ranplasman yo jwenn';

  @override
  String get pasteButtonLabel => 'Kole';

  @override
  String get postMeridiemAbbreviation => 'apremidi';

  @override
  String get searchTextFieldPlaceholderLabel => 'Rechèch';

  @override
  String get searchWebButtonLabel => 'Rechèch sou entènèt';

  @override
  String get selectAllButtonLabel => 'Chwazi tout';

  @override
  String get shareButtonLabel => 'Pataje...';

  @override
  List<String> get timerPickerHourLabels => const <String>['èdtan', 'èdtan'];

  @override
  List<String> get timerPickerMinuteLabels => const <String>['minit'];

  @override
  List<String> get timerPickerSecondLabels => const <String>['segonn'];

  @override
  String get todayLabel => 'Jodi a';

  // Functions //

  @override
  String datePickerDayOfMonth(int dayIndex, [int? weekDay]) {
    if (weekDay != null) {
      return ' ${_shortWeekdays[weekDay - DateTime.monday]} $dayIndex ';
    }

    return dayIndex.toString();
  }

  @override
  String datePickerHour(int hour) => hour.toString();

  @override
  String datePickerHourSemanticsLabel(int hour) => '$hour è';

  @override
  String datePickerMediumDate(DateTime date) {
    return '${_shortWeekdays[date.weekday - DateTime.monday]} '
        '${_shortMonths[date.month - DateTime.january]} '
        '${date.day.toString().padRight(2)}';
  }

  @override
  String datePickerMinute(int minute) => minute.toString().padLeft(2, '0');

  @override
  String datePickerMinuteSemanticsLabel(int minute) {
    if (minute == 1) {
      return '1 minit';
    }
    return '$minute minit';
  }

  @override
  String datePickerMonth(int monthIndex) => _months[monthIndex - 1];

  @override
  String datePickerStandaloneMonth(int monthIndex) => _months[monthIndex - 1];

  @override
  String datePickerYear(int yearIndex) => yearIndex.toString();

  @override
  String tabSemanticsLabel({required int tabIndex, required int tabCount}) {
    assert(tabIndex >= 1);
    assert(tabCount >= 1);
    return 'Onglet $tabIndex sou $tabCount';
  }

  @override
  String timerPickerHour(int hour) => hour.toString();

  @override
  String timerPickerHourLabel(int hour) => hour == 1 ? 'èdtan' : 'èdtan';

  @override
  String timerPickerMinute(int minute) => minute.toString();

  @override
  String timerPickerMinuteLabel(int minute) => 'minit';

  @override
  String timerPickerSecond(int second) => second.toString();

  @override
  String timerPickerSecondLabel(int second) => 'segonn';
}

//* Material *//

class _CreoleMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _CreoleMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ht';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      CreoleMaterialLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<MaterialLocalizations> old) => false;
}

class CreoleMaterialLocalizations implements MaterialLocalizations {
  const CreoleMaterialLocalizations();

  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      _CreoleMaterialLocalizationsDelegate();

  static Future<MaterialLocalizations> load(Locale locale) async {
    return const CreoleMaterialLocalizations();
  }

  // consts //

  @override
  String get alertDialogLabel => 'Alèt';

  @override
  String get anteMeridiemAbbreviation => 'dimaten';

  @override
  String get backButtonTooltip => 'Retounen';

  @override
  String get bottomSheetLabel => 'Fèy anba';

  @override
  String get calendarModeButtonLabel => 'Chanje nan kalandriye a';

  @override
  String get cancelButtonLabel => 'Anile';

  @override
  String get clearButtonTooltip => 'Tèks klè';

  @override
  String get closeButtonLabel => 'Fèmen';

  @override
  String get closeButtonTooltip => 'Fèmen';

  @override
  String get collapsedHint => 'Elaji';

  @override
  String get collapsedIconTapHint => 'Elaji';

  @override
  String get continueButtonLabel => 'Kontinye';

  @override
  String get copyButtonLabel => 'Kopi';

  @override
  String get currentDateLabel => 'Jodi a';

  @override
  String get cutButtonLabel => 'Koupe';

  @override
  String get dateHelpText => 'dd/mm/yyyy';

  @override
  String get dateInputLabel => 'Antre Dat';

  @override
  String get dateOutOfRangeLabel => 'Pa nan ranje.';

  @override
  String get datePickerHelpText => 'Chwazi dat';

  @override
  String get dateRangeEndLabel => 'Dat Finisman';

  @override
  String get dateRangePickerHelpText => 'Chwazi yon seri';

  @override
  String get dateRangeStartLabel => 'Dat kòmansman';

  @override
  String get dateSeparator => '/';

  @override
  String get deleteButtonTooltip => 'Efase';

  @override
  String get dialModeButtonLabel => 'Chanje nan mòd seleksyon kadran';

  @override
  String get dialogLabel => 'Dyalòg';

  @override
  String get drawerLabel => 'Meni navigasyon';

  @override
  String get expandedHint => 'Tonbe';

  @override
  String get expandedIconTapHint => 'Redwi';

  @override
  String get expansionTileCollapsedHint => 'tape de fwa pou elaji';

  @override
  String get expansionTileCollapsedTapHint => 'Elaji pou plis detay';

  @override
  String get expansionTileExpandedHint => 'Tape de fwa pou redui';

  @override
  String get expansionTileExpandedTapHint => 'Redwi';

  @override
  int get firstDayOfWeekIndex => 0;

  @override
  String get firstPageTooltip => 'Premye paj la';

  @override
  String get hideAccountsLabel => 'Kache kont yo';

  @override
  String get inputDateModeButtonLabel => 'Chanje pou antre';

  @override
  String get inputTimeModeButtonLabel => 'Chanje nan mòd antre tèks';

  @override
  String get invalidDateFormatLabel => 'Fòma ki pa valab.';

  @override
  String get invalidDateRangeLabel => 'Entèval ki pa valab.';

  @override
  String get invalidTimeLabel => 'Antre yon lè ki valab';

  @override
  String get keyboardKeyAlt => 'Alt';

  @override
  String get keyboardKeyAltGraph => 'AltGr';

  @override
  String get keyboardKeyBackspace => 'Retounen';

  @override
  String get keyboardKeyCapsLock => 'Majiskil';

  @override
  String get keyboardKeyChannelDown => 'Chanèl Desann';

  @override
  String get keyboardKeyChannelUp => 'Chanèl Anlè';

  @override
  String get keyboardKeyControl => 'Ctrl';

  @override
  String get keyboardKeyDelete => 'Efase';

  @override
  String get keyboardKeyEject => 'Ejete';

  @override
  String get keyboardKeyEnd => 'Fen';

  @override
  String get keyboardKeyEscape => 'Chape';

  @override
  String get keyboardKeyFn => 'Fn';

  @override
  String get keyboardKeyHome => 'Lakay';

  @override
  String get keyboardKeyInsert => 'Mete';

  @override
  String get keyboardKeyMeta => 'Meta';

  @override
  String get keyboardKeyMetaMacOs => 'Command';

  @override
  String get keyboardKeyMetaWindows => 'Win';

  @override
  String get keyboardKeyNumLock => 'Blokaj Chib';

  @override
  String get keyboardKeyNumpad0 => 'Chib 0';

  @override
  String get keyboardKeyNumpad1 => 'Chib 1';

  @override
  String get keyboardKeyNumpad2 => 'Chib 2';

  @override
  String get keyboardKeyNumpad3 => 'Chib 3';

  @override
  String get keyboardKeyNumpad4 => 'Chib 4';

  @override
  String get keyboardKeyNumpad5 => 'Chib 5';

  @override
  String get keyboardKeyNumpad6 => 'Chib 6';

  @override
  String get keyboardKeyNumpad7 => 'Chib 7';

  @override
  String get keyboardKeyNumpad8 => 'Chib 8';

  @override
  String get keyboardKeyNumpad9 => 'Chib 9';

  @override
  String get keyboardKeyNumpadAdd => 'Chib +';

  @override
  String get keyboardKeyNumpadComma => 'Chib ,';

  @override
  String get keyboardKeyNumpadDecimal => 'Chib .';

  @override
  String get keyboardKeyNumpadDivide => 'Chib /';

  @override
  String get keyboardKeyNumpadEnter => 'Chib Antre';

  @override
  String get keyboardKeyNumpadEqual => 'Chib =';

  @override
  String get keyboardKeyNumpadMultiply => 'Chib *';

  @override
  String get keyboardKeyNumpadParenLeft => 'Chib (';

  @override
  String get keyboardKeyNumpadParenRight => 'Chib )';

  @override
  String get keyboardKeyNumpadSubtract => 'Chib -';

  @override
  String get keyboardKeyPageDown => 'PgDown';

  @override
  String get keyboardKeyPageUp => 'PgUp';

  @override
  String get keyboardKeyPower => 'Pouvwa';

  @override
  String get keyboardKeyPowerOff => 'Etenn';

  @override
  String get keyboardKeyPrintScreen => 'Enprime ekran';

  @override
  String get keyboardKeyScrollLock => 'Blokaj Defile';

  @override
  String get keyboardKeySelect => 'Chwazi';

  @override
  String get keyboardKeyShift => 'Chanjman';

  @override
  String get keyboardKeySpace => 'Espas';

  @override
  String get lastPageTooltip => 'Dènye paj la';

  @override
  String get licensesPageTitle => 'Lisans';

  @override
  String get lookUpButtonLabel => 'Gade anlè';

  @override
  String get menuBarMenuLabel => 'Meni ba meni';

  @override
  String get menuDismissLabel => 'Kite meni an';

  @override
  String get modalBarrierDismissLabel => 'Rejte';

  @override
  String get moreButtonTooltip => 'Plis';

  @override
  List<String> get narrowWeekdays => _shortWeekdays;

  @override
  String get nextMonthTooltip => 'Mwa pwochen an';

  @override
  String get nextPageTooltip => 'Paj kap vini an';

  @override
  String get okButtonLabel => 'OK';

  @override
  String get openAppDrawerTooltip => 'Louvri meni navigasyon an';

  @override
  String get pasteButtonLabel => 'Kole';

  @override
  String get popupMenuLabel => 'Meni popup';

  @override
  String get postMeridiemAbbreviation => 'apremidi';

  @override
  String get previousMonthTooltip => 'Mwa anvan an';

  @override
  String get previousPageTooltip => 'Paj anvan an';

  @override
  String get refreshIndicatorSemanticLabel => 'Rafrechi';

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
  String get rowsPerPageTitle => 'Ranje pa paj:';

  @override
  String get saveButtonLabel => 'Sove';

  @override
  String get scanTextButtonLabel => 'Eskane tèks';

  @override
  String get scrimLabel => 'Kanvay';

  @override
  ScriptCategory get scriptCategory => ScriptCategory.englishLike;

  @override
  String get searchFieldLabel => 'Rechèch';

  @override
  String get searchWebButtonLabel => 'Rechèch sou entènèt';

  @override
  String get selectAllButtonLabel => 'Chwazi tout';

  @override
  String get selectedDateLabel => 'Chwazi';

  @override
  String get selectYearSemanticsLabel => 'Chwazi ane a';

  @override
  String get shareButtonLabel => 'Pataje';

  @override
  String get showAccountsLabel => 'Montre kont yo';

  @override
  String get showMenuTooltip => 'Montre meni an';

  @override
  String get signedInLabel => 'Konekte';

  @override
  String get timePickerDialHelpText => 'Chwazi lè';

  @override
  String get timePickerHourLabel => 'Èdtan';

  @override
  String get timePickerHourModeAnnouncement => 'Chwazi lè';

  @override
  String get timePickerInputHelpText => 'Antre lè a';

  @override
  String get timePickerMinuteLabel => 'Minit';

  @override
  String get timePickerMinuteModeAnnouncement => 'Chwazi minit';

  @override
  String get unspecifiedDate => 'Dat';

  @override
  String get unspecifiedDateRange => 'Entèval Dat';

  @override
  String get viewLicensesButtonLabel => 'Gade lisans yo';

  // Functions //

  @override
  String aboutListTileTitle(String applicationName) =>
      'A pwopo $applicationName';

  @override
  String dateRangeEndDateSemanticLabel(String formattedDate) =>
      'Dat fen $formattedDate';

  @override
  String dateRangeStartDateSemanticLabel(String formattedDate) =>
      'Dat kòmansman $formattedDate';

  @override
  String formatCompactDate(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString().padLeft(4, '0');

    return '$day/$month/$year';
  }

  @override
  String formatDecimal(int number) {
    if (number > -1000 && number < 1000) return number.toString();

    final String digits = number.abs().toString();
    final StringBuffer result = StringBuffer(number < 0 ? '-' : '');
    final int maxDigitIndex = digits.length - 1;

    for (int i = 0; i <= maxDigitIndex; i += 1) {
      result.write(digits[i]);
      if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) {
        result.write('.');
      }
    }

    return result.toString();
  }

  @override
  String formatFullDate(DateTime date) {
    final String month = _months[date.month - DateTime.january];
    return '${_weekdays[date.weekday - DateTime.monday]}, $month ${date.day}, ${date.year}';
  }

  @override
  String formatHour(TimeOfDay timeOfDay, {bool alwaysUse24HourFormat = false}) {
    final TimeOfDayFormat format =
        timeOfDayFormat(alwaysUse24HourFormat: alwaysUse24HourFormat);
    switch (format) {
      case TimeOfDayFormat.h_colon_mm_space_a:
        return formatDecimal(
            timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod);
      case TimeOfDayFormat.HH_colon_mm:
        return timeOfDay.hour.toString();
      case TimeOfDayFormat.a_space_h_colon_mm:
      case TimeOfDayFormat.frenchCanadian:
      case TimeOfDayFormat.H_colon_mm:
      case TimeOfDayFormat.HH_dot_mm:
        throw AssertionError('$runtimeType pa sipòte $format.');
    }
  }

  @override
  String formatMediumDate(DateTime date) {
    final String day = _shortWeekdays[date.weekday - DateTime.monday];
    final String month = _shortMonths[date.month - DateTime.january];
    return '$day, $month ${date.day}';
  }

  @override
  String formatMinute(TimeOfDay timeOfDay) {
    final int minute = timeOfDay.minute;
    return minute < 10 ? '0$minute' : minute.toString();
  }

  @override
  String formatMonthYear(DateTime date) {
    final String year = formatYear(date);
    final String month = _months[date.month - DateTime.january];
    return '$month $year';
  }

  @override
  String formatShortDate(DateTime date) {
    final String month = _shortMonths[date.month - DateTime.january];
    return '$month ${date.day}, ${date.year}';
  }

  @override
  String formatShortMonthDay(DateTime date) {
    final String month = _shortMonths[date.month - DateTime.january];
    return '$month ${date.day}';
  }

  @override
  String formatTimeOfDay(
    TimeOfDay timeOfDay, {
    bool alwaysUse24HourFormat = false,
  }) {
    final StringBuffer buffer = StringBuffer();

    buffer
      ..write(
          formatHour(timeOfDay, alwaysUse24HourFormat: alwaysUse24HourFormat))
      ..write(':')
      ..write(formatMinute(timeOfDay));

    if (alwaysUse24HourFormat) return '$buffer';

    buffer
      ..write(' ')
      ..write(_formatDayPeriod(timeOfDay));

    return '$buffer';
  }

  @override
  String formatYear(DateTime date) => date.year.toString();

  @override
  String licensesPackageDetailText(int licenseCount) {
    assert(licenseCount >= 0);
    return switch (licenseCount) {
      0 => 'Pa gen lisans.',
      1 => '1 lisans.',
      _ => '$licenseCount lisans.',
    };
  }

  @override
  String pageRowsInfoTitle(
      int firstRow, int lastRow, int rowCount, bool rowCountIsApproximate) {
    return rowCountIsApproximate
        ? '$firstRow-$lastRow sou apeprè $rowCount'
        : '$firstRow-$lastRow sou $rowCount';
  }

  @override
  DateTime? parseCompactDate(String? inputString) {
    if (inputString == null) return null;

    final List<String> inputParts = inputString.split('/');
    if (inputParts.length != 3) return null;

    final int? month = int.tryParse(inputParts[1], radix: 10);
    if (month == null || month < 1 || month > 12) return null;

    final int? year = int.tryParse(inputParts[2], radix: 10);
    if (year == null || year < 1) return null;

    final int? day = int.tryParse(inputParts[0], radix: 10);
    if (day == null || day < 1 || day > _getDaysInMonth(year, month)) {
      return null;
    }

    try {
      return DateTime(year, month, day);
    } on ArgumentError {
      return null;
    }
  }

  @override
  String remainingTextFieldCharacterCount(int remaining) {
    return switch (remaining) {
      0 => 'Pa gen karaktè ki rete',
      1 => '1 karaktè rete',
      _ => '$remaining karaktè ki rete',
    };
  }

  @override
  String scrimOnTapHint(String modalRouteContentName) =>
      'Fèmen $modalRouteContentName';

  @override
  String selectedRowCountTitle(int selectedRowCount) {
    return switch (selectedRowCount) {
      0 => 'Pa gen atik ki chwazi',
      1 => '1 atik chwazi',
      _ => '$selectedRowCount atik chwazi',
    };
  }

  @override
  String tabLabel({required int tabIndex, required int tabCount}) {
    assert(tabIndex >= 1);
    assert(tabCount >= 1);
    return 'Onglet $tabIndex sou $tabCount';
  }

  @override
  TimeOfDayFormat timeOfDayFormat({bool alwaysUse24HourFormat = false}) {
    return alwaysUse24HourFormat
        ? TimeOfDayFormat.HH_colon_mm
        : TimeOfDayFormat.h_colon_mm_space_a;
  }
}

//* Widgets *//

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

class CreoleWidgetsLocalizations extends WidgetsLocalizations {
  // consts //

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get radioButtonUnselectedLabel => 'Pa chwazi';

  @override
  String get reorderItemUp => 'Monte';

  @override
  String get reorderItemDown => 'Desann';

  @override
  String get reorderItemLeft => 'Deplase agoch';

  @override
  String get reorderItemRight => 'Deplase adwat';

  @override
  String get reorderItemToStart => 'Deplase nan kòmansman an';

  @override
  String get reorderItemToEnd => 'Deplase nan fen an';

  @override
  String get selectAllButtonLabel => 'Chwazi tout';

  @override
  String get copyButtonLabel => 'Kopi';

  @override
  String get cutButtonLabel => 'Koupe';

  @override
  String get pasteButtonLabel => 'Kole';

  @override
  String get shareButtonLabel => 'Pataje...';

  @override
  String get lookUpButtonLabel => 'Leve tèt ou';

  @override
  String get searchWebButtonLabel => 'Rechèch sou entènèt';
}
